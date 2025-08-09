import 'package:d_sdk/core/sync/model/sync_progress_event.dart';

typedef ProgressCallback = void Function(SyncProgressEvent event);

class SyncLogger {
  final ProgressCallback? progressCallback;
  SyncProgressEvent _syncProgressEvent;
  final String resourceName;

  SyncLogger(
      {this.progressCallback,
      required this.resourceName,
      SyncProgressEvent? syncProgressEvent})
      : _syncProgressEvent = SyncProgressEvent(
            resourceName: resourceName,
            syncProgressState: SyncProgressState.ENQUEUED,
            message: 'Started',
            percentage: 0);

  call(
      {SyncProgressState syncProgressState = SyncProgressState.RUNNING,
      String? message,
      double? percentage,
      bool? completed,
      int? resources}) {
    _syncProgressEvent = _syncProgressEvent.copyWith(
        syncProgressState: syncProgressState,
        message: message,
        percentage: percentage,
        resources: resources,
        completed: completed ?? syncProgressState.isFinished());
    progressCallback?.call(_syncProgressEvent);
    // logDebug('sync progress', data: _syncProgressEvent.toMap());
  }
}
