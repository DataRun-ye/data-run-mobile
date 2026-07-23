import 'dart:async';

import 'package:datarunmobile/core/auth/auth_failure_policy.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/db_factory/database_factory.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:datarunmobile/di/init_active_session_scope.dart';
import 'package:datarunmobile/features/data_instance/application/submission_table_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/token_refresher.dart';
import 'package:datarunmobile/core/auth/token_string_extension.dart';
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart';
import 'package:datarunmobile/core/telemetry/app_telemetry.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

enum AuthStatus {
  unknown, // Initial state, checking authentication
  unauthenticated,
  authenticated,
}

/// A service to manage user authentication and session-specific dependencies.
@lazySingleton
class AuthManager extends ChangeNotifier {
  AuthManager({
    required AuthStorage authStorage,
    required AuthApi authApi,
    required TokenRefresher tokenRefresher,
    required ConnectivityService connectivityService,
    required SessionOperationTracker sessionOperationTracker,
  })  : _authStorage = authStorage,
        _authApi = authApi,
        _tokenRefresher = tokenRefresher,
        _connectivityService = connectivityService,
        _sessionOperationTracker = sessionOperationTracker;

  final AuthStorage _authStorage;
  final TokenRefresher _tokenRefresher;
  final ConnectivityService _connectivityService;
  final SessionOperationTracker _sessionOperationTracker;
  AuthStatus _status = AuthStatus.unknown;
  Future<void>? _sessionEnd;
  Future<void>? _scopeClosure;
  String? _sessionScopeUserId;

  /// The full User object for the active user
  UserSession? _activeUserSession;

  final AuthApi _authApi;

  String get apiBaseUrl => AppEnvironment.apiBaseUrl;

  AuthStatus get status => _status;

  String? get activeUserId => _activeUserSession?.username;

  UserSession? get activeUserSession => _activeUserSession;

  /// Checks for any active session or previously logged in users.
  Future<void> initialize() async {
    _status = AuthStatus.unknown;
    notifyListeners();

    try {
      final userSession = await _loadStartupSession();
      await _restoreSession(userSession);
      try {
        await AppTelemetry.setUser(activeUserSession);
      } catch (error, stackTrace) {
        logError(
          'Failed to restore authenticated telemetry identity',
          source: error,
          stackTrace: stackTrace,
        );
      }
    } catch (error) {
      if (isCredentialRejection(error)) {
        await _beginSessionEnd(navigateToLogin: false);
      } else {
        _status = AuthStatus.unauthenticated;
        _activeUserSession = null;
        await AppTelemetry.setUser(null);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<UserSession> _loadStartupSession() async {
    final userId = _authStorage.getActiveUserId();
    final tokenPair = await _authStorage.getActiveUserToken();
    final userSession = _authStorage.getActiveSession();
    if (tokenPair.accessToken.isAccessTokenValid) {
      return userSession;
    }

    bool isOnline;
    try {
      isOnline = await _connectivityService.isOnline;
    } catch (_) {
      return userSession;
    }
    if (!isOnline) return userSession;

    try {
      await _tokenRefresher.refreshToken(userId);
    } catch (error) {
      if (isCredentialRejection(error)) rethrow;
      if (error is NetworkHttpError) return userSession;
      rethrow;
    }

    return userSession;
  }

  bool isAuthenticated() {
    return _status == AuthStatus.authenticated;
  }

  /// user login.
  /// On successful login, it creates a new GetIt scope for the user session.
  Future<UserSession> login(
      {required String username, required String password}) async {
    _status = AuthStatus.unknown;
    notifyListeners();
    var credentialsPersisted = false;
    var operationTrackingResumed = false;
    String? sessionUserId;

    try {
      final authResponse = await _authApi.login(username, password);
      final userSession =
          await _authApi.getUserProfile(authResponse.accessToken);
      sessionUserId = userSession.username;

      final scopeClosure = _scopeClosure;
      if (scopeClosure != null) {
        await scopeClosure;
      }

      await _authStorage.persistAuthenticatedSession(userSession, (
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken
      ));
      credentialsPersisted = true;

      _sessionEnd = null;
      _sessionOperationTracker.resume();
      operationTrackingResumed = true;
      await _activateUserSession(userSession);

      try {
        await AppTelemetry.setUser(userSession);
      } catch (error, stackTrace) {
        logError(
          'Failed to set authenticated telemetry identity',
          source: error,
          stackTrace: stackTrace,
        );
      }

      return userSession;
    } catch (error, s) {
      logError('Login failed', source: error, stackTrace: s);
      if (operationTrackingResumed) {
        await _sessionOperationTracker.stopAndWaitForIdle();
      }
      if (credentialsPersisted) {
        try {
          await _authStorage.clearActiveUser();
        } catch (cleanupError, cleanupStackTrace) {
          logError(
            'Failed to roll back login credentials',
            source: cleanupError,
            stackTrace: cleanupStackTrace,
          );
        }
      }
      if (sessionUserId != null) {
        try {
          await _closeFailedLoginScope(sessionUserId);
        } catch (cleanupError, cleanupStackTrace) {
          logError(
            'Failed to roll back login scope',
            source: cleanupError,
            stackTrace: cleanupStackTrace,
          );
        }
      }
      _status = AuthStatus.unauthenticated;
      _activeUserSession = null;
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> _closeFailedLoginScope(String userId) async {
    if (appLocator.hasScope(userId)) {
      await appLocator.popScopesTill(userId);
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = false;
    }
    if (_sessionScopeUserId == userId) {
      _sessionScopeUserId = null;
    }
  }

  /// Restores a session from previously stored tokens.
  Future<void> _restoreSession(UserSession userSession) async {
    await _authStorage.getActiveUserToken();
    await _activateUserSession(userSession);
  }

  /// Activates a user session after login or restoration.
  /// This is the core logic for switching between users.
  Future<void> _activateUserSession(UserSession userSession) async {
    WidgetsFlutterBinding.ensureInitialized();
    final sessionUserId = userSession.username;
    final previousScopeUserId = _sessionScopeUserId;
    if (previousScopeUserId != null &&
        appLocator.hasScope(previousScopeUserId)) {
      await appLocator.popScopesTill(previousScopeUserId);
      logDebug('Previous user session scope popped: $previousScopeUserId');
    } else if (appLocator.hasScope(sessionUserId)) {
      await appLocator.popScopesTill(sessionUserId);
      logDebug('Previous user session scope popped: $sessionUserId');
    }

    await appLocator.pushNewScopeAsync(
      scopeName: sessionUserId,
      init: (getIt) async {
        getIt.enableRegisteringMultipleInstancesOfOneType();
        final databaseFactory = appLocator<DatabaseFactory>();
        final executor = await databaseFactory.openForUser(sessionUserId);
        try {
          final database =
              AppDatabase(executor: executor, userId: sessionUserId);
          getIt.registerSingleton<AppDatabase>(
            database,
            dispose: (db) async {
              logDebug('AppDatabase dispose');
              await db.close();
              await databaseFactory.closeForUser(db.userId);
            },
          );
          getIt.registerSingleton<UserSession>(
            userSession,
            instanceName: 'activeUser',
          );
          getIt.registerFactory<SubmissionTableService>(
            () => SubmissionTableService(
              database: database,
              uploadService: SubmissionUploadService(
                database: database,
                apiClient: getIt<HttpClient<dynamic>>(),
                operationTracker: _sessionOperationTracker,
              ),
            ),
          );
        } catch (_) {
          await databaseFactory.closeForUser(sessionUserId);
          rethrow;
        }
      },
    );

    registerUserConfigurationDatasources(appLocator);

    logDebug('New user session scope pushed: ${sessionUserId}');

    _sessionScopeUserId = sessionUserId;
    _activeUserSession = userSession;
    _status = AuthStatus.authenticated;
  }

  /// Logs out the currently active user.
  Future<void> logout() async {
    await _beginSessionEnd();
    await _scopeClosure;
  }

  /// Invalidates a rejected session without blocking the request that detected
  /// it. The user scope closes after active sync/upload cleanup has completed.
  Future<void> expireSession() => _beginSessionEnd();

  Future<void> _beginSessionEnd({bool navigateToLogin = true}) {
    final currentEnd = _sessionEnd;
    if (currentEnd != null) return currentEnd;

    final completion = Completer<void>();
    _sessionEnd = completion.future;
    unawaited(_performSessionEnd(navigateToLogin: navigateToLogin).then(
      (_) => completion.complete(),
      onError: (Object error, StackTrace stackTrace) {
        completion.completeError(error, stackTrace);
      },
    ));
    return completion.future;
  }

  Future<void> _performSessionEnd({required bool navigateToLogin}) async {
    final userId = _sessionScopeUserId ?? _activeUserIdFromStorage();
    final idle = _sessionOperationTracker.stopAndWaitForIdle();

    _status = AuthStatus.unknown;
    notifyListeners();

    _activeUserSession = null;
    _status = AuthStatus.unauthenticated;

    try {
      await _authStorage.clearActiveUser();
    } catch (error, stackTrace) {
      logError(
        'Failed to clear ended session credentials',
        source: error,
        stackTrace: stackTrace,
      );
    }

    try {
      await AppTelemetry.setUser(null);
    } catch (error, stackTrace) {
      logError(
        'Failed to clear ended session telemetry identity',
        source: error,
        stackTrace: stackTrace,
      );
    }

    if (navigateToLogin) {
      try {
        appLocator<NavigationService>().clearStackAndShow(Routes.loginView);
      } catch (error, stackTrace) {
        logError(
          'Failed to show login after session ended',
          source: error,
          stackTrace: stackTrace,
        );
      }
    }
    notifyListeners();

    _scopeClosure = _closeScopeWhenIdle(userId, idle);
    unawaited(_scopeClosure!.catchError((Object error, StackTrace stackTrace) {
      logError(
        'Failed to close ended user scope',
        source: error,
        stackTrace: stackTrace,
      );
    }));
  }

  String? _activeUserIdFromStorage() {
    try {
      return _authStorage.getActiveUserId();
    } catch (_) {
      return null;
    }
  }

  Future<void> _closeScopeWhenIdle(
    String? userId,
    Future<void> idle,
  ) async {
    await idle;
    if (userId == null) return;

    if (appLocator.hasScope(userId)) {
      await appLocator.popScopesTill(userId);
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = false;
      logDebug('Ended user session scope popped: $userId');
    }
    if (_sessionScopeUserId == userId) {
      _sessionScopeUserId = null;
    }
  }
}
