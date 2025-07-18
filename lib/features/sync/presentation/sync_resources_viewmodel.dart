import 'dart:async';

import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/core/sync_manager/sync_manager.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:datarunmobile/core/sync_manager/sync_resource_status.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SyncResourcesViewModel extends StreamViewModel<SyncProgressEvent> {
  final SyncManager _manager = appLocator<SyncManager>();
  final SyncMetadataRepository _metadataRepo =
      appLocator<SyncMetadataRepository>();

  SyncProgressGlobalState? globalState;
  Map<String, SyncResourceStatus> resourceStates = {};

  @override
  void onData(SyncProgressEvent? event) {
    if (event != null) {
      resourceStates.update(
          event.resourceName, (oldValue) => SyncResourceStatus.fromEvent(event),
          ifAbsent: () => SyncResourceStatus.fromEvent(event));

      // Aggregate global progress from resource states.
      globalState = _manager.globalState;

      if (globalState!.completed) {
        unawaited(_metadataRepo.updateInitialSyncDone(true));
        unawaited(_metadataRepo.updateLastSync());
        appLocator<NavigationService>().clearStackAndShow(
          Routes.homeWrapperPage,
        );
        // appLocator<NavigationService>().replaceWithHomeWrapperPage();
      }
    }

    super.onData(data);
  }

  @override
  Stream<SyncProgressEvent> get stream => _manager.progressStream;

  Future<void> triggerSync() async {
    try {
      globalState = SyncProgressGlobalState.initial(
          totalResources: _manager.totalResources);
      await _manager.syncAll();
    } catch (e) {
      // state = state.copyWith(
      //   status: SyncStatus.failed,
      //   error: e,
      // );
    }
  }
}
