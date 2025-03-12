import 'dart:io';

import 'package:d2_remote/d2_remote.dart';
import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/app/app.router.dart';
import 'package:datarunmobile/core/auth/user_session_manager.service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userSessionManager = locator<UserSessionService>();

  // Place anything here that needs to happen before we get into the application
  Future<void> runStartupLogic() async {
    // await Future.delayed(const Duration(seconds: 3));

    final authenticated = _userSessionManager.isAuthenticated;
    final needSync = _userSessionManager.needsSync();

    if (authenticated) {
      await D2Remote.initialize(
          databaseFactory:
              Platform.isWindows || Platform.isLinux ? databaseFactory : null);

      if (needSync) {
        _navigationService.replaceWithSyncScreen();
      } else {
        _navigationService.replaceWithHomeScreen();
      }
    } else {
      _navigationService.replaceWithLoginPage();
    }
    // final bool hasExistingSession = userSessionManager.isAuthenticated;
    // final bool needsSync = userSessionManager.needsSync();
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    // _navigationService.replaceWithHomeView();
  }
}
