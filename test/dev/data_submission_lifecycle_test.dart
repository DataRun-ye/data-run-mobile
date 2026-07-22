import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
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

  test('draft saves do not create or advance completion time', () async {
    await _insertSubmission(db, id: 'new-draft');

    await db.dataInstancesDao.updateData(
      'new-draft',
      data: {'field': 'value'},
    );

    final newDraft = await db.dataInstancesDao.getById('new-draft');
    expect(newDraft?.syncState, InstanceSyncStatus.draft);
    expect(newDraft?.finishedEntryTime, isNull);

    final previousCompletion = DateTime.utc(2025, 1, 2, 3, 4, 5);
    await _insertSubmission(
      db,
      id: 'reopened',
      syncState: InstanceSyncStatus.finalized,
      finishedEntryTime: previousCompletion,
    );

    await db.dataInstancesDao.updateData(
      'reopened',
      data: {'field': 'revised'},
    );

    final reopened = await db.dataInstancesDao.getById('reopened');
    expect(reopened?.syncState, InstanceSyncStatus.draft);
    expect(reopened?.finishedEntryTime, previousCompletion);
  });

  test('marking final records completion time', () async {
    await _insertSubmission(db, id: 'completed');

    await db.dataInstancesDao.markFinal('completed');

    final completed = await db.dataInstancesDao.getById('completed');
    expect(completed?.syncState, InstanceSyncStatus.finalized);
    expect(completed?.finishedEntryTime, isNotNull);
  });
}

Future<void> _insertSubmission(
  AppDatabase db, {
  required String id,
  InstanceSyncStatus syncState = InstanceSyncStatus.draft,
  DateTime? finishedEntryTime,
}) async {
  await db.into(db.dataInstances).insert(
        DataInstancesCompanion.insert(
          id: id,
          formTemplate: 'form-1',
          templateVersion: 'version-1',
          syncState: syncState,
          isToUpdate: false,
          finishedEntryTime: Value.absentIfNull(finishedEntryTime),
        ),
      );
}
