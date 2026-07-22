import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    appLocator.registerSingleton<AppDatabase>(db);
    container = ProviderContainer();

    await db.into(db.assignments).insert(
          AssignmentsCompanion.insert(
            id: 'assignment-a',
            activity: 'activity-a',
            team: 'manager-a',
            orgUnit: 'org-unit-a',
            syncState: InstanceSyncStatus.synced,
          ),
        );
    await db.batch((batch) {
      batch.insertAll(db.managedTeams, [
        ManagedTeamsCompanion.insert(
          id: 'managed-a',
          activity: 'activity-a',
          managedBy: 'manager-a',
        ),
        ManagedTeamsCompanion.insert(
          id: 'wrong-activity',
          activity: 'activity-b',
          managedBy: 'manager-a',
        ),
        ManagedTeamsCompanion.insert(
          id: 'wrong-manager',
          activity: 'activity-a',
          managedBy: 'manager-b',
        ),
      ]);
    });
  });

  tearDown(() async {
    container.dispose();
    await db.close();
    await appLocator.reset();
  });

  test('returns only managed teams for the assignment team and activity',
      () async {
    final teams = await container.read(
      managedTeamsProvider(assignmentId: 'assignment-a').future,
    );

    expect(teams.map((team) => team.id), ['managed-a']);
  });

  test('returns no teams without a valid assignment context', () async {
    final withoutAssignment = await container.read(
      managedTeamsProvider().future,
    );
    final unknownAssignment = await container.read(
      managedTeamsProvider(assignmentId: 'missing').future,
    );

    expect(withoutAssignment, isEmpty);
    expect(unknownAssignment, isEmpty);
  });
}
