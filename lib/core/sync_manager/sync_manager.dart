import 'dart:async';

import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SyncManager extends Disposable {
  SyncManager(ConnectivityService connectivityService)
      : _remoteDataSourcesMap = IMap.fromIterable(
          appLocator.getAll<AbstractDatasource<dynamic>>(),
          keyMapper: (resource) => resource.resourceName,
          valueMapper: (resource) => resource,
        ),
        _connectivityService = connectivityService;

  final IMap<String, AbstractDatasource<dynamic>> _remoteDataSourcesMap;

  int get totalResources => _remoteDataSourcesMap.length;
  int _currentResource = 0;
  final ConnectivityService _connectivityService;

  /// A stream controller for progress events.
  final StreamController<SyncProgressEvent> _progressController =
      StreamController.broadcast();

  /// Expose the progress stream so the UI can subscribe.
  Stream<SyncProgressEvent> get progressStream => _progressController.stream;

  late SyncProgressGlobalState globalState;

  /// Sync a specific entity type T with granular progress.
  Future<void> syncEntity(String resourceName) async {
    final remoteSource = _remoteDataSourcesMap.get(resourceName);
    globalState = globalState.addSyncStatus(currentMessage: resourceName);
    _currentResource++;
    final basePercent = ((_currentResource - 1) / totalResources) * 100;
    await remoteSource?.syncWithRemote(progressCallback: (event) {
      _progressController.add(event);
      final overallProgress =
          basePercent + (event.percentage / 100) * (100 / totalResources);

      globalState = globalState.addSyncStatus(
        syncStatus: event.syncProgressState,
        overallPercentage: overallProgress,
        currentMessage:
            '${event.resourceName}',
        completedResources: _currentResource,
        syncedItems: event.resources,
      );
    });
  }

  Future<void> syncAll() async {
    // _progressController
    globalState =
        SyncProgressGlobalState.initial(totalResources: totalResources);

    int resourceIndex = 0;

    for (var remoteDataSource in _remoteDataSourcesMap.keys) {
      resourceIndex++;

      // Calculate the base percentage completed before this resource.
      final basePercentage = ((resourceIndex - 1) / totalResources) * 100;

      try {
        final onlineData = await syncEntity(remoteDataSource);

        final overallProgress = (resourceIndex / totalResources) * 100;
      } on DioException catch (e) {
        final overallProgress = (resourceIndex / totalResources) * 100;
        _progressController.add(SyncProgressEvent(
          resourceName: remoteDataSource,
          syncProgressState: SyncProgressState.FAILED,
          message: '❌ Sync error: $e',
          percentage: overallProgress,
          completed: true,
        ));
        logError('Error syncing ${remoteDataSource}: $e');
      } catch (e) {
        final overallProgress = (resourceIndex / totalResources) * 100;
        _progressController.add(SyncProgressEvent(
          resourceName: remoteDataSource,
          syncProgressState: SyncProgressState.FAILED,
          message: '❌ Sync error: $e',
          percentage: overallProgress,
          completed: true,
        ));
        logError('Error syncing ${remoteDataSource}: $e');
      }
    }
  }

  @override
  FutureOr<dynamic> onDispose() {
    logDebug('dispose sync Manager');
    return _progressController.close();
  }
}
