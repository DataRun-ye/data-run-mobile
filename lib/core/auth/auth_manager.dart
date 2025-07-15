import 'dart:async';

import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dbManager.dart';
import 'package:d_sdk/database/db_factory/database_factory.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:d_sdk/di/init_active_session_scope.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/session_notifier.dart';
import 'package:datarunmobile/core/database/user_db_session.dart';
import 'package:datarunmobile/core/user_session/locale_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

enum AuthStatus {
  unknown, // Initial state, checking authentication
  unauthenticated, // User is not logged in
  authenticated, // User is logged in
}

/// A service to manage user authentication and session-specific dependencies.
@lazySingleton
class AuthManager extends ChangeNotifier {
  AuthManager({required AuthStorage authStorage, required AuthApi authApi})
      : _authStorage = authStorage,
        _authApi = authApi;

  final AuthStorage _authStorage;
  AuthStatus _status = AuthStatus.unknown;

  UserDbSession? _activeUserDbSession;

  /// The full User object for the active user
  UserSession? _activeUserSession;

  final AuthApi _authApi;

  String get apiBaseUrl => AppEnvironment.apiBaseUrl;

  AuthStatus get status => _status;

  String? get activeUserId => _activeUserDbSession?.userId;

  UserSession? get activeUserSession => _activeUserSession;

  UserDbSession? get activeUserDbSession => _activeUserDbSession;

  /// Checks for any active session or previously logged in users.
  Future<void> initialize() async {
    _status = AuthStatus.unknown;
    notifyListeners();

    try {
      final userSession = _authStorage.getActiveSession();
      await _restoreSession(userSession);
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _activeUserSession = null;
      _activeUserDbSession = null;
    } finally {
      notifyListeners();
    }
  }

  bool isAuthenticated() {
    return _status == AuthStatus.authenticated;
  }

  /// user login.
  /// On successful login, it creates a new GetIt scope for the user session.
  Future<UserSession> login(
      {required String username, required String password}) async {
    // Set to unknown during login process
    _status = AuthStatus.unknown;
    notifyListeners();
    try {
      // user token
      final authResponse = await _authApi.login(username, password);

      // Fetch user profile (must succeed)
      final userSession =
          await _authApi.getUserProfile(authResponse.accessToken);

      await _activateUserSession(userSession);

      await _authStorage.setActiveSession(userSession);
      await _authStorage.setActiveCredentials(userSession.username, (
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken
      ));

      return userSession;
    } catch (error, s) {
      logError('Login failed', source: error, stackTrace: s);
      _status = AuthStatus.unauthenticated;
      _activeUserSession = null;
      _activeUserDbSession = null;
      rethrow; // Re-throw to be caught by UI for error display
    } finally {
      notifyListeners();
    }
  }

  /// Restores a session from previously stored tokens.
  Future<void> _restoreSession(UserSession userSession) async {
    final tokens = await _authStorage.getActiveUserToken();
    await _activateUserSession(userSession);
  }

  /// Activates a user session after login or restoration.
  /// This is the core logic for switching between users.
  Future<void> _activateUserSession(UserSession userSession) async {
    WidgetsFlutterBinding.ensureInitialized();
    final sessionUserId = userSession.username;
    // Deactivate current session if any
    if (appLocator.hasScope(sessionUserId)) {
      // await appLocator<DatabaseFactory>().closeForUser(sessionUserId!);
      // await appLocator.resetScope();
      await appLocator.popScopesTill(sessionUserId);
      logDebug('Previous user session scope popped: $sessionUserId');
    }

    _activeUserDbSession = await initializeApp();
    _activeUserSession = userSession;
    _status = AuthStatus.authenticated;
    // Push new scope for the active user
    // appLocator.pushNewScope(scopeName: sessionUserId);
    // driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    // appLocator.registerSingleton<UserSession>(userSession,
    //     instanceName: 'activeUser');
    // registerUserDatabase(sessionUserId);
    await appLocator.pushNewScopeAsync(
      scopeName: sessionUserId,
      init: (getIt) async {
        getIt.enableRegisteringMultipleInstancesOfOneType();
        final executor =
            await appLocator<DatabaseFactory>().openForUser(sessionUserId);
        appLocator.registerSingleton<UserSession>(userSession,
            instanceName: 'activeUser');

        getIt.registerLazySingleton<AppDatabase>(
            () => AppDatabase(executor: executor, userId: sessionUserId),
            dispose: (db) async {
          logDebug('AppDatabase dispose');
          await appLocator<DatabaseFactory>().closeForUser(db.userId);
        });
        getIt.registerLazySingleton(() => DbManager(db: getIt<AppDatabase>()));
      },
    );

    await registerUserSdkDeps(appLocator);

    logDebug('New user session scope pushed: ${sessionUserId}');

    // Register user-specific dependencies in the new scope
    appLocator.registerLazySingleton<LocaleService>(
      () => LocaleService(Locale(userSession.langKey ?? 'en', 'en_US')),
    );
  }

  /// Logs out the currently active user.
  Future<void> logout() async {
    if (_activeUserSession == null) return;

    final userIdToLogout = _activeUserSession!.username;
    _status = AuthStatus.unknown; // Indicate a transition state
    notifyListeners();

    try {
      _activeUserSession = null;
      _activeUserDbSession = null;
      _status = AuthStatus.unauthenticated;
      await _authStorage.clearActiveUser();

      // Pop the current user's scope. This disposes all user-specific services.
      if (appLocator.hasScope(userIdToLogout)) {
        await appLocator.popScopesTill(userIdToLogout);
        driftRuntimeOptions.dontWarnAboutMultipleDatabases = false;
        logDebug('User session scope popped: $userIdToLogout');
      }

      appLocator<NavigationService>().clearStackAndShow(
        Routes.loginView,
      );
      logDebug('User session deleted: $userIdToLogout');
    } catch (e) {
      debugPrint('Logout failed: $e');
      _activeUserDbSession = null;
      _activeUserSession = null;
      _status = AuthStatus.unauthenticated;
      await _authStorage.clearActiveUser();
    } finally {
      notifyListeners();
    }
  }

// void registerUserDatabase(String userId) {
//   // Ensure you're inside the user's scope when this is called.
//   // This makes sure a fresh connection is made for each user/session.
//   if (appLocator.isRegistered<AppDatabase>()) {
//     // This case should ideally not happen if scopes are managed correctly,
//     // but is a safeguard. You should usually pop the scope first.
//     appLocator.unregister<AppDatabase>(); // Unregister previous if any
//   }
//
//   appLocator.registerSingleton<AppDatabase>( // Often singleton within its scope
//       AppDatabase(executor: Platform.createDatabaseConnection(userId), userId: userId),
//       dispose: (db) async {
//         await db.close(); // Close the DB when scope is popped
//         logDebug('AppDatabase for user $userId closed and disposed.');
//       }
//   );
//
//   // appLocator.registerFactory<AppDatabase>(
//   //       () => AppDatabase(executor: Platform.createDatabaseConnection(userId), userId: userId),
//   //   // Dispose function for the database when its scope is popped
//   //   // dispose: (db) async {
//   //   //   await db.close(); // Crucial: Closes the underlying QueryExecutor
//   //   //   print('AppDatabase for user $userId closed and disposed.');
//   //   // },
//   // );
// }
  /// Allows switching the active user from a list of previously logged-in users.
// Future<void> switchUser(UserSession userSession) async {
//   if (_activeUserId == userSession) return; // Already active
//   if (await _tokenStorage.getTokens(userSession.username) ==
//       {'accessToken': null, 'refreshToken': null}) {
//     debugPrint('Cannot switch to user $userSession: no tokens found.');
//     return;
//   }
//
//   _status = AuthStatus.unknown;
//   notifyListeners();
//
//   try {
//     await _restoreSession(
//         userSession); // Restore and activate the new user's session
//   } catch (e) {
//     debugPrint('Failed to switch user to $userSession: $e');
//     // Fallback to unauthenticated or previous user state if switch fails
//     _status = AuthStatus.unauthenticated;
//   } finally {
//     notifyListeners();
//   }
// }
}
