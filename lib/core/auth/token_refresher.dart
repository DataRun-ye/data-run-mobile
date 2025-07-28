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
          ..options.baseUrl = AppEnvironment.apiBaseUrl
          ..options.headers = {
            'content-type': 'application/json; charset=utf-8'
          }
          ..options.connectTimeout = const Duration(seconds: 10)
          ..options.receiveTimeout = const Duration(seconds: 10);

  final TokenStorage _storage;
  final Dio _refreshClient;

  final _refreshLocks = <String, Future<TokenPair>>{};

  String get apiPath => AppEnvironment.apiV1Path;

  Future<TokenPair> refreshToken(String userId) async {
    // Prevent dulicate refresh calls
    if (_refreshLocks.containsKey(userId)) {
      return _refreshLocks[userId]!;
    }

    final completer = Completer<TokenPair>();
    _refreshLocks[userId] = completer.future;

    try {
      final tokens = await _storage.getTokens(userId);
      final response = await _refreshClient.post('$apiPath/refresh',
          data: {'refreshToken': tokens!.refreshToken},
          options: Options(
            extra: {'skipAuth': true},
            receiveTimeout: const Duration(seconds: 70),
            sendTimeout: const Duration(seconds: 40),
          ));

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
