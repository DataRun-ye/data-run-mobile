import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:drift/drift.dart';

part 'assignments_dao.g.dart';

@DriftAccessor(tables: [Assignments])
class AssignmentsDao extends DatabaseAccessor<AppDatabase>
    with _$AssignmentsDaoMixin, BaseDaoMixin<Assignment> {
  AssignmentsDao(AppDatabase db) : super(db);

  //<editor-fold desc="Remote">
  @override
  String get resourceName => 'assignments';

  /// Fetch the secondary “forms” and wrap them into CompanionInsert
  @override
  Future<List<CompanionInsert>> extractExtraEntities(
      List<Map<String, dynamic>> raw) async {
    final List<AssignmentForm> forms = await _getExtraAssignmentForms();
    return forms.map((f) => CompanionInsert(db.assignmentForms, f)).toList();
  }

  @override
  Assignment mapRemoteItem(Map<String, dynamic> data) {
    final bool disabled = data['disabled'] == true;

    final activity = data['activity']['uid'] as String;
    final orgUnit = data['orgUnit']['uid'] as String;
    final team = data['team']['uid'] as String;

    final base = super.mapRemoteItem({
      ...data,
      'activity': activity,
      'orgUnit': orgUnit,
      'team': team,
      'status': data['status'] ?? AssignmentStatus.PLANNED.name,
      'syncState': InstanceSyncStatus.synced.name,
      'disabled': disabled
    });

    return base;
  }

  @override
  Future<void> disableStale(List<Object> liveIds) async {
    await (db.update(table)
          ..where((t) => t.columnsByName['id']!.isNotIn(liveIds)))
        .write(RawValuesInsertable({
      'disabled': Variable<bool>(true),
    }));
  }

  @override
  Assignment fromApiJson(
    Map<String, dynamic> data, {
    ValueSerializer? serializer,
  }) {
    return Assignment.fromJson(data, serializer: serializer);
  }

  Future<List<AssignmentForm>> _getExtraAssignmentForms() async {
    final extraResourceName = 'assignments/forms';

    final versionResourcePath = '$extraResourceName?paged=false';
    final response = await apiClient.request(
        resourceName: versionResourcePath, method: 'get');

    final raw = response.data;

    /// expecting paged list ({ apiResourceName: [...] }),
    List dataItems = raw?['assignments']?.toList() ?? [];

    final assignmentModels =
        dataItems.map((item) => _AssignmentWithAccess.fromJson(item)).toList();

    final assignmentForms =
        assignmentModels.expand((t) => t.accessibleForms).toList();
    return assignmentForms;
  }

  //</editor-fold>

  //<editor-fold desc="Db Query">
  @override
  SimpleSelectStatement<$AssignmentsTable, Assignment> get engine =>
      select(assignments)..where((u) => u.disabled.isNotValue(true));

  @override
  $AssignmentsTable get table => assignments;

  Future<List<AssignmentModel>> allAssignments(
      {String? activityId, String ouSearchFilter = ''}) async {
    var assignmentWithRefs = attachedDatabase.managers.assignments
        .filter((f) => f.disabled.not(true));

    if (activityId != null) {
      assignmentWithRefs =
          assignmentWithRefs.filter((f) => f.activity.id(activityId));
    }

    if (ouSearchFilter.isNotEmpty) {
      assignmentWithRefs = assignmentWithRefs
          .filter((f) => f.orgUnit.name.contains(ouSearchFilter));
    }

    final result = assignmentWithRefs
        .withReferences((prefetch) =>
            prefetch(forms: true, team: true, activity: true, orgUnit: true))
        .orderBy((o) => o.instanceDate.asc(nulls: NullsOrder.last))
        .map((assignmentsWithRefs) {
      final a = assignmentsWithRefs.$1;
      final forms = assignmentsWithRefs.$2.forms.prefetchedData?.length ?? 0;
      final activity =
          assignmentsWithRefs.$2.activity.prefetchedData!.firstOrNull;
      final ou = assignmentsWithRefs.$2.orgUnit.prefetchedData!.first;
      final team = assignmentsWithRefs.$2.team.prefetchedData!.first;
      return AssignmentModel(
          id: a.id,
          activity: activity != null
              ? IdentifiableModel(
                  id: activity.id, code: activity.code, name: activity.name)
              : null,
          orgUnit: IdentifiableModel(
            id: ou.id,
            code: ou.code,
            name: ou.name,
          ),
          team: IdentifiableModel(
            id: team.id,
            code: team.code,
            name: team.code ?? '',
          ),
          // startDay: a.startDay,
          startDate: a.instanceDate,
          dueDate: null,
          formCount: forms
          // status: a.assignmentStatus ?? AssignmentStatus.PLANNED,
          );
    }).get();

    return result;
  }

  Selectable<AssignmentModel> selectAssignments({
    String? activityId,
    String ouSearchFilter = '',
    int page = 1,
    int pageSize = 20,
  }) {
    final offset = (page - 1) * pageSize;

    final a = alias(assignments, 'a');
    final ous = alias(orgUnits, 'ou');
    final act = alias(activities, 'act');
    // final f = alias(db.assignmentForms, 'f');
    final formsCount = db.assignmentForms.assignment.equalsExp(a.id).count();
    // Base join query
    final JoinedSelectStatement<HasResultSet, dynamic> query =
        select(a).addColumns([formsCount]).join([
      innerJoin(teams, teams.id.equalsExp(a.team)),
      innerJoin(act, act.id.equalsExp(a.activity)),
      innerJoin(ous, ous.id.equalsExp(a.orgUnit)),
      // innerJoin(forms, forms.assignment.equalsExp(a.id)),
    ]);

    // Apply activity filter if provided
    if (activityId != null) {
      query.where(act.id.equals(activityId));
    }

    // Apply orgUnit name filter if provided
    if (ouSearchFilter.isNotEmpty) {
      final pattern = '%${ouSearchFilter.toLowerCase()}%';
      query..where(ous.name.like(pattern) | ous.code.like(pattern));
    }

    // Apply paging
    query
      ..limit(pageSize, offset: offset)
      ..orderBy([
        // order for stable paging
        OrderingTerm(
            expression: db.assignments.instanceDate, mode: OrderingMode.desc),
        OrderingTerm(expression: db.assignments.id),
      ]);

    // Map rows to model
    return query.map((row) {
      final a = row.readTable(assignments);
      final t = row.readTable(teams);
      final ou = row.readTable(ous);
      final ac = row.readTable(act);
      final forms = row.read(formsCount)!;
      return AssignmentModel(
          id: a.id,
          activity: activityId != null
              ? IdentifiableModel(id: activityId, code: ac.code, name: ac.name)
              : null,
          orgUnit: IdentifiableModel(
            id: ou.id,
            code: ou.code,
            name: ou.name,
          ),
          team: IdentifiableModel(
            id: t.id,
            code: t.code,
            name: t.code ?? '',
          ),
          // startDay: a.startDay,
          startDate: a.instanceDate,
          dueDate: null,
          formCount: forms
          // status: a.assignmentStatus ?? AssignmentStatus.PLANNED,
          );
    });
  }
//</editor-fold>
}

class _AssignmentWithAccess {
  final String assignment;
  final String activity;
  final String team;
  final String orgUnit;

  final AssignmentStatus progressStatus;
  final List<AssignmentForm> accessibleForms;

  _AssignmentWithAccess(
      {required this.assignment,
      required this.activity,
      required this.team,
      required this.orgUnit,
      required this.progressStatus,
      required this.accessibleForms});

  factory _AssignmentWithAccess.fromJson(Map<String, dynamic> map) {
    final accessibleForms = (map['accessibleForms'] as List? ?? [])
        .map<AssignmentForm>((access) => AssignmentForm.fromJson(
              {
                ...access,
                'form': access['form'],
                'assignment': access['assignment'],
              },
              serializer: CustomSerializer(),
            ))
        .toList();

    final progressStatus =
        AssignmentStatus.getType(map['progressStatus'] as String?) ??
            AssignmentStatus.PLANNED;
    return _AssignmentWithAccess(
      assignment: map['id'],
      activity: map['activity'] as String,
      team: map['team'] as String,
      orgUnit: map['orgUnit'] as String,
      progressStatus: progressStatus,
      accessibleForms: accessibleForms,
    );
  }
}
