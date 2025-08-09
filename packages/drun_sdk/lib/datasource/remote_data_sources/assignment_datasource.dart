import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.assignment)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class AssignmentDatasource extends BaseDataSource<$AssignmentsTable, Assignment>
    implements MetaDataSource<Assignment> {
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

  @override
  $AssignmentsTable get table => db.assignments;
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
