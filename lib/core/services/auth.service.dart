import 'dart:io';

import 'package:d2_remote/core/datarun/exception/exception.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/app/app.router.dart';
import 'package:datarunmobile/commons/constants.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/core/network/connectivy_service.dart';
import 'package:datarunmobile/core/services/user_session_manager.service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class AuthService {
  AuthService(this._sessionManager, this._navigationService);

  final UserSessionService _sessionManager;
  final NavigationService _navigationService;

  Future<bool> isAuthenticatedOnline() async {
    WidgetsFlutterBinding.ensureInitialized();
    final networkAvailable =
        await ConnectivityService.instance.isNetworkAvailable();
    // final isOnline = await ConnectivityService.instance.isOnline;

    if (!networkAvailable /* || !isOnline*/) {
      return await _attemptNetworkAuthentication();
    } else {
      DatabaseFactory? databaseFactory;
      if (Platform.isWindows) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      /// Allow offline access with valid session
      return D2Remote.isAuthenticated(databaseFactory: databaseFactory);
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
            'No Active Session, user should not be logged in, logging-user-out');
        await logout();

        throw AccountException(
            'No Active Session Data, user should not be logged in',
            errorCode: DErrorCode.noAuthenticatedUser);
      }

      DatabaseFactory? databaseFactory;
      if (Platform.isWindows) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      final result = await D2Remote.authenticate(
          databaseFactory: databaseFactory,
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
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    AuthenticationResult result = const AuthenticationResult(
      success: false,
      sessionUser: null,
    );
    try {
      await throwIfFirstTimeAndNoActiveNetwork();

      final authResult = await D2Remote.authenticate(
          username: username,
          password: password,
          databaseFactory:
              Platform.isWindows || Platform.isLinux ? databaseFactory : null,
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
    await D2Remote.logOut(sharedPreferenceInstance: locator<SharedPreferences>());
    await _sessionManager.clearAllPreferences();
    _navigationService.clearStackAndShow(Routes.loginPage);
    // Navigator.pushAndRemoveUntil(
    //     navigatorKey.currentContext!,
    //     MaterialPageRoute(builder: (context) => LoginPage()),
    //     (Route<dynamic> route) => false);
  }

  Future<void> throwIfFirstTimeAndNoActiveNetwork() async {
    final networkAvailable =
        await ConnectivityService.instance.isNetworkAvailable();
    if (_sessionManager.isFirstSession && !networkAvailable) {
      logDebug('First time login user needs an active network');
      throw DError(
          errorCode: DErrorCode.noAuthenticatedUser,
          errorComponent: DErrorComponent.SDK,
          message: 'First time login user needs an active network');
    }
  }
}
