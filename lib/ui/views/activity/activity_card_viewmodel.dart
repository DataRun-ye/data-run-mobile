// import 'dart:io';
//
// import 'package:d2_remote/d2_remote.dart';
// import 'package:datarunmobile/app/app.router.dart';
// import 'package:datarunmobile/data/activity/activity.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// class ActivityCardViewModel extends BaseViewModel {
//   ActivityCardViewModel(this._activityDetailService, this._navigationService);
//
//   final NavigationService _navigationService;
//   final ActivityDetailService _activityDetailService;
//
//   ActivityDetail activityDetail;
//
//   // Place anything here that needs to happen before we get into the application
//   Future<void> runStartupLogic() async {
//     // await Future.delayed(const Duration(seconds: 3));
//
//     // final authenticated = _userSessionManager.isAuthenticated;
//     // final needSync = _userSessionManager.needsSync();
//
//     if (authenticated) {
//       await D2Remote.initialize(
//           databaseFactory:
//               Platform.isWindows || Platform.isLinux ? databaseFactory : null);
//       if (needSync) {
//         _navigationService.replaceWithSyncScreen();
//       } else {
//         _navigationService.replaceWithHomeScreen();
//       }
//     } else {
//       _navigationService.replaceWithLoginPage();
//     }
//     // final bool hasExistingSession = userSessionManager.isAuthenticated;
//     // final bool needsSync = userSessionManager.needsSync();
//     // This is where you can make decisions on where your app should navigate when
//     // you have custom startup logic
//
//     // _navigationService.replaceWithHomeView();
//   }
// }
