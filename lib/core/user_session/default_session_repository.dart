import 'dart:convert';

import 'package:d_sdk/user_session/user_session.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SessionRepository)
class DefaultSessionRepository implements SessionRepository {
  DefaultSessionRepository(
      {required CacheStorageAdapter storageAdapter,
      @Named('shouldClearBeforeSave') this.shouldClearBeforeSave = true})
      : _storageAdapter = storageAdapter;
  final CacheStorageAdapter _storageAdapter;

  final bool shouldClearBeforeSave;

  Future<void> updateActiveSessionTokenPair(TokenPair tokenPair) async {
    final currentSession = await getActiveSession();
    if (currentSession != null) {
      await updateActiveSession(currentSession.copyWith(
          accessToken: tokenPair.accessToken,
          refreshToken: tokenPair.refreshToken));
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
    await _storageAdapter.delete(CacheKeys.activeSessionKey);
  }
}
