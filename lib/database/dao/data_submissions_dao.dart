import 'dart:convert';

import 'package:datarunmobile/core/code_generator.dart';
import 'package:datarunmobile/core/data_instance/form_data_util.dart';
import 'package:datarunmobile/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/core/util/string_extension.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/dao/data_submissions_dao_expression_extension.dart';
import 'package:datarunmobile/database/domain/filter.dart';
import 'package:datarunmobile/database/extensions/data_submission.extension.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submission_sync_status_model.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:datarunmobile/database/tables/data_submissions.table.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

part 'data_submissions_dao.g.dart';

@DriftAccessor(tables: [DataInstances])
class DataInstancesDao extends DatabaseAccessor<AppDatabase>
    with _$DataInstancesDaoMixin {
  DataInstancesDao(AppDatabase db) : super(db);

  HttpClient<dynamic> get _apiClient => appLocator<HttpClient<dynamic>>();

  /// Upload a batch of submissions and update DB statuses inside a transaction.
  Future<ImportSummaryModel> upload(Iterable<String> ids) async {
    var submissions = await (select(dataInstances)
          ..where((f) =>
              f.id.isIn(ids) &
              f.syncState.isIn([
                InstanceSyncStatus.finalized.name,
                InstanceSyncStatus.syncFailed.name
              ])))
        .get();

    if (submissions.isEmpty) {
      return ImportSummaryModel.empty();
    }

    submissions = await _persistRepeatMetadataBeforeUpload(submissions);

    // mark as uploading so UI can react
    await markUploading(submissions.map((s) => s.id));

    final uploadPayload = submissions.map((s) => s.toUpload()).toList();
    const resource = 'dataSubmission/bulk';

    try {
      final response = await _apiClient.request(
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

      // or: rethrow if the caller needs to know the upload failed
      return ImportSummaryModel.empty();
    }
  }

  Future<List<DataInstance>> _persistRepeatMetadataBeforeUpload(
      List<DataInstance> submissions) async {
    final normalizedSubmissions = <DataInstance>[];
    final changedSubmissions = <DataInstance>[];
    final now = DateTime.now().toUtc();

    for (final submission in submissions) {
      final formData = submission.formData;
      if (formData == null) {
        normalizedSubmissions.add(submission);
        continue;
      }

      final normalizedFormData = RepeatMetadataNormalizer.normalizeFormData(
        formData,
        submissionUid: submission.id,
      );

      if (jsonEncode(normalizedFormData) == jsonEncode(formData)) {
        normalizedSubmissions.add(submission);
        continue;
      }

      final normalizedSubmission = submission.copyWith(
        formData: Value(normalizedFormData),
        lastModifiedDate: Value(now),
        updatedAtClient: Value(now),
      );

      normalizedSubmissions.add(normalizedSubmission);
      changedSubmissions.add(normalizedSubmission);
    }

    if (changedSubmissions.isNotEmpty) {
      await transaction(() async {
        for (final submission in changedSubmissions) {
          await (update(dataInstances)
                ..where((t) => t.id.equals(submission.id)))
              .write(DataInstancesCompanion(
            formData: Value(submission.formData),
            lastModifiedDate: Value(now),
            updatedAtClient: Value(now),
          ));
        }
      });
    }

    return normalizedSubmissions;
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

  Future<void> updateData(String id, {Map<String, dynamic>? data}) async {
    final now = Value(DateTime.now().toUtc());
    await (update(dataInstances)..where((t) => t.id.equals(id))).write(
      DataInstancesCompanion(
          syncState: Value(InstanceSyncStatus.draft),
          formData: Value.absentIfNull(data),
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

  Future<int> deleteById(String id) async {
    return _softDelete(id);
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
    if (submissionToDelete.isToUpdate) {
      await markDeleted(id);
      return 1;
    } else {
      return await _hardDeleteObject(submissionToDelete);
    }
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
    List<Expression<bool>> filterExpressions = [];
    // Apply each filter
    if (filters != null) {
      for (final f in filters) {
        filterExpressions.add(f.toExpression());
      }
    }

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

    if (filterExpressions.isNotEmpty) {
      base.where(Expression.and(filterExpressions));
    }
    return base;
  }

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
      if (filterModel.syncStates.isNotEmpty)
        FilterCondition.inList(dataInstances.syncState,
            filterModel.syncStates.map((s) => s.name).toList()),
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

    return query
        .map((row) => SubmissionSummary.fromDrift(row, attachedDatabase));
  }

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

    query.orderBy([
      OrderingTerm(
          expression: db.dataInstances.createdDate, mode: OrderingMode.desc)
    ]);
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
          deleted: submission.deleted,
          formData: FormDataUtil.extractTemplateValue(
                  submission.formData ?? {}, formVersion.fields,
                  createdAt: submission.createdDate)
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

    if (filterModel.syncStates.isNotEmpty) {
      filter = filter &
          dataInstances.syncState
              .isIn(filterModel.syncStates.map((s) => s.name));
    }

    if (filterModel.dateFilterBand != null) {
      final (startDate, endDate) =
          getDateRangeFromBand(filterModel.dateFilterBand!);

      filter = filter &
          dataInstances.createdDate.isBetweenValues(startDate, endDate);
    }

    if (!filterModel.includeDeleted) {
      filter = filter & dataInstances.deleted.equals(false);
    }

    return filter;
  }

  Selectable<int> countSubmissions(SubmissionsFilter? filterModel) {
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
