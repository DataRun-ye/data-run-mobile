import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/features/form_submission/application/reference_field_service.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ReferenceEntryRepository repository;

  setUp(() async {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'reference-field-test',
    );
    repository = ReferenceEntryRepository(database);
    await _insertAssignment(database);
  });

  tearDown(() => database.close());

  test('resolves the catalog scope from the active assignment', () async {
    final service = ReferenceFieldService(
      database,
      repository: repository,
    );

    expect(
      await service.resolveOrgUnitUid('assignment-1'),
      'org-1',
    );
  });

  test('creates one normalized local row with a client UID', () async {
    final service = ReferenceFieldService(
      database,
      repository: repository,
      uidGenerator: () => 'a1234567890',
    );

    final entry = await service.create(
      orgUnitUid: 'org-1',
      displayName: '  First   Middle  Third   Family ',
    );

    expect(entry.uid, 'a1234567890');
    expect(entry.displayName, 'First Middle Third Family');
    expect(
      await repository.findInScope(
        uid: entry.uid,
        orgUnitUid: 'org-1',
      ),
      entry,
    );
  });

  test('retries a generated UID collision without changing the existing row',
      () async {
    await repository.insertLocal(
      const ReferenceEntry(
        uid: 'a1234567890',
        orgUnitUid: 'org-1',
        displayName: 'Existing Person Name Here',
      ),
    );
    final generated = ['a1234567890', 'b1234567890'].iterator;
    final service = ReferenceFieldService(
      database,
      repository: repository,
      uidGenerator: () {
        generated.moveNext();
        return generated.current;
      },
    );

    final created = await service.create(
      orgUnitUid: 'org-1',
      displayName: 'New Person Name Here',
    );

    expect(created.uid, 'b1234567890');
    expect(
      (await repository.findInScope(
        uid: 'a1234567890',
        orgUnitUid: 'org-1',
      ))
          ?.displayName,
      'Existing Person Name Here',
    );
  });

  test('rejects invalid new names without inserting a row', () async {
    final service = ReferenceFieldService(
      database,
      repository: repository,
      uidGenerator: () => 'a1234567890',
    );

    await expectLater(
      service.create(
        orgUnitUid: 'org-1',
        displayName: 'Only Two',
      ),
      throwsA(isA<ReferenceDisplayNameException>()),
    );
    expect(await database.select(database.referenceEntries).get(), isEmpty);
  });
}

Future<void> _insertAssignment(AppDatabase database) async {
  await database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES ('org-1', '{}', 'Org unit', '/org-1', 1);
    INSERT INTO projects (id, translations, name)
    VALUES ('project-1', '{}', 'Project');
    INSERT INTO activities (id, translations, name, project)
    VALUES ('activity-1', '{}', 'Activity', 'project-1');
    INSERT INTO teams (id, activity)
    VALUES ('team-1', 'activity-1');
    INSERT INTO assignments
      (id, activity, team, org_unit, sync_state, disabled)
    VALUES
      ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0);
  ''');
}
