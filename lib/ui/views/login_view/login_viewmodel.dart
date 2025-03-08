import 'package:datarun/app/app.locator.dart';
import 'package:datarun/app/app.router.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  String data =
      'Data which we can assign to ui'; //notify after changing value to reflect in ui
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _userSessionManager = locator<UserSessionManager>();

  Future<void> userLogin(String username, String password) async {
    setBusy(true);
    final response = await _authenticationService.login(username, password);
    setBusy(false);
    final needSync = _userSessionManager.needsSync();

    if (response.success) {
      if (needSync) {
        _navigationService.replaceWithSyncScreen();
      } else {
        _navigationService.replaceWithHomeScreen();
      }
    } else {
      // Login failed, show error message
      setError('Invalid username or password');
    }
  }
}
