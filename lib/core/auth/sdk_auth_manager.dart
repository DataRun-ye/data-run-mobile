import 'package:d_sdk/auth/auth_manager.dart';
import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/use_cases/logout_strategies/logout_strategy.dart';
import 'package:d_sdk/user_session/user_session.dart';
import 'package:datarunmobile/app/router/app_router.dart';
import 'package:datarunmobile/app/router/app_router.gr.dart';
import 'package:datarunmobile/core/auth/session_scope_initializer.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthManager)
class SdkAuthManager implements AuthManager {
  SdkAuthManager(
      {required SessionRepository sessionRepository,
      required SessionScopeInitializer scopeInitializer,
      required Dio dio})
      : _sessionRepository = sessionRepository,
        _scopeInitializer = scopeInitializer,
        _dio = dio;

  final Dio _dio;
  final SessionRepository _sessionRepository;
  final SessionScopeInitializer _scopeInitializer;

  @override
  Future<bool> isAuthenticated() async {
    final activeSession = await _sessionRepository.getActiveSession();
    return activeSession != null && activeSession.isAccessTokenValid;
  }

  Future<bool> login(
      {required String username, required String password}) async {
    try {
      // _authStateController.add(const AuthState.authLoading());
      final response = await _dio.post('/api/authenticate', data: {
        'username': username,
        'password': password,
      });

      final session = SessionContext(
        username: username,
        baseUrl: _dio.options.baseUrl,
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
        loginTime: DateTime.now(),
      );
      await _sessionRepository.updateActiveSession(session);

      // setupRefreshFailedErrorLogout();

      // _authStateController.add(AuthState.authenticated(session));
      return true;
    } on DioException catch (e) {
      // if (appLocator.currentScopeName == SessionContext.activeSessionScope) {
      //   await appLocator.popScopesTill(SessionContext.activeSessionScope);
      // }
      // return false;
      // Handle specific error codes
      // _authStateController.add(const AuthState.unauthenticated());
      await _scopeInitializer.popAuthScope();
      throw AuthException(e.message, url: _dio.options.baseUrl);
    }
  }

  @override
  Future<bool> logout(
      {LogoutStrategy strategy = LogoutStrategy.keepLocalData}) async {
    appLocator<AppRouter>().replace(LoginRoute());
    return _scopeInitializer.popAuthScope();
  }

  void setupRefreshFailedErrorLogout() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (error is RevokeTokenException || error is SessionExpiredException) {
          // Centralized session expiration handling
          await logout();

          // appLocator<AppRouter>().replace(LoginRoute());
          // navigatorKey.currentState?.pushReplacement(LoginRoute());
          return handler.reject(error);
        }
        return handler.next(error);
      },
    ));
  }
}
