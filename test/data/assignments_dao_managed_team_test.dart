import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// A supervisor receives the assignments of the teams he manages (server
/// 6.5.1). Those teams are not among his own teams, only in the managed-teams
/// table, and the assignment list must still show them.
void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory(), userId: 'test-user');
    await db.batch((batch) {
      batch.insert(db.projects,
          ProjectsCompanion.insert(id: 'project', name: 'Project'));
      batch.insert(
        db.activities,
        ActivitiesCompanion.insert(id: 'itn', name: 'ITN', project: 'project'),
      );
      batch.insertAll(db.orgUnits, [
        OrgUnitsCompanion.insert(
            id: 'warehouse', name: 'Warehouse', path: ',warehouse,', level: 4),
        OrgUnitsCompanion.insert(
            id: 'village', name: 'Village', path: ',village,', level: 5),
      ]);
      batch.insert(
        db.teams,
        TeamsCompanion.insert(
            id: 'supervisor', activity: 'itn', code: const Value('S1')),
      );
      batch.insert(
        db.managedTeams,
        ManagedTeamsCompanion.insert(
          id: 'team-573',
          activity: 'itn',
          managedBy: 'supervisor',
          code: const Value('573'),
        ),
      );
      batch.insertAll(db.assignments, [
        AssignmentsCompanion.insert(
          id: 'own-assignment',
          activity: 'itn',
          team: 'supervisor',
          orgUnit: 'warehouse',
          syncState: InstanceSyncStatus.synced,
          disabled: const Value(false),
        ),
        AssignmentsCompanion.insert(
          id: 'managed-assignment',
          activity: 'itn',
          team: 'team-573',
          orgUnit: 'village',
          syncState: InstanceSyncStatus.synced,
          disabled: const Value(false),
        ),
      ]);
    });
  });

  tearDown(() => db.close());

  test('lists own and managed teams\' assignments with their team codes',
      () async {
    final assignments =
        await db.assignmentsDao.allAssignments(activityId: 'itn');

    expect(
      {for (final a in assignments) a.id: (a.team.id, a.team.code)},
      {
        'own-assignment': ('supervisor', 'S1'),
        'managed-assignment': ('team-573', '573'),
      },
    );
  });
}
