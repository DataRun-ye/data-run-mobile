import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const real = UserSession(
    id: 'user-1',
    username: 'field-user',
    activated: true,
    authorities: ['ROLE_USER'],
    activityUIDs: ['activity-1'],
    userTeamsUIDs: ['team-1'],
    managedTeamsUIDs: [],
    userGroupsUIDs: [],
    userFormsUIDs: ['form-1'],
  );
  final practice = real.asPractice(DateTime(2026, 11, 19, 8));

  late SharedPreferences prefs;

  SyncMetadataRepository repositoryFor(UserSession? session) =>
      SyncMetadataRepository.forSession(prefs, () => session);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  test('a practice sync is remembered for practice only', () async {
    await repositoryFor(practice).recordSuccessfulSync();

    expect(repositoryFor(practice).isInitialSyncDone, isTrue,
        reason: 'reopening practice must not sync again');
    expect(repositoryFor(practice).lastSyncTime, isNotNull);
    expect(repositoryFor(real).isInitialSyncDone, isFalse,
        reason: 'the real session must still sync on its own');
    expect(repositoryFor(real).lastSyncTime, isNull);
  });

  test('a real sync does not mark practice as synced', () async {
    await repositoryFor(real).recordSuccessfulSync();

    expect(repositoryFor(real).isInitialSyncDone, isTrue);
    expect(repositoryFor(real).lastSyncTime, isNotNull);
    expect(repositoryFor(practice).isInitialSyncDone, isFalse);
  });

  test('a real session keeps the sync recorded before 6.1.1', () async {
    final recorded = DateTime(2026, 11, 18, 21).millisecondsSinceEpoch;
    SharedPreferences.setMockInitialValues({
      SyncMetadataRepository.SYNC_DONE: true,
      SyncMetadataRepository.LAST_SYNC_TIME: recorded,
    });
    prefs = await SharedPreferences.getInstance();

    expect(repositoryFor(real).isInitialSyncDone, isTrue,
        reason: 'updating the app must not force a sync');
    expect(repositoryFor(real).getLastSyncTimeMillis(), recorded);
    expect(repositoryFor(practice).isInitialSyncDone, isFalse,
        reason: 'the phone-wide values were written by real sessions');
    expect(repositoryFor(practice).lastSyncTime, isNull);
  });

  test('clearing a session makes it sync again', () async {
    await repositoryFor(practice).recordSuccessfulSync();
    await repositoryFor(real).recordSuccessfulSync();

    await repositoryFor(practice).clearSession(practice.localId);

    expect(repositoryFor(practice).isInitialSyncDone, isFalse);
    expect(repositoryFor(practice).lastSyncTime, isNull);
    expect(repositoryFor(real).isInitialSyncDone, isTrue,
        reason: 'only the cleared session forgets');
  });

  test('without a session nothing counts as synced', () async {
    await repositoryFor(null).recordSuccessfulSync();

    expect(repositoryFor(null).isInitialSyncDone, isFalse);
    expect(repositoryFor(null).lastSyncTime, isNull);
    expect(repositoryFor(real).isInitialSyncDone, isFalse);
  });
}
