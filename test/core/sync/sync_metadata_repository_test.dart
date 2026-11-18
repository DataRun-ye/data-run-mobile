import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SyncMetadataRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    repository = SyncMetadataRepository(await SharedPreferences.getInstance());
  });

  test('a practice sync does not mark the phone as synced', () async {
    await repository.recordSuccessfulSync(practice: true);

    expect(repository.isInitialSyncDone, isFalse,
        reason: 'the real session must still sync on its own');
    expect(repository.lastSyncTime, isNull);
  });

  test('a real sync marks the phone as synced', () async {
    await repository.recordSuccessfulSync(practice: false);

    expect(repository.isInitialSyncDone, isTrue);
    expect(repository.lastSyncTime, isNotNull);
  });
}
