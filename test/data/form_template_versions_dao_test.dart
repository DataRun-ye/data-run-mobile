import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'versions-test-user',
    );
    await database.customStatement('''
      INSERT INTO form_templates (id, version_uid, version_number, name)
      VALUES ('form-1', 'version-3', 3, 'Form');
    ''');
  });

  tearDown(() => database.close());

  Future<Set<String>> storedVersionIds() async {
    final rows = await database.select(database.formTemplateVersions).get();
    return rows.map((row) => row.id).toSet();
  }

  test('keeps a version that a local submission uses after the server stops '
      'sending it', () async {
    await database.batch((batch) {
      batch.insertAll(database.formTemplateVersions, [
        _version('version-1', 1),
        _version('version-2', 2),
      ]);
    });
    await database.into(database.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: 'submission-1',
            formTemplate: 'form-1',
            templateVersion: 'version-1',
            syncState: InstanceSyncStatus.synced,
            isToUpdate: true,
          ),
        );

    await database.formTemplateVersionsDao
        .replaceKeepingVersionsInUse([_version('version-3', 3)]);

    expect(await storedVersionIds(), {'version-1', 'version-3'});
  });

  test('replaces every unused version with what the server sent', () async {
    await database
        .into(database.formTemplateVersions)
        .insert(_version('version-1', 1));

    await database.formTemplateVersionsDao.replaceKeepingVersionsInUse([
      _version('version-2', 2),
      _version('version-3', 3),
    ]);

    expect(await storedVersionIds(), {'version-2', 'version-3'});
  });

  test('updates a version the server sends again', () async {
    await database
        .into(database.formTemplateVersions)
        .insert(_version('version-3', 3));

    await database.formTemplateVersionsDao
        .replaceKeepingVersionsInUse([_version('version-3', 4)]);

    final stored = await database.select(database.formTemplateVersions).get();
    expect(stored.single.versionNumber, 4);
  });
}

FormTemplateVersion _version(String id, int number) => FormTemplateVersion(
      id: id,
      template: 'form-1',
      versionNumber: number,
      fields: const [],
      sections: const [],
      options: const [],
    );
