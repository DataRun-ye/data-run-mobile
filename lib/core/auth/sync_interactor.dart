import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SyncInteractor {
  SyncInteractor(this.preferences);

  final SharedPreferences preferences;

  /// Check if the initial sync has been performed
  bool isSyncDone() {
    final syncStatus = preferences.getString('WAS_INITIAL_SYNC_DONE') ?? '';
    return syncStatus == 'True';
  }

  /// Mark sync as completed
  Future<void> markSyncDone() async {
    await preferences.setString('WAS_INITIAL_SYNC_DONE', 'True');
  }

  /// Optionally, you can reset or clear sync status
  Future<void> resetSync() async {
    await preferences.remove('WAS_INITIAL_SYNC_DONE');
  }
}
