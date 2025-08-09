import 'package:d_sdk/core/code_generator.dart';
import 'package:d_sdk/core/data_instance/form_data_util.dart';
import 'package:d_sdk/core/sync/sync_summary_model.dart';
import 'package:d_sdk/core/util/string_extension.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/dao/data_submissions_dao_expression_extension.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/extensions/data_submission.extension.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/data_submissions.table.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

part 'data_submissions_dao.g.dart';

@DriftAccessor(tables: [DataInstances])
class DataInstancesDao extends DatabaseAccessor<AppDatabase>
    with _$DataInstancesDaoMixin, BaseDaoMixin<DataInstance> {
  DataInstancesDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'dataSubmission';

  @override
  String get resourcePath => '$resourceName/objects?paged=false';

  @override
  DataInstance fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final form = data['form'];
    final version = data['version'];
    final String formId = form != null && version != null
        ? '${form}_$version'
        : data['formVersion'];
    final assignment = data['assignment'];
    final orgUnit = data['orgUnit'];
    final team = data['team'];
    return DataInstance.fromJson({
      ...data,
      'status': InstanceSyncStatus.synced.name,
      'progressStatus': data['status'],
      'form': formId,
      'assignment': assignment,
      'orgUnit': orgUnit,
      'team': team,
    }, serializer: serializer);
  }

  /// Upload a batch of submissions and update DB statuses inside a transaction.
  Future<ImportSummaryModel> upload(Iterable<String> ids) async {
    final submissions = await (select(dataInstances)
          ..where((f) =>
              f.id.isIn(ids) &
              f.syncState.isIn([
                InstanceSyncStatus.finalized.name,
                InstanceSyncStatus.syncFailed.name
              ])))
        .get();

    if (submissions.isEmpty) {
      return ImportSummaryModel.empty(); // adjust to your model
    }

    // mark as uploading so UI can react
    await markUploading(submissions.map((s) => s.id));

    final uploadPayload = submissions.map((s) => s.toUpload()).toList();
    final resource = '$resourceName/bulk';

    try {
      final response = await apiClient.request(
        resourceName: resource,
        data: uploadPayload,
        method: 'post',
      );

      final ImportSummaryModel summary =
          ImportSummaryModel.fromJson(response.data);
      final now = DateTime.now().toUtc();

      // Build a list of updates (not complete companions for insertion)
      final List<_PerRowUpdate> updates = [];
      for (final s in submissions) {
        final id = s.id;
        final failedMsg = summary.failed[id];
        final isCreated = summary.created.contains(id);
        final isUpdated = summary.updated.contains(id);

        if (isCreated || isUpdated) {
          updates.add(_PerRowUpdate(
            id: id,
            syncState: InstanceSyncStatus.synced,
            lastSyncMessage: null,
            lastSyncDate: now,
            isToUpdate: true,
          ));
        } else if (failedMsg != null) {
          updates.add(_PerRowUpdate(
            id: id,
            syncState: InstanceSyncStatus.syncFailed,
            lastSyncMessage: failedMsg,
            lastSyncDate: now,
            isToUpdate: false,
          ));
        }
      }

      if (updates.isNotEmpty) {
        await transaction(() async {
          for (final u in updates) {
            final companion = DataInstancesCompanion(
              syncState: Value(u.syncState),
              lastSyncMessage: Value(u.lastSyncMessage),
              lastSyncDate: Value(u.lastSyncDate),
              isToUpdate: Value(u.isToUpdate),
            );

            await (update(dataInstances)..where((t) => t.id.equals(u.id)))
                .write(companion);
          }
        });
      }

      return summary;
    } catch (error) {
      // network or unexpected error -> mark all affected submissions as failed
      final now = DateTime.now().toUtc();
      final errMsg = error.toString();

      final failUpdates = submissions.map((s) => _PerRowUpdate(
            id: s.id,
            syncState: InstanceSyncStatus.syncFailed,
            lastSyncMessage: errMsg,
            lastSyncDate: now,
            isToUpdate: false,
          ));

      await transaction(() async {
        for (final u in failUpdates) {
          final companion = DataInstancesCompanion(
            syncState: Value(u.syncState),
            lastSyncMessage: Value(u.lastSyncMessage),
            lastSyncDate: Value(u.lastSyncDate),
            isToUpdate: Value(u.isToUpdate),
          );
          await (update(dataInstances)..where((t) => t.id.equals(u.id)))
              .write(companion);
        }
      });

      return ImportSummaryModel.empty();
      // optional: rethrow so caller knows the upload failed
    }
  }

  Future<DataInstance?> getById(String id) {
    return (select(dataInstances)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<DataInstance> createDraft({
    String? assignmentId,
    required String templateId,
    String? templateVersionId,
  }) async {
    // final FormTemplateModel? templateModel = await attachedDatabase
    //     .formTemplateVersionsDao
    //     .selectFormTemplatesWithRefs(
    //         assignmentId: assignmentId, versionId: templateVersionId)
    //     .getSingleOrNull();

    final templateModel = await getTemplateByVersionOrLatest(
        templateId: templateId, versionId: templateVersionId);

    final entry = DataInstancesCompanion.insert(
      id: CodeGenerator.generateUid(),
      formTemplate: templateModel.id,
      templateVersion: templateModel.versionUid,
      assignment: Value(assignmentId),
      syncState: InstanceSyncStatus.draft,
      isToUpdate: false,
      startEntryTime: Value(DateTime.now().toUtc()),
      updatedAtClient: Value(DateTime.now().toUtc()),
      createdDate: Value(DateTime.now().toUtc()),
      lastModifiedDate: Value(DateTime.now().toUtc()),
    );

    final row = await into(dataInstances).insertReturning(entry);

    return row;
  }

  Future<int> insert(Insertable<DataInstance> entry) {
    return into(dataInstances).insert(entry);
  }

  Future<bool> updateObject(DataInstancesCompanion item) {
    final now = Value(DateTime.now().toUtc());
    return update(dataInstances)
        .replace(item.copyWith(lastModifiedDate: now, updatedAtClient: now));
  }

  Future<void> updateData(String id, {Map<String, dynamic>? data}) async {
    final now = Value(DateTime.now().toUtc());
    await (update(dataInstances)..where((t) => t.id.equals(id))).write(
      DataInstancesCompanion(
          syncState: Value(InstanceSyncStatus.draft),
          formData: Value.absentIfNull(data),
          finishedEntryTime: now,
          lastModifiedDate: now,
          updatedAtClient: now),
    );
  }

  Future<void> markFinal(String id) async {
    final now = Value(DateTime.now().toUtc());
    await (update(dataInstances)..where((t) => t.id.equals(id))).write(
      DataInstancesCompanion(
          syncState: Value(InstanceSyncStatus.finalized),
          finishedEntryTime: now,
          lastModifiedDate: now,
          updatedAtClient: now),
    );
  }

  /// Mark given submission ids as uploading (persist to DB so UI shows state).
  Future<void> markUploading(Iterable<String> ids) async {
    if (ids.isEmpty) return;

    final now = DateTime.now().toUtc();

    await (update(dataInstances)..where((t) => t.id.isIn(ids)))
        .write(DataInstancesCompanion(
      syncState: Value(InstanceSyncStatus.uploading),
      lastSyncMessage: const Value(null),
      lastSyncDate: Value(now),
    ));
  }

  Future<void> markDeleted(String id) async {
    final now = Value(DateTime.now().toUtc());
    await (update(dataInstances)..where((t) => t.id.equals(id))).write(
      DataInstancesCompanion(
          deleted: Value(true),
          finishedEntryTime: now,
          lastModifiedDate: now,
          updatedAtClient: now),
    );
  }

  /// softDelete
  Future<int> deleteObject(DataInstance submission) {
    return deleteById(submission.id);
  }

  /// softDelete
  Future<int> deleteById(String id) async {
    return _softDelete(id);
  }

  Future<int> deleteAllIds(Iterable<String> id) async {
    final now = Value(DateTime.now().toUtc());
    // soft delete synced
    final softDeleted = await (update(dataInstances)
          ..where((tbl) => tbl.id.isIn(id) & tbl.isToUpdate.equals(true)))
        .write(DataInstancesCompanion(
            deleted: Value(true),
            finishedEntryTime: now,
            lastModifiedDate: now,
            updatedAtClient: now));

    // hard delete draft
    final hardDeleted = await (delete(dataInstances)
          ..where((tbl) => tbl.id.isIn(id) & tbl.isToUpdate.isNotValue(true)))
        .go();

    return softDeleted + hardDeleted;
  }

  Future<int> softDeleteIds(Iterable<String> id) async {
    final now = Value(DateTime.now().toUtc());
    // soft delete synced
    final softDeleted = await (update(dataInstances)
          ..where((tbl) => tbl.id.isIn(id) & tbl.isToUpdate.equals(true)))
        .write(DataInstancesCompanion(
            deleted: Value(true),
            finishedEntryTime: now,
            lastModifiedDate: now,
            updatedAtClient: now));
    return softDeleted;
  }

  Future<int> hardDeleteIds(Iterable<String> id) async {
    final hardDeleted =
        await (delete(dataInstances)..where((tbl) => tbl.id.isIn(id))).go();

    return hardDeleted;
  }

  /// hard delete
  Future<int> _hardDeleteById(String id) {
    return (delete(dataInstances)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// hard delete
  Future<int> _hardDeleteObject(DataInstance submission) {
    return _hardDeleteById(submission.id);
  }

  Future<int> _softDelete(String? id) async {
    if (id == null) return 0;
    final submissionToDelete = await getById(id);
    if (submissionToDelete == null) return 0;
    if (isSoftDelete(submissionToDelete)) {
      await markDeleted(id);
      return 1;
    } else {
      return await _hardDeleteObject(submissionToDelete);
    }
  }

  /// was already in server and only updates are sent
  bool isSoftDelete(DataInstance? submission) {
    return submission?.isToUpdate == true;
  }

  /// still local and not yet in server
  bool isToPost(DataInstance submission) {
    return !submission.isToUpdate;
  }

  /// watch the status of submission belonging to an
  /// item (i.e, the aggregation level) (e.g. Assignment, Form,..)
  /// by passing the item id and the item level
  Selectable<SubmissionSyncStatusModel> selectStatusByLevel({
    String? formId,
    String? assignmentId,
    String? submissionId,
  }) {
    assert(formId != null || assignmentId != null || submissionId != null);

    Expression<bool> byLevel = Constant(true);

    if (formId != null) {
      byLevel = dataInstances.formTemplate.equals(formId);
    }

    if (assignmentId != null) {
      byLevel = byLevel & dataInstances.assignment.equals(assignmentId);
    }

    if (submissionId != null) {
      byLevel = byLevel & dataInstances.id.equals(submissionId);
    }

    final syncState = dataInstances.syncState;
    final count = dataInstances.id.count();

    var query = selectOnly(dataInstances)
      ..addColumns([syncState, count])
      ..where(byLevel & dataInstances.deleted.isNotValue(true));

    if (assignmentId != null) {
      query = query..where(dataInstances.assignment.equals(assignmentId));
    }

    if (submissionId != null) {
      query = query..where(dataInstances.id.equals(submissionId));
    }

    query = query..groupBy([dataInstances.syncState]);

    return query.map((row) {
      final syncState = row.read(dataInstances.syncState)!;
      return SubmissionSyncStatusModel(
          syncState: InstanceSyncStatus.getValue(syncState),
          count: row.read(count)!);
    });
  }

  JoinedSelectStatement<HasResultSet, dynamic> getFilterQuery(
      {Iterable<FilterCondition>? filters}) {
    table;
    List<Expression<bool>> filterExpressions = [];
    // Apply each filter
    if (filters != null) {
      for (final f in filters) {
        filterExpressions.add(f.toExpression());
      }
    }

    // final count =
    //     dataInstances.id.count(filter: Expression.and(filterExpressions));
    // final a = alias(assignments, 'a');
    // final ou = alias(orgUnits, 'ou');
    // final f = alias(formTemplates, 'f');
    // final fv = alias(formTemplateVersions, 'fv');

    final JoinedSelectStatement<HasResultSet, dynamic> base =
        select(dataInstances).join([
      innerJoin(
          assignments, assignments.id.equalsExp(dataInstances.assignment)),
      innerJoin(orgUnits, assignments.orgUnit.equalsExp(orgUnits.id)),
      innerJoin(formTemplateVersions,
          formTemplateVersions.id.equalsExp(dataInstances.templateVersion)),
      innerJoin(formTemplates,
          formTemplates.id.equalsExp(formTemplateVersions.template)),
    ]);

    // ..where(Expression.and(filterExpressions));
    if (filterExpressions.isNotEmpty) {
      base.where(Expression.and(filterExpressions));
    }
    return base;
  }

  /// Returns a Selectable that, when run, gives you each TableItem
  Selectable<SubmissionSummary> selectItems({
    Iterable<FilterCondition>? filters,
    String? sortColumn,
    bool sortAscending = true,
    int page = 0,
    int pageSize = 20,
  }) {
    final query = getFilterQuery(filters: filters);
    if (sortColumn != null) {
      final col = table.$columns
          .cast<GeneratedColumn>()
          .firstWhere((c) => c.$name == sortColumn);
      query.orderBy([
        OrderingTerm(
          expression: col,
          mode: sortAscending ? OrderingMode.asc : OrderingMode.desc,
        )
      ]);
    }

    query.limit(pageSize, offset: page * pageSize);

    // submissions for different formTemplates, not for particular on Template.
    return query.map(SubmissionSummary.fromDrift);
  }

  /// Returns a Selectable that, when run, gives you each TableItem
  /// plus the *same* totalCount on every row.
  Selectable<SubmissionSummary> selectSubmissions(
    SubmissionsFilter filterModel, {
    String? sortColumn,
    bool sortAscending = true,
    int page = 0,
    int pageSize = 10,
    Iterable<FilterCondition>? filters,
  }) {
    final effectiveFilters = [
      FilterCondition.equals(dataInstances.formTemplate, filterModel.formId),
      if (filterModel.assignmentId != null)
        FilterCondition.equals(
            dataInstances.assignment, filterModel.assignmentId!),
      if (filterModel.syncState != null)
        FilterCondition.equals(
            dataInstances.syncState, filterModel.syncState!.name),
      if (!filterModel.includeDeleted)
        FilterCondition.equals(dataInstances.deleted, false),
      if (filterModel.dateFilterBand != null)
        FilterCondition.between(
            dataInstances.createdDate,
            getDateRangeFromBand(filterModel.dateFilterBand!).$1,
            getDateRangeFromBand(filterModel.dateFilterBand!).$2),
      ...?filters
    ];

    final query = getFilterQuery(filters: effectiveFilters);

    // Apply sorting (if provided)
    if (sortColumn != null) {
      final col = table.$columns
          .cast<GeneratedColumn>()
          .firstWhere((c) => c.$name == sortColumn);
      query.orderBy([
        OrderingTerm(
          expression: col,
          mode: (sortAscending) ? OrderingMode.asc : OrderingMode.desc,
        )
      ]);
    }

    query.limit(pageSize, offset: page * pageSize);

    return query.map(SubmissionSummary.fromDrift);
  }

  // Selectable<int> countSubmissions(SubmissionsFilter filterModel,
  //     {Iterable<FilterCondition>? filters}) {
  //   final effectiveFilters = [
  //     FilterCondition.equals(dataInstances.formTemplate, filterModel.formId),
  //     if (filterModel.assignmentId != null)
  //       FilterCondition.equals(
  //           dataInstances.assignment, filterModel.assignmentId!),
  //     if (filterModel.syncState != null)
  //       FilterCondition.equals(
  //           dataInstances.syncState, filterModel.syncState!.name),
  //     if (!filterModel.includeDeleted)
  //       FilterCondition.equals(dataInstances.deleted, false),
  //     if (filterModel.dateFilterBand != null)
  //       FilterCondition.between(
  //           dataInstances.createdDate,
  //           getDateRangeFromBand(filterModel.dateFilterBand!).$1,
  //           getDateRangeFromBand(filterModel.dateFilterBand!).$2),
  //     ...?filters
  //   ];
  //   var countQuery = getFilterQuery(filters: effectiveFilters);
  //   countQuery = countQuery..addColumns([countAll()]);
  //
  //   return countQuery.map((row) => row.read(countAll()) ?? 0);
  // }

  @override
  $DataInstancesTable get table => dataInstances;

  // Helper method to calculate the date range based on the enum
  (DateTime, DateTime) getDateRangeFromBand(DateFilterBand band) {
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    // Set the time of day to midnight for consistent date filtering
    final today = DateTime(now.year, now.month, now.day);

    switch (band) {
      case DateFilterBand.today:
        startDate = today;
        endDate = today.add(const Duration(days: 1));
        break;
      case DateFilterBand.lastThreeDays:
        startDate = today.subtract(const Duration(days: 2));
        endDate = today.add(const Duration(days: 1));
        break;
      case DateFilterBand.thisWeek:
        // Find the start of the week (e.g., Monday)
        final weekday = now.weekday == 0 ? 7 : now.weekday;
        startDate = today.subtract(Duration(days: weekday - 1));
        endDate = startDate.add(const Duration(days: 7));
        break;
      case DateFilterBand.thisMonth:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 1);
        break;
      case DateFilterBand.lastThreeMonths:
        startDate = DateTime(now.year, now.month - 2, 1);
        endDate = DateTime(now.year, now.month + 1, 1);
        break;
      case DateFilterBand.thisYear:
        startDate = DateTime(now.year, 1, 1);
        endDate = DateTime(now.year + 1, 1, 1);
        break;
      // // case DateFilterBand.allDates:
      // // default:
      //   // No filter, return a wide date range
      //   startDate = DateTime(2000); // A very old date
      //   endDate = DateTime.now().add(const Duration(days: 365));
      //   break;
    }

    return (startDate, endDate);
  }

  Selectable<SubmissionSummary> selectable(
    SubmissionsFilter? filterModel, {
    String? sortColumn,
    bool sortAscending = true,
    int page = 0,
    int pageSize = 10,
    Iterable<FilterCondition>? filters,
    bool paged = true,
  }) {
    // final sub = alias(dataInstances, 's');
    final a = alias(assignments, 'a');
    final ou = alias(orgUnits, 'ou');
    final f = alias(formTemplates, 'f');
    final fv = alias(formTemplateVersions, 'fv');

    final JoinedSelectStatement<HasResultSet, dynamic> query =
        select(dataInstances).join([
      innerJoin(a, a.id.equalsExp(dataInstances.assignment)),
      innerJoin(ou, a.orgUnit.equalsExp(ou.id)),
      innerJoin(fv, fv.id.equalsExp(dataInstances.templateVersion)),
      innerJoin(f, f.id.equalsExp(fv.template)),
    ]);

    if (filterModel != null) {
      query.where(_buildFilter(filterModel));
      if (filterModel.searchTerm.isNotNullOrEmpty) {
        final pattern = '%${filterModel.searchTerm!.toLowerCase()}%';
        query.where(ou.name.like(pattern) | ou.code.like(pattern));
      }
    }

    // Apply sorting based on the filter or default
    // if (sortModel != null && sortModel.sortColumn != null) {
    //   query.orderBy([
    //     OrderingTerm(
    //       expression: getColumnExpression(sortModel.sortColumn!),
    //       mode: sortModel.sortAscending ? OrderingMode.asc : OrderingMode.desc,
    //     ),
    //   ]);
    // } else {
    //   query.orderBy([
    //     OrderingTerm(
    //         expression: db.dataInstances.createdDate, mode: OrderingMode.desc),
    //     OrderingTerm(expression: db.dataInstances.id)
    //   ]);
    // }

    if (paged) {
      query.limit(pageSize, offset: page * pageSize);
    }

    return query.map((TypedResult row) {
      final submission = row.readTable(dataInstances);
      final orgUnit = row.readTable(ou);
      final form = row.readTable(f);
      final FormTemplateVersion formVersion = row.readTable(fv);

      return SubmissionSummary(
          id: submission.id,
          assignment: submission.assignment,
          form: IdentifiableModel(
            id: form.id,
            name: form.name,
            label: form.label,
          ),
          versionNumber: form.versionNumber,
          orgUnit: IdentifiableModel(
            id: orgUnit.id,
            code: orgUnit.code,
            name: orgUnit.name,
            label: orgUnit.label,
          ),
          submittedAt: submission.createdDate,
          syncStatus: submission.syncState,
          formVersionId: formVersion.id,
          createdDate: submission.createdDate,
          lastModifiedDate: submission.lastModifiedDate,
          lastSyncMessage: submission.lastSyncMessage,
          dataMap: (submission.formData ?? {}).lock,
          deleted: submission.deleted,
          formData: FormDataUtil.extractTemplateValue(
                  submission.formData ?? {}, formVersion.fields)
              .lock);
    });
  }

  Expression<bool> _buildFilter(SubmissionsFilter filterModel) {
    Expression<bool> filter =
        dataInstances.formTemplate.equals(filterModel.formId);

    if (filterModel.assignmentId != null) {
      filter =
          filter & dataInstances.assignment.equals(filterModel.assignmentId!);
    }

    if (filterModel.syncState != null) {
      filter =
          filter & dataInstances.syncState.equals(filterModel.syncState!.name);
    }

    if (filterModel.dateFilterBand != null) {
      final (startDate, endDate) =
          getDateRangeFromBand(filterModel.dateFilterBand!);

      // NOTE: isBetween is inclusive of both the start and end dates.
      filter = filter &
          dataInstances.createdDate.isBetweenValues(startDate, endDate);
      // a combination of greater than and less than
      // query.where(sub.createdDate.isBiggerOrEqual(startDate) & sub.createdDate.isSmallerThan(endDate));
    }

    if (!filterModel.includeDeleted) {
      filter = filter & dataInstances.deleted.equals(false);
    }

    return filter;
  }

  Selectable<int> countSubmissions(SubmissionsFilter? filterModel) {
    // final sub = alias(dataInstances, 's');
    final a = alias(assignments, 'a');
    final ou = alias(orgUnits, 'ou');
    final f = alias(formTemplates, 'f');
    final fv = alias(formTemplateVersions, 'fv');

    JoinedSelectStatement<HasResultSet, dynamic> countQuery =
        select(dataInstances).join([
      innerJoin(a, a.id.equalsExp(dataInstances.assignment)),
      innerJoin(ou, a.orgUnit.equalsExp(ou.id)),
      innerJoin(fv, fv.id.equalsExp(dataInstances.templateVersion)),
      innerJoin(f, f.id.equalsExp(fv.template)),
    ]);
    if (filterModel != null) {
      countQuery.where(_buildFilter(filterModel));
      if (filterModel.searchTerm.isNotNullOrEmpty) {
        final pattern = '%${filterModel.searchTerm!.toLowerCase()}%';
        countQuery = countQuery
          ..where(ou.name.like(pattern) | ou.code.like(pattern));
      }
    }

    countQuery = countQuery..addColumns([countAll()]);

    return countQuery.map((row) => row.read(countAll()) ?? 0);
  }

// Expression<bool> _buildFilter(SubmissionsFilter filterModel) {
//   Expression<bool> filter =
//       dataInstances.formTemplate.equals(filterModel.formId);
//
//   if (filterModel.assignmentId != null) {
//     filter =
//         filter & dataInstances.assignment.equals(filterModel.assignmentId!);
//   }
//
//   if (filterModel.syncState != null) {
//     filter =
//         filter & dataInstances.syncState.equals(filterModel.syncState!.name);
//   }
//
//   if (filterModel.dateFilterBand != null) {
//     final (startDate, endDate) =
//         _getDateRangeFromBand(filterModel.dateFilterBand!);
//
//     // NOTE: isBetween is inclusive of both the start and end dates.
//     filter = filter &
//         dataInstances.createdDate.isBetweenValues(startDate, endDate);
//     // a combination of greater than and less than
//     // query.where(sub.createdDate.isBiggerOrEqual(startDate) & sub.createdDate.isSmallerThan(endDate));
//   }
//
//   if (!filterModel.includeDeleted) {
//     filter = filter & dataInstances.deleted.equals(false);
//   }
//
//   return filter;
// }
}

// small helper DTO so we don't accidentally carry an `id` Value into the write companion
class _PerRowUpdate {
  final String id;
  final InstanceSyncStatus syncState;
  final String? lastSyncMessage;
  final DateTime? lastSyncDate;
  final bool isToUpdate;

  _PerRowUpdate({
    required this.id,
    required this.syncState,
    required this.lastSyncMessage,
    required this.lastSyncDate,
    required this.isToUpdate,
  });
}
