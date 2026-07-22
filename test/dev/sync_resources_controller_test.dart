import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:datarunmobile/features/sync/application/sync_resources.controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('projects the latest status for each synchronized resource', () {
    const projectsRunning = SyncProgressEvent(
      resourceName: 'projects',
      syncProgressState: SyncProgressState.RUNNING,
      message: 'fetching',
      percentage: 20,
    );
    const projectsDone = SyncProgressEvent(
      resourceName: 'projects',
      syncProgressState: SyncProgressState.SUCCEEDED,
      message: 'saved',
      percentage: 100,
      completed: true,
      resources: 4,
    );
    const activitiesDone = SyncProgressEvent(
      resourceName: 'activities',
      syncProgressState: SyncProgressState.SUCCEEDED,
      message: 'saved',
      percentage: 100,
      completed: true,
      resources: 2,
    );
    final global = SyncProgressGlobalState.initial(totalResources: 2);

    final state = const SyncResourcesState()
        .apply(projectsRunning, global)
        .apply(projectsDone, global)
        .apply(activitiesDone, global);

    expect(state.resourceStates, hasLength(2));
    expect(
      state.resourceStates['projects']?.state,
      SyncProgressState.SUCCEEDED,
    );
    expect(state.resourceStates['projects']?.syncedResources, 4);
    expect(state.resourceStates['activities']?.syncedResources, 2);
    expect(
      () => state.resourceStates['other'] = state.resourceStates['projects']!,
      throwsUnsupportedError,
    );
  });
}
