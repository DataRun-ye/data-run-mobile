import 'package:d_sdk/core/auth/token_storage.dart';
import 'package:d_sdk/core/exception/no_cached_authenticated_user.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user/cache_keys.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/user_session/session_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthStorage {
  AuthStorage(
      {required TokenStorage tokenStorage,
      required SessionStorage sessionStorage,
      required SharedPreferences prefs})
      : _tokenStorage = tokenStorage,
        _sessionStorage = sessionStorage,
        _prefs = prefs;

  final TokenStorage _tokenStorage;
  final SessionStorage _sessionStorage;
  final SharedPreferences _prefs;

  String getActiveUserId() {
    final activeUserId = _prefs.get(CacheKeys.activeUserKey) as String?;
    if (activeUserId.isNullOrEmpty) {
      logDebug('No cached last login userId: $activeUserId',
          source: 'AuthStorage');
      throw NoCachedAuthenticatedUser(message: 'last login user');
    }
    return activeUserId!;
  }

  UserSession getActiveSession() {
    final activeUserId = getActiveUserId();
    final activeSession = _sessionStorage.readSession(activeUserId);
    if (activeSession == null) {
      logDebug('No Cached Token for active user: $activeUserId',
          source: this);
      _prefs.remove(CacheKeys.activeUserKey);
      throw NoCachedAuthenticatedUser(
          message: 'No Active UserSession for user: $activeSession');
    }
    return activeSession;
  }

  Future<TokenPair> getActiveUserToken() async {
    final activeSession = getActiveSession();

    final TokenPair? tokenPair =
        await _tokenStorage.getTokens(activeSession.username);

    if (tokenPair == null) {
      logDebug('No Cached Token for active user: ${activeSession.username}',
          source: this);
      await _prefs.remove(CacheKeys.activeUserKey);
      throw NoCachedAuthenticatedUser(
          message: 'No Cached Token for active user: $activeSession');
    }

    return tokenPair;
  }

  Future<void> setActiveSession(UserSession userSession) async {
    await _prefs.setString(CacheKeys.activeUserKey, userSession.username);
    return _sessionStorage.writeSession(userSession.username,
        session: userSession);
  }

  Future<void> updateActiveUserSession(UserSession userSession) async {
    return _sessionStorage.writeSession(getActiveUserId(),
        session: userSession);
  }

  Future<void> updateActiveUserToken(TokenPair tokenPair) {
    return _tokenStorage.saveTokens(getActiveUserId(), tokenPair);
  }

  Future<void> clearActiveUser() async {
    try {
      logDebug('clearing active user credentials', source: this);
      await _prefs.remove(CacheKeys.activeUserKey);
      await _tokenStorage.deleteTokens(getActiveUserId());
    } catch (_) {}
  }

  Future<void> setActiveCredentials(String userId, TokenPair tokenPair) async {
    await _prefs.setString(CacheKeys.activeUserKey, userId);
    await _tokenStorage.saveTokens(userId, tokenPair);
  }
}
