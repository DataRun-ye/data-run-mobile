import 'dart:async';
import 'dart:io';

import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/auth/token_refresher.dart';
import 'package:datarunmobile/core/auth/token_string_extension.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required AuthStorage authStorage,
    required AuthManager authManager,
    required TokenRefresher tokenRefresher,
  })  : _authStorage = authStorage,
        _authManager = authManager,
        _tokenRefresher = tokenRefresher,
        retryClient = Dio()
          ..options = BaseOptions(baseUrl: AppEnvironment.apiBaseUrl);

  final AuthStorage _authStorage;
  final AuthManager _authManager;
  final TokenRefresher _tokenRefresher;

  late final Dio retryClient;

  Future<TokenPair?> _getTokenPair() {
    return _authStorage.getActiveUserToken();
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

      var tokenPair = await _getTokenPair();
      if (tokenPair == null) {
        return handler.next(options);
      }

      if (!tokenPair.accessToken.isAccessTokenValid) {
        tokenPair = await _refresh(options);
      }

      options.headers.addAll(_buildHeaders(tokenPair));
      return handler.next(options);
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

    final tokenPair = await _getTokenPair();

    if (tokenPair == null) {
      return handler.reject(err);
    }

    try {
      // error is 401 Unauthorized, and access token still valid,
      // Retry immediately (transient error)
      if (tokenPair.accessToken.isAccessTokenValid) {
        logDebug(
            'error is 401  Unauthorized, err code: (${err.response?.statusCode}), and access token still valid, Retry immediately (transient error)');
        final previousRequest = await _retry(
          err.requestOptions,
          tokenPair: tokenPair,
        );
        return handler.resolve(previousRequest);
      } else {
        // error is 401 Unauthorized, and access token invalid,
        // Refresh tokens then retry
        logDebug(
            'error is 401  Unauthorized, err code: (${err.response?.statusCode}), and access token still invalid, Refresh tokens then retry');
        final newTokenPair = await _refresh(err.requestOptions);
        final previousRequest = await _retry(
          err.requestOptions,
          tokenPair: newTokenPair,
        );
        return handler.resolve(previousRequest);
      }
    } on RevokeTokenException catch (revokeError) {
      /// call the session expire logic for state management
      logError('could not refresh accessToken...', source: this);
      return handler.reject(revokeError);
    } on DioException catch (retryError) {
      if (shouldRefresh(retryError.response)) {
        await _authManager.expireSession();
        return handler.reject(
          RevokeTokenException(requestOptions: retryError.requestOptions),
        );
      }
      return handler.next(retryError);
    }
  }

  Future<TokenPair> _refresh(RequestOptions options) async {
    logDebug('refreshing token');

    try {
      return await _tokenRefresher.refreshToken(
        _authStorage.getActiveUserId(),
      );
    } catch (e, s) {
      logError('could not refresh accessToken, clearing and revoke out...',
          source: e, stackTrace: s);
      await _authManager.expireSession();
      throw RevokeTokenException(requestOptions: options);
    }
  }

  FutureOr<Response<R>> _retry<R>(
    RequestOptions requestOptions, {
    required TokenPair tokenPair,
  }) async {
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
        headers: Map<String, dynamic>.from(requestOptions.headers)
          ..addAll(_buildHeaders(tokenPair)),
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

  Map<String, dynamic> _buildHeaders(TokenPair tokenPair) {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer ${tokenPair.accessToken}'
    };
  }

  /// Check if the token pair should be refreshed
  @pragma('vm:prefer-inline')
  bool shouldRefresh<R>(Response<R>? response) => response?.statusCode == 401;
}
