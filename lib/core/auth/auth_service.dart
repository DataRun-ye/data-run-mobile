import 'package:d2_remote/core/datarun/exception/exception.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarun/commons/constants.dart';
import 'package:datarun/commons/errors_management/d_exception_reporter.dart';
import 'package:datarun/commons/logging/logging.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/core/network/connectivy_service.dart';
import 'package:datarun/data_run/screens/login_screen/login_page.dart';
import 'package:datarun/utils/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  throw UnimplementedError('authenticationServiceProvider is not implemented');
}

class AuthService {
  final UserSessionManager _sessionManager;

  AuthService(this._sessionManager);

  Future<bool> isAuthenticatedOnline() async {
    WidgetsFlutterBinding.ensureInitialized();
    final networkAvailable =
        await ConnectivityService.instance.isNetworkAvailable();
    final isOnline = await ConnectivityService.instance.isOnline;

    if (!networkAvailable || !isOnline) {
      return await _attemptNetworkAuthentication();
    } else {
      /// Allow offline access with valid session
      return D2Remote.isAuthenticated();
    }
  }

  /// used only when user is already logged in to just authenticate and
  /// check with the server and renew session in case of password change
  /// or not active session it will log the user out;
  Future<bool> _attemptNetworkAuthentication() async {
    try {
      final sessionData = _sessionManager.sessionData;

      // this method should only be called after
      // user session was available.
      // for no reason if no active session found in cached preference,
      // log the user out
      if (sessionData == null) {
        logDebug(
            info:
                'No Active Session, user should not be logged in, logging-user-out');
        await logout();

        throw AccountException(
            'No Active Session Data, user should not be logged in',
            errorCode: DErrorCode.noAuthenticatedUser);
      }

      final result = await D2Remote.authenticate(
          username: sessionData.username!,
          password: sessionData.password!,
          url: sessionData.serverUrl!);

      if (result.success) {
        await _sessionManager.saveUserCredentials(
            serverUrl: result.sessionUser!.baseUrl,
            username: result.sessionUser!.username!,
            pass: result.sessionUser!.password!);
      }
      return true;
    } on AuthenticationException catch (e) {
      // in case of password change, rethrow the
      // error, but first log the user out.
      if (e.errorCode == DErrorCode.authInvalidCredentials) {
        await logout();
        rethrow;
      }

      // other exception such as slow line timeout, or server not responding
      // user will stay logged in until another check
      return true;
    }
  }

  Future<AuthenticationResult> login(String username, String password,
      [String? serverUrl]) async {
    WidgetsFlutterBinding.ensureInitialized();
    AuthenticationResult result = AuthenticationResult(
      success: false,
      sessionUser: null,
    );
    try {
      await throwIfFirstTimeAndNoActiveNetwork();
      final authResult = await D2Remote.authenticate(
          username: username,
          password: password,
          url: serverUrl ?? kApiBaseUrl);

      if (authResult.success) {
        await _sessionManager.saveUserCredentials(
            serverUrl: authResult.sessionUser!.baseUrl,
            username: authResult.sessionUser!.username!,
            pass: authResult.sessionUser!.password!);

        // return successful result
        return result.copyWith(
            success: true, sessionUser: authResult.sessionUser);
      }
      // return unsuccessful result
      // won't reach this case , authenticate would through
      // an exception in most cases including invalid credentials.
    } catch (e) {
      DExceptionReporter.instance.report(e);
      rethrow;
    }
    return result;
  }

  Future<void> logout() async {
    await D2Remote.logOut();
    await _sessionManager.clearAllPreferences();
    Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  Future<void> throwIfFirstTimeAndNoActiveNetwork() async {
    final networkAvailable =
        await ConnectivityService.instance.isNetworkAvailable();
    if (_sessionManager.isFirstSession && !networkAvailable) {
      logDebug(info: 'First time login user needs an active network');
      throw DError(
          errorCode: DErrorCode.noAuthenticatedUser,
          errorComponent: DErrorComponent.SDK,
          message: 'First time login user needs an active network');
    }
  }
}
