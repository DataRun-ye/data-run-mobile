import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/session_storage_manager.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/use_cases/authentication/auth_scope_initialization.dart';
import 'package:datarunmobile/stacked/app.locator.dart';
import 'package:datarunmobile/stacked/app.router.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  // sdk dependencies
  // final AuthManager _authManager = DSdk.authManager;
  // final AuthScopeInitializer _scopeInitializer = DSdk.authScopeInitializer;
  final UserSessionRepository _userSessionRepository =
      DSdk.userSessionRepository;

  // app dependencies
  final NavigationService _navigationService = appLocator<NavigationService>();
  final SyncScheduler _syncScheduler = appLocator<SyncScheduler>();

  Future<dynamic> runStartupLogic() async {
    try {
      // final authenticated = await _authManager.isAuthenticated();

      // if (authenticated) {
      //   await initAuthUserScope();
      // } else {
      //   return _navigationService.replaceWithLoginPage();
      // }

      final needSync = await _syncScheduler.shouldSync();
      if (needSync) {
        // await _navigationService.navigateToSyncProgressView();
        // _navigationService.replaceWithHomeScreen();
      } else {
        // return _navigationService.replaceWithHomeScreen();
      }
    } on DError catch (e, s) {
      // _navigationService.replaceWithLoginPage();
      logException(e, source: e.cause);
      debugPrintStack(stackTrace: s);
      DExceptionReporter.instance.report(e, showToUser: true);
    } catch (e, s) {
      // _navigationService.replaceWithLoginPage();
      debugPrintStack(stackTrace: s);
      DExceptionReporter.instance.report(e, showToUser: true);
    }
  }

  Future<void> initAuthUserScope() async {
    final cachedUser = await _userSessionRepository.loadCurrentCachedUserData();
    throwIf(
        cachedUser == null,
        NoCachedAuthenticatedUser(
            message: 'no Cached user, login',
            cause: this,
            stackTrace: StackTrace.current));

    // final User? userAuthData =
    //     await DSdk.dbManager.loadAuthUserData(cachedUser!);

    // if (userAuthData != null) {
      // _scopeInitializer.registerAuthUser(
      //     authUser: AuthenticatedUser.fromMap({
      //   ...userAuthData.toJson(),
      //   'baseUrl': AppEnvironment.apiBaseUrl
      // }));
    // } else {
      // await _scopeInitializer.popScope();
      // throw NoCachedAuthenticatedUser(message: '''
      //           cached user has no user data in db,
      //           login and sync properly
      //           ''', cause: this, stackTrace: StackTrace.current);
    // }
  }
}
