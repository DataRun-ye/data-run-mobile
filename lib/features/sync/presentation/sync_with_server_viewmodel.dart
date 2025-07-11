import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/core/sync/model/sync_state.dart';
import 'package:datarunmobile/core/sync/sync_coordinator.dart';
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SyncProgressViewModel extends StreamViewModel<SyncState> {
  SyncProgressViewModel({this.onResult});

  final SyncCoordinator _coordinator = appLocator<SyncCoordinator>();
  final SyncProgressNotifier _progressNotifier =
      appLocator<SyncProgressNotifier>();
  final NavigationService _navigationService = appLocator<NavigationService>();
  final Function(bool finished)? onResult;

  SyncState? get state => data;

  // @override
  // void onData(SyncState? data) {
  //   super.onData(data);
  //   // if (data?.status == SyncStatus.complete) {
  //   //   appLocator<AppRouter>().replace(HomeRoute());
  //   // }
  // }
  Future<void> navigateToHomeScreen() async {
    _navigationService.replaceWithHomeWrapperPage();
    final langKey = appLocator<User>().langKey ?? 'ar';
    // await _navigationService.replaceWithHomeScreen();
  }

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
