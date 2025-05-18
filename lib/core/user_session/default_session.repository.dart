import 'dart:convert';

import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/user_session/cache_keys.dart';
import 'package:d_sdk/user_session/cache_storage_adapter.dart';
import 'package:d_sdk/user_session/session_context.dart';
import 'package:d_sdk/user_session/session_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SessionRepository)
class DefaultSessionRepository implements SessionRepository {
  DefaultSessionRepository(
      {required CacheStorageAdapter storageAdapter,
      @Named('shouldClearBeforeSave') this.shouldClearBeforeSave = true})
      : _storageAdapter = storageAdapter;
  final CacheStorageAdapter _storageAdapter;

  final bool shouldClearBeforeSave;

  Future<void> updateActiveSessionTokenPair(TokenPair tokenPair) async {
    logDebug('Update Cached Active session\'s token Pair', source: this);
    try {
      final currentSession = await getActiveSession();
      if (currentSession == null) {
        logDebug('No Cached Active session to update token Pair', source: this);
        throw NoCachedAuthenticatedUser(
            message: 'No Cached Active session to update token Pair');
      }
      await updateActiveSession(currentSession.copyWith(
          accessToken: tokenPair.accessToken,
          refreshToken: tokenPair.refreshToken));
    } catch (e) {
      logDebug('Error updating active Session token pair', source: this);
      rethrow;
    }
  }

  @override
  Future<void> updateActiveSession(SessionContext session) async {
    if (shouldClearBeforeSave) {
      await _storageAdapter.delete(CacheKeys.activeSessionKey);
    }
    return _storageAdapter.save(
        key: CacheKeys.activeSessionKey, value: jsonEncode(session.toMap()));
  }

  @override
  Future<SessionContext?> getActiveSession() async {
    final String? storedActiveSession =
        await _storageAdapter.fetch(CacheKeys.activeSessionKey);

    if (storedActiveSession != null) {
      final Map<String, dynamic> decoded = jsonDecode(storedActiveSession);
      return SessionContext.fromMap(decoded);
    }

    return null;
  }

  @override
  Future<void> clearActiveSession() async {
    logDebug('Clear Active session', source: this);
    await _storageAdapter.delete(CacheKeys.activeSessionKey);
  }
}
