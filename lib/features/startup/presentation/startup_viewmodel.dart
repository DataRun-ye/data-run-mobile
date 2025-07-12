// import 'package:datarunmobile/core/network/connectivy_service.dart';
// import 'package:datarunmobile/core/services/user_session_manager.service.dart';
// import 'package:datarunmobile/app/di/injection.dart';
// import 'package:datarunmobile/app/stacked/app.router.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// class StartupViewModel extends BaseViewModel {
//   final _navigationService = appLocator<NavigationService>();
//   final _userSessionManager = appLocator<UserSessionService>();
//
//   // Place anything here that needs to happen before we get into the application
//   Future<void> runStartupLogic() async {
//     await Future.delayed(const Duration(seconds: 40));
//
//     final authenticated = _userSessionManager.isAuthenticated;
//     final needSync = _userSessionManager.needsSync();
//
//     if (authenticated) {
//       final isOnline = await appLocator<NetworkUtil>().isOnline();
//       if (needSync && isOnline) {
//         // _navigationService.replaceWithSyncProgressView();
//         appLocator<NavigationService>().replaceWithSyncResourcesView();
//       } else {
//         _navigationService.replaceWithHomeWrapperPage();
//       }
//     } else {
//       _navigationService.replaceWithLoginView();
//     }
//     // final bool hasExistingSession = userSessionManager.isAuthenticated;
//     // final bool needsSync = userSessionManager.needsSync();
//     // This is where you can make decisions on where your app should navigate when
//     // you have custom startup logic
//
//     // _navigationService.replaceWithHomeView();
//   }
// }
