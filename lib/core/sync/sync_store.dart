import 'package:datarunmobile/core/sync/model/sync_state.dart';
import 'package:datarunmobile/core/sync/sync_coordinator.dart';
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

class SyncStore extends StreamNotifier<SyncState> {
  SyncStore(this.coordinator, this.progressNotifier);

  final SyncCoordinator coordinator;
  final SyncProgressNotifier progressNotifier;

  @override
  Stream<SyncState> build() {
    return Rx.combineLatest2(
      progressNotifier.progress,
      progressNotifier.resourceUpdates,
      // coordinator.watchLastSync(),
      (progress, resource) => SyncState(
        status: progress.status,
        percentage: progress.percentage,
        totalResources: progress.totalResources,
        currentResource: resource,
        resourceHistory: progressNotifier.resourceHistory,
        // lastSync: lastSync,
        error: progress.error,
      ),
    );
  }
}
