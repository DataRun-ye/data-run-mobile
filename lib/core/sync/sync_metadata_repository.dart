import 'package:datarunmobile/core/sync/model/sync_interval.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SyncMetadataRepository {
  SyncMetadataRepository(this._prefs);

  /// cache keys for storing syncing metadata
  static const String LAST_SYNC_TIME = 'last_sync_time';
  static const String SYNC_INTERVAL = 'sync_interval';
  static const String SYNC_DONE = 'sync_done';

  /// local cache will be used to store syncing metadata
  final SharedPreferences _prefs;

  Future<void> updateLastSync() {
    return _prefs.setInt(LAST_SYNC_TIME, DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> updateInitialSyncDone(bool isDone) {
    return _prefs.setBool(SYNC_DONE, isDone);
  }

  Future<bool> setSyncInterval(SyncInterval interval) async {
    return _prefs.setInt(SYNC_INTERVAL, interval.milliseconds);
  }

  DateTime? get lastSyncTime => getLastSyncTimeMillis() != null
      ? DateTime.fromMillisecondsSinceEpoch(getLastSyncTimeMillis()!)
      : null;

  int? getLastSyncTimeMillis() {
    final lastSyncTime = _prefs.getInt(LAST_SYNC_TIME);
    return lastSyncTime;
  }

  SyncInterval getSyncInterval() {
    final intervalMs = _prefs.getInt(SyncMetadataRepository.SYNC_INTERVAL) ??
        SyncInterval.biweekly.milliseconds;
    return SyncInterval.values.firstWhere(
        (interval) => interval.milliseconds == intervalMs,
        orElse: () => SyncInterval.biweekly);
  }

  bool get isInitialSyncDone =>
      _prefs.getBool(SYNC_DONE) ?? false;
}
