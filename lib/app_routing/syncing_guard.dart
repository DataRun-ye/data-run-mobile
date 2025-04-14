// import 'package:auto_route/auto_route.dart';
// import 'package:datarunmobile/app_routing/app_routing.dart';
// import 'package:datarunmobile/core/sync/sync_scheduler.dart';
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
//     if (shouldSync) {
//       // If syncing is needed, redirect to a sync progress route.
//       resolver.redirect(const SyncProgressRoute());
//     } else {
//       resolver.next();
//     }
//   }
// }
