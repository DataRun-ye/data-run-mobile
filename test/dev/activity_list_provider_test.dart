import 'package:datarunmobile/database/app_database.dart';
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
}
