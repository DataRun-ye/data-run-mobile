import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'requeue-test',
    );
  });

  tearDown(() => database.close());

  Future<void> insert(String id, InstanceSyncStatus state) =>
      database.into(database.dataInstances).insert(
            DataInstancesCompanion.insert(
              id: id,
              formTemplate: 'form-1',
              templateVersion: 'form-1-v1',
              syncState: state,
              isToUpdate: false,
            ),
          );

  Future<InstanceSyncStatus> stateOf(String id) async =>
      (await database.dataInstancesDao.getById(id))!.syncState;

  test('an upload cut off by the app stopping is offered for sending again',
      () async {
    await insert('cut-off', InstanceSyncStatus.uploading);
    await insert('ready', InstanceSyncStatus.finalized);
    await insert('failed', InstanceSyncStatus.syncFailed);
    await insert('sent', InstanceSyncStatus.synced);
    await insert('draft', InstanceSyncStatus.draft);

    expect(await database.dataInstancesDao.prepareUpload(['cut-off']), isEmpty,
        reason: 'before the fix such a row could never be sent');
    // prepareUpload above found nothing, so it changed nothing.

    final requeued =
        await database.dataInstancesDao.requeueInterruptedUploads();

    expect(requeued, 1);
    expect(await stateOf('cut-off'), InstanceSyncStatus.finalized);
    expect(await stateOf('ready'), InstanceSyncStatus.finalized);
    expect(await stateOf('failed'), InstanceSyncStatus.syncFailed);
    expect(await stateOf('sent'), InstanceSyncStatus.synced);
    expect(await stateOf('draft'), InstanceSyncStatus.draft);
    expect(
      (await database.dataInstancesDao.prepareUpload(['cut-off']))
          .map((s) => s.id),
      ['cut-off'],
    );
  });
}
