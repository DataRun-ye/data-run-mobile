// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:d_sdk/core/sync/d2_progress.dart';
// import 'package:d_sdk/di/injection.dart';
// import 'package:d_sdk/use_cases/sync/sync_manager.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// part 'sync_service.provider.g.dart';
//
// // typedef OnProgressUpdate = Function(D2Progress? progress);
//
// typedef ProgressCallback = void Function(String? message);
//
// enum SyncInterval {
//   daily(24 * 60 * 60 * 1000, '1 Day'),
//   everyTwoDays(2 * 24 * 60 * 60 * 1000, '2 Days'),
//   weekly(7 * 24 * 60 * 60 * 1000, '1 Week'),
//   biweekly(15 * 24 * 60 * 60 * 1000, '15 Days'),
//   monthly(30 * 24 * 60 * 60 * 1000, '1 Month');
//
//   const SyncInterval(this.milliseconds, this.label);
//
//   final int milliseconds;
//   final String label;
//
//   String get localLabel => switch (this) {
//         SyncInterval.daily => S.current.daily,
//         SyncInterval.everyTwoDays => S.current.everyTwoDays,
//         SyncInterval.weekly => S.current.weekly,
//         SyncInterval.biweekly => S.current.everyFifteenDays,
//         SyncInterval.monthly => S.current.monthly,
//       };
// }
//
// @riverpod
// class SyncService extends _$SyncService {
//   static const String LAST_SYNC_TIME = 'last_sync_time';
//   static const String SYNC_INTERVAL = 'sync_interval';
//   static const String SYNC_DONE = 'sync_done';
//
//   @override
//   FutureOr<void> build() async {
//     // final syncManager = rSdkappLocator<SyncManager>();
//     // final progressStream = syncManager.progressStream;
// // Initialize
// // return needsSync();
//   }
//
//   Future<void> performSync(
//       {ProgressEventCallback? onProgressUpdate,
//       ProgressCallback? onFinish,
//       ProgressCallback? onFailure}) async {
//     SyncManager syncManager = rSdkappLocator<SyncManager>();
//     try {
//       await syncManager(
//         progressCallback: onProgressUpdate,
//       );
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setInt(LAST_SYNC_TIME, DateTime.now().millisecondsSinceEpoch);
//       await prefs.setBool(SYNC_DONE, true);
//
//       onFinish?.call('All Synced');
//     } catch (error) {
//       onFailure?.call(error.toString().substring(0, 255));
//
//       logDebug('Sync complete with error: $error');
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setInt(LAST_SYNC_TIME, DateTime.now().millisecondsSinceEpoch);
//       await prefs.setBool(SYNC_DONE, false);
//       return;
//     }
//   }
// }
