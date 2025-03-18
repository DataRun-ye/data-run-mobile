import 'package:d_sdk/core/config/server_config.dart';
import 'package:d_sdk/database/data_base_connector.dart';
import 'package:d_sdk/core/auth/auth_manager.dart';
import 'package:d_sdk/core/sync/sync_tracker.dart';
import 'package:datarunmobile/commons/extensions/iterable_extensions.dart';

class LoginUseCase {
  final AuthManager _authManager;
  final AppDatabaseConnector _dbManager;
  final SyncConflictResolver _conflictResolver;

  Future<void> execute(
      String email, String password, ServerConfig server) async {
    // 1. Check for existing data conflicts
    final cachedUsers = await _authManager.getCachedUsers();
    final existingUser = cachedUsers.firstWhereOrNull((u) => u.email == email);

    if (existingUser != null && existingUser.baseUrl != server) {
      // Trigger conflict resolution UI
      final resolution = await _conflictResolver.resolveServerSwitchConflict(
        oldServer: existingUser.baseUrl,
        newServer: server,
      );
      if (resolution.abortLogin) return;
    }

    // 2. Proceed with login
    await _authManager.login(email, password, server);

    // 3. Initialize user-specific DB
    final db = await _dbManager.connectForUser(
      userId: email,
      server: server,
    );

    // 4. Check for unsynced data
    final syncTracker = SyncTracker(db);
    if (await syncTracker.hasUnSyncedChanges()) {
      _conflictResolver.showSyncWarning();
    }
  }
}
