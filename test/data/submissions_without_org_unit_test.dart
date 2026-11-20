import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// An assignment can be listed before its org unit arrives (a partly failed
/// sync). A submission made on it must still appear in the submissions table,
/// where uploads are started, and be counted.
void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory(), userId: 'test-user');
    await db.batch((batch) {
      batch.insert(
          db.formTemplates,
          FormTemplatesCompanion.insert(
              id: 'form',
              versionUid: 'version',
              versionNumber: 1,
              name: 'Form'));
      batch.insert(
          db.formTemplateVersions,
          FormTemplateVersionsCompanion.insert(
              id: 'version',
              template: 'form',
              versionNumber: 1,
              fields: const [],
              sections: const []));
      batch.insert(
          db.assignments,
          AssignmentsCompanion.insert(
            id: 'managed-assignment',
            activity: 'itn',
            team: 'team-573',
            orgUnit: 'village-not-synced',
            syncState: InstanceSyncStatus.synced,
            disabled: const Value(false),
          ));
      batch.insert(
          db.dataInstances,
          DataInstancesCompanion.insert(
            id: 'submission',
            formTemplate: 'form',
            templateVersion: 'version',
            syncState: InstanceSyncStatus.finalized,
            isToUpdate: false,
            assignment: const Value('managed-assignment'),
          ));
    });
  });

  tearDown(() => db.close());

  test('is listed and counted though its org unit has not arrived', () async {
    final rows = await db.dataInstancesDao.selectable(null, paged: false).get();

    expect(rows.map((row) => row.id), ['submission']);
    expect(await db.dataInstancesDao.countSubmissions(null).getSingle(), 1);
  });
}
