import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/activity/application/activity_list.provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
  });

  tearDown(() => db.close());

  test('projects active activities with assigned and managed teams', () async {
    await db.into(db.projects).insert(
          ProjectsCompanion.insert(id: 'project-1', name: 'Project'),
        );
    await db.into(db.activities).insert(
          ActivitiesCompanion.insert(
            id: 'activity-1',
            name: 'Activity',
            project: 'project-1',
          ),
        );
    await db.into(db.teams).insert(
          TeamsCompanion.insert(
            id: 'assigned-team',
            activity: 'activity-1',
            code: const Value('A'),
          ),
        );
    await db.into(db.managedTeams).insert(
          ManagedTeamsCompanion.insert(
            id: 'managed-team',
            activity: 'activity-1',
            managedBy: 'assigned-team',
            code: const Value('M'),
          ),
        );

    final activities = await loadActivityList(db);

    expect(activities, hasLength(1));
    expect(activities.single.id, 'activity-1');
    expect(activities.single.assignedTeam?.id, 'assigned-team');
    expect(
      activities.single.managedTeams.map((team) => team.id),
      ['managed-team'],
    );
    expect(activities.single.assignedAssignments, 0);
    expect(activities.single.managedAssignments, 0);
  });
  test('counts each activity\'s managed assignments on its own card', () async {
    await db.into(db.projects).insert(
          ProjectsCompanion.insert(id: 'project-1', name: 'Project'),
        );
    for (final id in ['itn', 'lsm']) {
      await db.into(db.activities).insert(
            ActivitiesCompanion.insert(id: id, name: id, project: 'project-1'),
          );
      await db.into(db.teams).insert(
            TeamsCompanion.insert(id: 'supervisor-$id', activity: id),
          );
      await db.into(db.managedTeams).insert(
            ManagedTeamsCompanion.insert(
              id: 'team-$id',
              activity: id,
              managedBy: 'supervisor-$id',
            ),
          );
    }
    Future<void> assignment(String id, String activity, String team,
            {bool disabled = false}) =>
        db.into(db.assignments).insert(
              AssignmentsCompanion.insert(
                id: id,
                activity: activity,
                team: team,
                orgUnit: 'village-$id',
                syncState: InstanceSyncStatus.synced,
                disabled: Value(disabled),
              ),
            );
    await assignment('itn-1', 'itn', 'team-itn');
    await assignment('itn-2', 'itn', 'team-itn');
    await assignment('itn-off', 'itn', 'team-itn', disabled: true);
    await assignment('lsm-1', 'lsm', 'team-lsm');

    final cards = {
      for (final activity in await loadActivityList(db))
        activity.id: activity.managedAssignments,
    };

    expect(cards, {'itn': 2, 'lsm': 1});
  });
}
