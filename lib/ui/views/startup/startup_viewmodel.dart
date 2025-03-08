import 'package:datarun/app/app.locator.dart';
import 'package:datarun/app/app.router.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userSessionManager = locator<UserSessionManager>();

  // Place anything here that needs to happen before we get into the application
  void runStartupLogic() {
    // await Future.delayed(const Duration(seconds: 3));

    final authenticated = _userSessionManager.isAuthenticated;
    final needSync = _userSessionManager.needsSync();

    if (authenticated) {
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
