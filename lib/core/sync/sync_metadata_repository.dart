import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/model/sync_interval.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Whether a session's first sync is done and when its last sync ran.
///
/// Both describe one session's local data, so they are kept per session
/// ([UserSession.localId]): a practice session and the real session of the same
/// account each keep their own, as do two accounts on one phone. The sync
/// interval is a phone setting and stays shared.
@injectable
class SyncMetadataRepository {
  SyncMetadataRepository(this._prefs) : _activeSession = _currentSession;

  /// For tests: reads the active session from [activeSession].
  SyncMetadataRepository.forSession(this._prefs, this._activeSession);

  /// Keys of the per-session values are these names plus ':' and the session's
  /// [UserSession.localId]. Up to 6.1.0 the values were kept once per phone
  /// under the bare names; a real session still reads those until it records
  /// its own, so updating the app does not force a sync.
  static const String LAST_SYNC_TIME = 'last_sync_time';
  static const String SYNC_INTERVAL = 'sync_interval';
  static const String SYNC_DONE = 'sync_done';

  final SharedPreferences _prefs;
  final UserSession? Function() _activeSession;

  static UserSession? _currentSession() => appLocator.isRegistered<AuthManager>()
      ? appLocator<AuthManager>().activeUserSession
      : null;

  static String _key(String name, String localId) => '$name:$localId';

  /// Records a completed sync for the active session.
  Future<void> recordSuccessfulSync() async {
    final session = _activeSession();
    if (session == null) return;
    await Future.wait([
      _prefs.setBool(_key(SYNC_DONE, session.localId), true),
      _prefs.setInt(_key(LAST_SYNC_TIME, session.localId),
          DateTime.now().millisecondsSinceEpoch),
    ]);
  }

  /// Forgets a session's sync state, so the app keeps syncing it on start until
  /// a sync completes. A new practice session begins this way: what an earlier
  /// practice day recorded says nothing about the data this one will download.
  Future<void> clearSession(String localId) async {
    await Future.wait([
      _prefs.remove(_key(SYNC_DONE, localId)),
      _prefs.remove(_key(LAST_SYNC_TIME, localId)),
    ]);
  }

  Future<bool> setSyncInterval(SyncInterval interval) async {
    return _prefs.setInt(SYNC_INTERVAL, interval.milliseconds);
  }

  DateTime? get lastSyncTime {
    final millis = getLastSyncTimeMillis();
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  int? getLastSyncTimeMillis() {
    final session = _activeSession();
    if (session == null) return null;
    return _prefs.getInt(_key(LAST_SYNC_TIME, session.localId)) ??
        (session.practice ? null : _prefs.getInt(LAST_SYNC_TIME));
  }

  SyncInterval getSyncInterval() {
    final intervalMs = _prefs.getInt(SyncMetadataRepository.SYNC_INTERVAL) ??
        SyncInterval.biweekly.milliseconds;
    return SyncInterval.values.firstWhere(
        (interval) => interval.milliseconds == intervalMs,
        orElse: () => SyncInterval.biweekly);
  }

  bool get isInitialSyncDone {
    final session = _activeSession();
    if (session == null) return false;
    return _prefs.getBool(_key(SYNC_DONE, session.localId)) ??
        (!session.practice && (_prefs.getBool(SYNC_DONE) ?? false));
  }
}
