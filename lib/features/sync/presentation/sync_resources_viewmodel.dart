import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/auth/sync_interactor.dart';
import 'package:datarunmobile/core/sync_manager/sync_manager.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_event.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:datarunmobile/core/sync_manager/sync_resource_status.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SyncResourcesViewModel extends StreamViewModel<SyncProgressEvent> {
  final SyncManager _manager = appLocator<SyncManager>();

  SyncProgressGlobalState globalState = SyncProgressGlobalState.initial();
  List<SyncResourceStatus> resourceStates = [];

  @override
  void onData(SyncProgressEvent? event) {
    if (event != null) {
      final index =
          resourceStates.indexWhere((r) => r.name == event.resourceName);
      if (index >= 0) {
        resourceStates[index] = SyncResourceStatus.fromEvent(event);
      } else {
        resourceStates.add(SyncResourceStatus.fromEvent(event));
      }
      // Aggregate global progress from resource states.
      globalState = SyncProgressGlobalState.aggregate(
          resourceStates, event.percentage, event.message);
      if (event.percentage == 100) {
        appLocator<SyncInteractor>().markSyncDone();
        appLocator<NavigationService>().replaceWithHomeWrapperPage();
      }
    }

    super.onData(data);
  }

  @override
  Stream<SyncProgressEvent> get stream => _manager.progressStream;

  Future<void> triggerSync() async {
    try {
      await _manager.syncAll();
    } catch (e) {
      // state = state.copyWith(
      //   status: SyncStatus.failed,
      //   error: e,
      // );
    }
  }
}
