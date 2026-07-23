import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/token_storage.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenRefresher {
  TokenRefresher(this._storage, this._authApi);

  final TokenStorage _storage;
  final AuthApi _authApi;

  final _refreshLocks = <String, Future<TokenPair>>{};

  Future<TokenPair> refreshToken(String userId) {
    // Refresh-token rotation makes concurrent refresh requests unsafe.
    final existingRefresh = _refreshLocks[userId];
    if (existingRefresh != null) {
      return existingRefresh;
    }

    late final Future<TokenPair> refresh;
    refresh = _refreshAndPersist(userId).whenComplete(() {
      if (identical(_refreshLocks[userId], refresh)) {
        _refreshLocks.remove(userId);
      }
    });
    _refreshLocks[userId] = refresh;
    return refresh;
  }

  Future<TokenPair> _refreshAndPersist(String userId) async {
    final tokens = await _storage.getTokens(userId);
    if (tokens == null) {
      throw StateError('No cached tokens for user: $userId');
    }

    final newTokenPair = await _authApi.refreshToken(tokens.refreshToken);
    await _storage.saveTokens(userId, newTokenPair);

    return newTokenPair;
  }
}
