import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/core/sync_manager/sync_manager.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:datarunmobile/core/sync_manager/sync_resource_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

final syncResourcesControllerProvider =
    NotifierProvider.autoDispose<SyncResourcesController, SyncResourcesState>(
  SyncResourcesController.new,
);

class SyncResourcesState {
  const SyncResourcesState({
    this.globalState,
    this.resourceStates = const {},
  });

  final SyncProgressGlobalState? globalState;
  final Map<String, SyncResourceStatus> resourceStates;

  SyncResourcesState start({required int totalResources}) {
    return SyncResourcesState(
      globalState:
          SyncProgressGlobalState.initial(totalResources: totalResources),
      resourceStates: resourceStates,
    );
  }

  SyncResourcesState apply(
    SyncProgressEvent event,
    SyncProgressGlobalState globalState,
  ) {
    return SyncResourcesState(
      globalState: globalState,
      resourceStates: Map.unmodifiable({
        ...resourceStates,
        event.resourceName: SyncResourceStatus.fromEvent(event),
      }),
    );
  }
}

class SyncResourcesController extends Notifier<SyncResourcesState> {
  late final SyncManager _manager;
  late final SyncMetadataRepository _metadataRepository;
  late final NavigationService _navigationService;
  StreamSubscription<SyncProgressEvent>? _progressSubscription;
  Timer? _completionNavigation;
  bool _completionHandled = false;

  @override
  SyncResourcesState build() {
    _manager = appLocator<SyncManager>();
    _metadataRepository = appLocator<SyncMetadataRepository>();
    _navigationService = appLocator<NavigationService>();
    _progressSubscription = _manager.progressStream.listen(_onProgress);

    ref.onDispose(() {
      _completionNavigation?.cancel();
      unawaited(_progressSubscription?.cancel());
    });

    return const SyncResourcesState();
  }

  Future<void> triggerSync() async {
    state = state.start(totalResources: _manager.totalResources);
    try {
      await _manager.syncAll();
    } catch (_) {
      // Individual resource failures are reported through the progress stream.
    }
  }

  void leaveSync() {
    _navigationService.clearStackAndShow(Routes.homeWrapperPage);
  }

  void _onProgress(SyncProgressEvent event) {
    final globalState = _manager.globalState;
    state = state.apply(event, globalState);

    if (!globalState.completed ||
        !globalState.overallState.isSuccess ||
        _completionHandled) {
      return;
    }
    _completionHandled = true;

    unawaited(_completeSuccessfulSync());
  }

  Future<void> _completeSuccessfulSync() async {
    await Future.wait([
      _metadataRepository.updateInitialSyncDone(true),
      _metadataRepository.updateLastSync(),
    ]);
    if (!ref.mounted) return;
    _completionNavigation = Timer(const Duration(seconds: 2), () {
      if (ref.mounted) leaveSync();
    });
  }
}
