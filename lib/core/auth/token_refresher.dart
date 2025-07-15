import 'dart:async';

import 'package:d_sdk/core/auth/token_storage.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class TokenRefresher {
  TokenRefresher(this._storage)
      : _refreshClient = Dio()
          ..options = BaseOptions(baseUrl: AppEnvironment.apiBaseUrl);

  final TokenStorage _storage;
  final Dio _refreshClient;

  final _refreshLocks = <String, Future<TokenPair>>{};

  Future<TokenPair> refreshToken(String userId) async {
    // Prevent dulicate refresh calls
    if (_refreshLocks.containsKey(userId)) {
      return _refreshLocks[userId]!;
    }

    final completer = Completer<TokenPair>();
    _refreshLocks[userId] = completer.future;

    try {
      final tokens = await _storage.getTokens(userId);
      final response = await _refreshClient.post(
        '/v1/refresh',
        data: {'refreshToken': tokens!.refreshToken},
      );

      final TokenPair newTokenPair = (
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
      );
      await _storage.saveTokens(userId, newTokenPair);

      completer.complete(newTokenPair);
      return newTokenPair;
    } catch (e) {
      completer.completeError(e);
      throw e;
    } finally {
      _refreshLocks.remove(userId);
    }
  }
}
