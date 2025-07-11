import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:d_sdk/use_cases/logout_strategies/logout_strategy.dart';
import 'package:d_sdk/user_session/session_context.dart';
import 'package:d_sdk/user_session/session_context.extension.dart';
import 'package:d_sdk/user_session/session_repository.dart';
import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthManager)
class SdkAuthManager implements AuthManager {
  SdkAuthManager(
      {required SessionRepository sessionRepository,
      required SessionScopeInitializer scopeInitializer,
      required AuthApi authApi})
      : _sessionRepository = sessionRepository,
        _scopeInitializer = scopeInitializer,
        _authApi = authApi;

  final SessionRepository _sessionRepository;
  final SessionScopeInitializer _scopeInitializer;
  final AuthApi _authApi;

  String get apiBaseUrl => AppEnvironment.apiBaseUrl;

  @override
  Future<bool> isAuthenticated() async {
    final activeSession = await _sessionRepository.getActiveSession();
    final isValid = activeSession?.isAccessTokenValid == true;
    return isValid;
  }

  Future<User> login(
      {required String username, required String password}) async {
    try {
      final authResponse = await _authApi.login(username, password);

      final session = SessionContext(
        username: username,
        baseUrl: apiBaseUrl,
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        loginTime: DateTime.now(),
      );
      await _sessionRepository.updateActiveSession(session);
      // Fetch user profile (must succeed)

      final userDetails =
          await _authApi.getUserProfile(authResponse.accessToken);
      // Initialize current user auth scope including db
      await appLocator<SessionScopeInitializer>().initAuthScope();

      // await appLocator<DbManager>().db.managers.users.replace(userDetails);
      final db = appLocator<DbManager>().db;
      await db.into(db.users).insertOnConflictUpdate(userDetails);
      // .insert(userDetails);

      // Navigate to main app screen
      // _router.replace(SyncProgressRoute());

      // setupRefreshFailedErrorLogout();

      // register user details after init db scope
      return await appLocator<SessionScopeInitializer>()
          .registerUserDetailInDbScope();
    } catch (error) {
      // On any failure, clean up and show error
      await _scopeInitializer.popAuthScope();
      await _sessionRepository.clearActiveSession();
      rethrow;
    }
  }

  @override
  Future<bool> clearUserSession(
      {LogoutStrategy strategy = LogoutStrategy.keepLocalData}) async {
    await _scopeInitializer.popAuthScope();
    await _sessionRepository.clearActiveSession();
    return true;
  }

// void setupRefreshFailedErrorLogout() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (error, handler) async {
//       if (error is RevokeTokenException || error is SessionExpiredException) {
//         // Centralized session expiration handling
//         await logoutSession();
//
//         // appLocator<AppRouter>().replace(LoginRoute());
//         // navigatorKey.currentState?.pushReplacement(LoginRoute());
//         return handler.reject(error);
//       }
//       return handler.next(error);
//     },
//   ));
// }
}
