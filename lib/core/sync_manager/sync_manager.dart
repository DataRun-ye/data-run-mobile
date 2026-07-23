import 'dart:async';

import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/sync_manager/sync_progress_global_state.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncManager extends Disposable {
  SyncManager(this._operationTracker)
      : _remoteDataSourcesMap = IMap.fromIterable(
          appLocator.getAll<AbstractDatasource<dynamic>>(),
          keyMapper: (resource) => resource.resourceName,
          valueMapper: (resource) => resource,
        );

  final IMap<String, AbstractDatasource<dynamic>> _remoteDataSourcesMap;
  final SessionOperationTracker _operationTracker;

  int get totalResources => _remoteDataSourcesMap.length;
  int _completedResources = 0;
  int _failedResources = 0;

  /// A stream controller for progress events.
  final StreamController<SyncProgressEvent> _progressController =
      StreamController.broadcast();

  /// Expose the progress stream so the UI can subscribe.
  Stream<SyncProgressEvent> get progressStream => _progressController.stream;

  late SyncProgressGlobalState globalState;

  /// Sync a specific entity type T with granular progress.
  Future<void> syncEntity(
    String resourceName, {
    required int resourceIndex,
  }) async {
    final remoteSource = _remoteDataSourcesMap.get(resourceName);
    globalState = globalState.addSyncStatus(currentMessage: resourceName);
    final basePercent = (resourceIndex / totalResources) * 100;
    var finalized = false;

    void recordProgress(SyncProgressEvent event) {
      if (event.completed && !finalized) {
        finalized = true;
        _completedResources++;
        if (!event.syncProgressState.isSuccess) {
          _failedResources++;
        }
      }
      final overallProgress =
          basePercent + (event.percentage / 100) * (100 / totalResources);

      globalState = globalState.addSyncStatus(
        syncStatus: event.syncProgressState,
        overallPercentage: overallProgress,
        currentMessage: event.resourceName,
        completedResources: _completedResources,
        failedResources: _failedResources,
        syncedItems: event.resources,
      );
      _progressController.add(event);
    }

    try {
      await remoteSource?.syncWithRemote(progressCallback: recordProgress);
      if (!finalized) {
        recordProgress(SyncProgressEvent(
          resourceName: resourceName,
          syncProgressState: SyncProgressState.SUCCEEDED,
          message: 'Completed',
          percentage: 100,
          completed: true,
        ));
      }
    } catch (error) {
      if (!finalized) {
        recordProgress(SyncProgressEvent(
          resourceName: resourceName,
          syncProgressState: SyncProgressState.FAILED,
          message: 'Sync error: $error',
          percentage: 100,
          completed: true,
        ));
      }
      rethrow;
    }
  }

  Future<void> syncAll() => _operationTracker.track(_syncAll);

  Future<void> _syncAll() async {
    // _progressController
    globalState =
        SyncProgressGlobalState.initial(totalResources: totalResources);
    _completedResources = 0;
    _failedResources = 0;

    int resourceIndex = 0;

    for (var remoteDataSource in _remoteDataSourcesMap.keys) {
      try {
        await syncEntity(
          remoteDataSource,
          resourceIndex: resourceIndex,
        );
      } on RevokeTokenException catch (e) {
        logError('Session expired while syncing $remoteDataSource', source: e);
        return;
      } on DioException catch (e) {
        logError('Error syncing $remoteDataSource', source: e);
      } catch (e) {
        logError('Error syncing $remoteDataSource', source: e);
      }
      resourceIndex++;
    }
  }

  @override
  FutureOr<dynamic> onDispose() {
    logDebug('dispose sync Manager');
    return _progressController.close();
  }
}
