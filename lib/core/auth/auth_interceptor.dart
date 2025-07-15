import 'dart:async';
import 'dart:io';

import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required AuthStorage authStorage})
      : this._authStorage = authStorage,
        this.refreshClient = Dio()
          ..options = BaseOptions(baseUrl: AppEnvironment.apiBaseUrl),
        this.retryClient = Dio()
          ..options = BaseOptions(baseUrl: AppEnvironment.apiBaseUrl);

  final AuthStorage _authStorage;

  late final Dio refreshClient;
  late final Dio retryClient;

  Future<TokenPair?> _getTokenPair() {
    return _authStorage.getActiveUserToken();
  }

  Future<void> _clearTokenPair() async {
    await _authStorage.clearActiveUser();
  }

  Future<bool> get _isAccessTokenValid async {
    final tokenPair = await _getTokenPair();

    if (tokenPair == null) {
      return false;
    }

    final decodedJwt = JWT.decode(tokenPair.accessToken);
    final expirationTimeEpoch = decodedJwt.payload['exp'];
    final expirationDateTime =
        DateTime.fromMillisecondsSinceEpoch(expirationTimeEpoch * 1000);

    final marginOfErrorInMilliseconds = 1000; // Safety margin: 1 sec
    final addedMarginTime = Duration(milliseconds: marginOfErrorInMilliseconds);

    return DateTime.now().add(addedMarginTime).isBefore(expirationDateTime);
  }

  /// The following method will check if the token is valid or not:
  ///
  /// If it is valid, it will send the request to the server with the current
  /// access token in the header.
  /// Otherwise, it will send a refresh request to the server, and try to renew
  /// cached tokens.
  ///
  /// If you want to skip the token validation process (public APIs),
  /// mark the requests to bypass it by setting an extra property:
  /// ```dart
  ///  dio.get('/public-endpoint', options: Options(extra: {'skipAuth': true}));
  /// ```
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // if (options.extra['skipAuth'] == true) {
      //   return handler.next(options);
      // }

      final tokenPair = await _getTokenPair();
      if (tokenPair == null) {
        return handler.next(options);
      }

      final isAccessTokenValid = await _isAccessTokenValid;

      // if tokenPair exists && access valid, Add auth header
      if (isAccessTokenValid) {
        options.headers.addAll(await _buildHeaders());
        return handler.next(options);
      } else {
        // if tokenPair exists && access invalid, refresh
        final newTokenPair = await _refresh(
          options: options,
          tokenPair: tokenPair,
        );

        // if refresh failed, throw error
        if (newTokenPair == null) {
          return handler.reject(
            RevokeTokenException(requestOptions: options),
            true,
          );
        }

        // if refresh success, Update header with new token
        options.headers.addAll(await _buildHeaders());
        return handler.next(options);
      }
    } catch (_) {
      // Trigger auth failure
      return handler.reject(
        RevokeTokenException(requestOptions: options),
        true,
      );
    }
  }

  /// If the status code of the error is not 401, it will skip all the processes
  /// and will throw an exception to your data layer (or where you handle HTTP
  /// requests).
  ///
  /// We again repeat the validation of the access token. It ensures that,
  /// although we get many 401 errors from different endpoints, only the first
  /// will work (will try to refresh the token). For all other requests, only
  /// the retry mechanism will be applied.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err is RevokeTokenException) {
      /// call the session expire logic for state management
      return handler.reject(err);
    }

    if (!shouldRefresh(err.response)) {
      return handler.next(err);
    }

    final isAccessValid = await _isAccessTokenValid;
    final tokenPair = await _getTokenPair();

    if (tokenPair == null) {
      return handler.reject(err);
    }

    try {
      // error is 401 Unauthorized, and access token still valid,
      // Retry immediately (transient error)
      if (isAccessValid) {
        logDebug(
            'error is 401  Unauthorized, err code: (${err.response?.statusCode}), and access token still valid, Retry immediately (transient error)');
        final previousRequest = await _retry(err.requestOptions);
        return handler.resolve(previousRequest);
      } else {
        // error is 401 Unauthorized, and access token invalid,
        // Refresh tokens then retry
        logDebug(
            'error is 401  Unauthorized, err code: (${err.response?.statusCode}), and access token still invalid, Refresh tokens then retry');
        await _refresh(options: err.requestOptions, tokenPair: tokenPair);
        final previousRequest = await _retry(err.requestOptions);
        return handler.resolve(previousRequest);
      }
    } on RevokeTokenException {
      /// call the session expire logic for state management
      logError('could not refresh accessToken...', source: this);
      return handler.reject(err);
    } on DioException catch (err) {
      return handler.next(err);
    }
  }

  Future<TokenPair?> _refresh({
    required RequestOptions options,
    TokenPair? tokenPair,
  }) async {
    logDebug('refreshing token');
    if (tokenPair == null) {
      logDebug('not token pair to refresh');
      throw RevokeTokenException(requestOptions: options);
    }

    try {
      // refreshClient
      //   ..options = refreshClient.options.copyWith(
      //     headers: {'refreshToken': tokenPair.refreshToken},
      //   );

      final response = await refreshClient.post('/v1/refresh',
        data: {'refreshToken': tokenPair.refreshToken},
      );

      final TokenPair newTokenPair = (
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
      );

      //// handled in _sessionRepository
      // if (shouldClearBeforeReset) {
      //   await _clearTokenPair();
      // }
      // await _saveTokenPair(newTokenPair);
      //
      await _authStorage.updateActiveUserToken(tokenPair);
      return newTokenPair;
    } catch (e, s) {
      logError('could not refresh accessToken, clearing and revoke out...',
          source: e, stackTrace: s);
      await _clearTokenPair();
      throw RevokeTokenException(requestOptions: options);
    }
  }

  FutureOr<Response<R>> _retry<R>(RequestOptions requestOptions) async {
    return retryClient.request<R>(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data is FormData
          ? (requestOptions.data as FormData).clone()
          : requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        headers: requestOptions.headers..addAll(await _buildHeaders()),
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        maxRedirects: requestOptions.maxRedirects,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        listFormat: requestOptions.listFormat,
      ),
    );
  }

  Future<Map<String, dynamic>> _buildHeaders() async {
    final tokenPair = await _getTokenPair();
    final authorizedHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer ${tokenPair!.accessToken}'
    };

    return authorizedHeaders;
  }

  /// Check if the token pair should be refreshed
  @visibleForTesting
  @pragma('vm:prefer-inline')
  bool shouldRefresh<R>(Response<R>? response) => response?.statusCode == 401;
}
