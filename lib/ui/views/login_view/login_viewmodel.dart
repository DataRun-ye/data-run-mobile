// import 'package:datarunmobile/app/app.locator.dart';
// import 'package:datarunmobile/app/app.router.dart';
// import 'package:datarunmobile/core/services/user_session_manager.service.dart';
// import 'package:datarunmobile/data/service/authentication_service.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// class LoginViewModel extends BaseViewModel {
//   String data =
//       'Data which we can assign to ui'; //notify after changing value to reflect in ui
//   final _navigationService = appLocator<NavigationService>();
//   final _authenticationService = appLocator<AuthenticationService>();
//   final _userSessionManager = appLocator<UserSessionService>();
//
//   Future<void> userLogin(String username, String password) async {
//     setBusy(true);
//     final response = await _authenticationService.login(username, password);
//     setBusy(false);
//     final needSync = _userSessionManager.needsSync();
//
//     if (response.success) {
//       if (needSync) {
//         _navigationService.replaceWithSyncScreen();
//       } else {
//         _navigationService.replaceWithHomeScreen();
//       }
//     } else {
//       // Login failed, show error message
//       setError('Invalid username or password');
//     }
//   }
// }
