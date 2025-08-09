import 'package:d_sdk/core/secure_storage/storage_service.dart';
import 'package:d_sdk/core/user/cache_keys.dart';
import 'package:d_sdk/core/user_session/user_session.dart';

class TokenStorage {
  TokenStorage({required StorageService storage}) : _storage = storage;

  final StorageService _storage;

  // final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // final bool shouldClearBeforeSave;
  // Store tokens for a specific user
  Future<void> saveTokens(String userId, TokenPair tokenPair) async {
    await _storage.write(
        CacheKeys.getAccessTokenKey(userId), tokenPair.accessToken);
    await _storage.write(
        CacheKeys.getRefreshTokenKey(userId), tokenPair.refreshToken);
    // Optionally, store token expiry for proactive refresh
    await _storage.write(CacheKeys.getExpiryDateKey(userId),
        DateTime.now().add(Duration(hours: 1)).toIso8601String());
  }

  // Retrieve tokens for a specific user
  Future<TokenPair?> getTokens(String userId) async {
    final accessToken =
        await _storage.read(CacheKeys.getAccessTokenKey(userId));
    final refreshToken =
        await _storage.read(CacheKeys.getRefreshTokenKey(userId));
    if (accessToken == null ||
        refreshToken == null) {
      return null;
    }
    return (accessToken: accessToken, refreshToken: refreshToken);
  }

  // Delete tokens for a specific user (on logout)
  Future<void> deleteTokens(String userId) async {
    await _storage.delete(CacheKeys.getAccessTokenKey(userId));
    await _storage.delete(CacheKeys.getRefreshTokenKey(userId));
    await _storage.delete(CacheKeys.getExpiryDateKey(userId));
  }

  // Get a list of all stored user IDs (or a way to identify them)
  // This can be tricky. You might need to store a list of active user IDs
  // in a less sensitive but still private storage (e.g., SharedPreferences,
  // or a small, non-sensitive Drift table).
  // For simplicity, let's assume you fetch a list of available users from a backend
  // or a non-sensitive local record of past logins.
  // Alternatively, you can iterate through all keys if they follow a pattern:
  Future<List<String>> getAllUserIdsWithTokens() async {
    final allKeys = await _storage.readAll();
    final userIds = <String>{};
    for (var key in allKeys.keys) {
      if (key.startsWith('${CacheKeys.accessTokenKey}_')) {
        userIds.add(key.replaceFirst('${CacheKeys.accessTokenKey}_', ''));
      }
    }
    return userIds.toList();
  }

  // Clear all tokens (e.g., app reset)
  Future<void> clearAllTokens() async {
    await _storage.deleteAll();
  }
}
