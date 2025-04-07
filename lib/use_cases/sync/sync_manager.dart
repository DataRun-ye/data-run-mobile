// import 'dart:async';
//
// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
// import 'package:d_sdk/datasource/base_datasource.dart';
// import 'package:injectable/injectable.dart';
//
// @lazySingleton
// class SyncManager {
//   SyncManager({required this.remoteDataSources});
//
//   final Iterable<BaseDataSource> remoteDataSources;
//
//   /// A stream controller for progress events.
//   final StreamController<SyncProgressEvent> _progressController =
//       StreamController.broadcast();
//
//   /// Expose the progress stream so the UI can subscribe.
//   Stream<SyncProgressEvent> get progressStream => _progressController.stream;
//
//   Future<void> syncAll() async {
//     final totalResources = remoteDataSources.length;
//     int resourceIndex = 0;
//
//     _progressController.add(SyncProgressEvent(
//       resourceName: '$totalResources resources',
//       syncProgressState: SyncProgressState.ENQUEUED,
//       message: 'Start download...',
//       percentage: 0,
//     ));
//
//     for (var remoteDataSource in remoteDataSources) {
//       resourceIndex++;
//
//       // Calculate the base percentage completed before this resource.
//       final basePercentage = ((resourceIndex - 1) / totalResources) * 100;
//
//       _progressController.add(SyncProgressEvent(
//         resourceName: remoteDataSource.apiResourceName,
//         syncProgressState: SyncProgressState.RUNNING,
//         message: 'syncing ${remoteDataSource.apiResourceName}...',
//         percentage: basePercentage,
//         completed: false,
//       ));
//
//       try {
//         final onlineData = await remoteDataSource.syncWithRemote(
//           progressCallback: (resourceProgress) {
//             // Compute overall progress: add a fraction of this resource's progress.
//             final overallProgress = basePercentage +
//                 (resourceProgress / 100) * (100 / totalResources);
//             _progressController.add(SyncProgressEvent(
//               resourceName: remoteDataSource.apiResourceName,
//               syncProgressState: SyncProgressState.SUCCEEDED,
//               message: '✔',
//               percentage: overallProgress,
//               completed: false,
//             ));
//           },
//         );
//
//         final overallProgress = (resourceIndex / totalResources) * 100;
//         _progressController.add(SyncProgressEvent(
//           resourceName: remoteDataSource.apiResourceName,
//           syncProgressState: SyncProgressState.ENQUEUED,
//           message: '${onlineData.length} records downloaded',
//           percentage: overallProgress,
//           completed: true,
//         ));
//       } catch (e) {
//         final overallProgress = (resourceIndex / totalResources) * 100;
//         _progressController.add(SyncProgressEvent(
//           resourceName: remoteDataSource.apiResourceName,
//           syncProgressState: SyncProgressState.FAILED,
//           message: '❌ Sync error: $e',
//           percentage: overallProgress,
//           completed: false,
//         ));
//         logError('Error syncing ${remoteDataSource.apiResourceName}: $e');
//       }
//     }
//   }
//
//   @disposeMethod
//   void dispose() {
//     _progressController.close();
//   }
// }
