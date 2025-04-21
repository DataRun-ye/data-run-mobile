// import 'package:auto_route/auto_route.dart';
// import 'package:d_sdk/di/injection.config.dart';
// import 'package:d_sdk/user_session/user_session.dart';
// import 'package:datarunmobile/app/router/router.dart';
// import 'package:datarunmobile/core/sync/sync_scheduler.dart';
// import 'package:datarunmobile/di/injection.dart';
//
// class SyncingGuard extends AutoRouteGuard {
//   SyncingGuard(this._syncScheduler);
//
//   final SyncScheduler _syncScheduler;
//
//   @override
//   Future<void> onNavigation(
//       NavigationResolver resolver, StackRouter router) async {
//     final shouldSync = await _syncScheduler.shouldSync();
//     if (appLocator.currentScopeName != SessionContext.activeSessionScope) {
//       await initActiveSessionScope(appLocator);
//     }
//
//     if (shouldSync) {
//       resolver.redirectUntil(SyncProgressRoute(onResult: (didFinish) {
//         if (didFinish) {
//           /// stop re-pushing any pending routes after current
//           resolver.resolveNext(didFinish);
//         }
//       }));
//     } else {
//       resolver.next();
//     }
//   }
// }
