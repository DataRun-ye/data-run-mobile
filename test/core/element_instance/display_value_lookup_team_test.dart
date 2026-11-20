import 'package:datarunmobile/core/element_instance/display_value_lookup.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// A Team field holds one of the supervisor's managed teams, which are kept
/// apart from his own teams; the saved value must still show the team.
void main() {
  late AppDatabase db;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(executor: NativeDatabase.memory(), userId: 'test-user');
    appLocator.registerSingleton<AppDatabase>(db);
    await db.into(db.teams).insert(TeamsCompanion.insert(
        id: 'supervisor', activity: 'itn', code: const Value('S1')));
    await db.into(db.managedTeams).insert(ManagedTeamsCompanion.insert(
        id: 'team-573',
        activity: 'itn',
        managedBy: 'supervisor',
        code: const Value('573')));
  });

  tearDown(() async {
    await db.close();
    await appLocator.reset();
  });

  test('shows managed and own teams by code', () async {
    final lookup = DisplayValueLookup();

    expect(await lookup.getTeamById('team-573'), 'team 573');
    expect(await lookup.getTeamById('supervisor'), 'team S1');
    expect(await lookup.getTeamById('unknown'), isNull);
  });
}
