import 'dart:async';

import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:d_sdk/user_session/session_context.dart';
import 'package:d_sdk/user_session/session_context.extension.dart';
import 'package:d_sdk/user_session/session_repository.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/user_session/locale_service.dart';
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// A service to manage user authentication and session-specific dependencies.
@LazySingleton(as: AuthManager)
class SdkAuthManager extends AuthManager {
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

  User? _currentUser;
  SessionContext? _currentUserSession;
  AuthStatus _status = AuthStatus.unknown;

  AuthStatus get status => _status;

  User? get currentUser => _currentUser;

  String get apiBaseUrl => AppEnvironment.apiBaseUrl;

  /// Checks for an existing authentication token on app startup.
  /// If a token is found, it restores the user session.
  @override
  Future<void> checkAuthStatus() async {
    _status = AuthStatus.unknown;
    notifyListeners();
    try {
      logDebug('checking auth state from session');
      _currentUserSession = await _sessionRepository.getActiveSession();
      final isValid = _currentUserSession?.isAccessTokenValid == true;

      logDebug('auth state valid:$isValid');
      if (isValid) {
        // Initialize current user auth scope including db
        _createSessionScope(_currentUserSession!);
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e, s) {
      // On any failure, clean up and show error
      logError('Error checking auth status', source: e, stackTrace: s);
      _status = AuthStatus.unauthenticated;
      await _popAuthScope();
      // await _sessionRepository.clearActiveSession();
    } finally {
      notifyListeners();
    }
  }

  @override
  bool isAuthenticated() {
    return _status == AuthStatus.authenticated;
  }

  /// user login.
  /// On successful login, it creates a new GetIt scope for the user session.
  Future<User> login(
      {required String username, required String password}) async {
    // _status = AuthStatus.unknown; // Set to unknown during login process
    // notifyListeners();
    try {
      final authResponse = await _authApi.login(username, password);

      _currentUserSession = SessionContext(
        username: username,
        baseUrl: apiBaseUrl,
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        loginTime: DateTime.now(),
      );

      // Fetch user profile (must succeed)
      _currentUser = await _authApi.getUserProfile(authResponse.accessToken);

      // cache session (necessary for db initialization)
      await _sessionRepository.updateActiveSession(_currentUserSession!);

      _status = AuthStatus.authenticated;

      // Initialize current user auth scope including db
      await _createSessionScope(_currentUserSession!);

      // setupRefreshFailedErrorLogout();

      return _currentUser!;
    } catch (error, s) {
      logError('Login failed', source: error, stackTrace: s);
      _status = AuthStatus.unauthenticated;
      // await _sessionRepository.clearActiveSession();
      await _popAuthScope();
      rethrow; // Re-throw to be caught by UI for error display
    } finally {
      notifyListeners();
    }
  }

  // @override
  // Future<bool> clearUserSession(
  //     {LogoutStrategy strategy = LogoutStrategy.keepLocalData}) async {
  //   await _sessionRepository.clearActiveSession();
  //   await _popAuthScope();
  //   return true;
  // }

  /// user logout.
  /// It disposes of the user session scope and clears authentication data.
  Future<void> logout() async {
    _status = AuthStatus.unknown; // Set to unknown during logout process
    notifyListeners();

    try {
      // Clear the authentication token from secure storage
      await _sessionRepository.clearActiveSession();

      // Pop the 'userSession' scope. This will automatically dispose
      // all dependencies registered within that scope (LocaleService, ServerUrlService, etc.).
      await _popAuthScope();

      _currentUser = null;
      _currentUserSession = null;
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      debugPrint('Logout failed: $e');
      // Even if logout fails, we try to clear local state for security
      _currentUser = null;
      _currentUserSession = null;
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  /// Creates a new GetIt scope for the authenticated user session.
  /// All user-specific dependencies are registered within this scope.
  Future<void> _createSessionScope(SessionContext session) async {
    // Push a new scope named 'userSession'. This scope will hold
    // dependencies specific to the current authenticated user.
    // getIt.pushScope(scopeName: 'userSession');
    // Initialize current user auth scope including db
    // pushScope(scopeName: 'userSession');
    await appLocator<SessionScopeInitializer>().initAuthScope();

    final db = await appLocator<DbManager>();
    // save , not null when user first logs in and api returned
    // user is registered in scope,
    // but in higher or this scope, popping should
    // ensure de-registering the user?
    if (_currentUser != null) {
      // save to db (this a first login and fetch initialization)
      await db.saveAuthUserData(_currentUser!);
    } else {
      // load from db (this a valid session initialization)
      _currentUser = await db.loadAuthUserData();
    }

    // no user in db throw to trigger login flow (which will
    // set fetched to _current
    if (_currentUser == null) {
      logDebug('No Authenticated user in db');
      throw NoCachedAuthenticatedUser();
    }

    // Register the current User object within this scope.
    // This allows any service within this scope to easily access the user's data.
    appLocator.registerSingleton<User>(_currentUser!);

    // at this point all registrations that follow
    // are related to an authenticated user.
    //
    // Register LocaleService within the session scope,
    // initialized with user's preferred locale.
    appLocator.registerLazySingleton<LocaleService>(
      () => LocaleService(Locale(_currentUser!.langKey ?? 'en', 'en_US')),
    );

    // // Register ServerUrlService within the session scope, initialized with user's preferred server URL.
    // getIt.registerLazySingleton<ServerUrlService>(
    //   () => ServerUrlService(user.preferredServerUrl),
    // );

    // You can register other user-specific services here, e.g.:
    // getIt.registerLazySingleton<UserSpecificApiClient>(
    //   () => UserSpecificApiClient(getIt<ServerUrlService>().currentUrl, user.authToken),
    // );
  }

  Future<bool> _popAuthScope() async {
    WidgetsFlutterBinding.ensureInitialized();
    final activeSession =
        (await _sessionRepository.getActiveSession())?.username;
    final popped =
        await appLocator.popScopesTill(SessionContext.activeSessionScope);
    logDebug('User session scope popped: ${activeSession}', source: this);
    return popped;
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
