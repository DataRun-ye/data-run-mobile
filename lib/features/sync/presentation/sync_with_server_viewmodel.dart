import 'package:datarunmobile/core/sync/model/sync_state.dart';
import 'package:datarunmobile/core/sync/sync_coordinator.dart';
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class SyncProgressViewModel extends StreamViewModel<SyncState> {
  SyncProgressViewModel({this.onResult});

  final SyncCoordinator _coordinator = appLocator<SyncCoordinator>();
  final SyncProgressNotifier _progressNotifier =
      appLocator<SyncProgressNotifier>();

  final Function(bool finished)? onResult;

  SyncState? get state => data;

  // @override
  // void onData(SyncState? data) {
  //   super.onData(data);
  //   // if (data?.status == SyncStatus.complete) {
  //   //   appLocator<AppRouter>().replace(HomeRoute());
  //   // }
  // }

  @override
  Stream<SyncState> get stream => Rx.combineLatest2(
        _progressNotifier.progress,
        _progressNotifier.resourceUpdates,
        (progress, resource) => SyncState(
          status: progress.status,
          percentage: progress.percentage,
          totalResources: progress.totalResources,
          currentResource: resource,
          resourceHistory: _progressNotifier.resourceHistory,
          error: progress.error,
        ),
      );

  Future<void> triggerSync() async {
    try {
      _progressNotifier.reset();
      await _coordinator.handleSyncLifecycle();
    } catch (e) {
      // state = state.copyWith(
      //   status: SyncStatus.failed,
      //   error: e,
      // );
    }
  }

  Future<void> retryOneResource(String resourceName) async {
    try {
      await _coordinator.handleResourceSyncLifecycle(resourceName);
    } catch (e) {
      // state = state.copyWith(
      //   status: SyncStatus.failed,
      //   error: e,
      // );
    }
  }
}
