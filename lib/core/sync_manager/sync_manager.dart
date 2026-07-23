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
  int get retryableResourceCount => _retryableResources.length;
  int _completedResources = 0;
  int _failedResources = 0;
  final Set<String> _retryableResources = {};
  Future<void>? _activeRun;
  bool _cancelRequested = false;
  bool _disposed = false;

  /// A stream controller for progress events.
  final StreamController<SyncProgressEvent> _progressController =
      StreamController.broadcast();

  /// Expose the progress stream so the UI can subscribe.
  Stream<SyncProgressEvent> get progressStream => _progressController.stream;

  late SyncProgressGlobalState globalState;

  /// Sync a specific entity type T with granular progress.
  Future<void> _syncEntity(
    String resourceName, {
    required int resourceIndex,
    required int runTotalResources,
  }) async {
    final remoteSource = _remoteDataSourcesMap.get(resourceName);
    globalState = globalState.addSyncStatus(currentMessage: resourceName);
    final basePercent = (resourceIndex / runTotalResources) * 100;
    var finalized = false;

    void recordProgress(SyncProgressEvent event) {
      if (event.completed && !finalized) {
        finalized = true;
        _completedResources++;
        if (!event.syncProgressState.isSuccess) {
          _failedResources++;
          _retryableResources.add(resourceName);
        } else {
          _retryableResources.remove(resourceName);
        }
      }
      final overallProgress =
          basePercent + (event.percentage / 100) * (100 / runTotalResources);

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

  Future<void> syncAll() {
    _retryableResources.clear();
    return _startRun(_remoteDataSourcesMap.keys.toList());
  }

  Future<void> retryFailed() {
    final resources =
        _remoteDataSourcesMap.keys.where(_retryableResources.contains).toList();
    return _startRun(resources);
  }

  Future<void> _startRun(List<String> resources) {
    final activeRun = _activeRun;
    if (activeRun != null) return activeRun;
    if (resources.isEmpty) return Future.value();

    late final Future<void> run;
    run = _operationTracker.track(() => _syncResources(resources)).whenComplete(
      () {
        if (identical(_activeRun, run)) {
          _activeRun = null;
        }
      },
    );
    _activeRun = run;
    return run;
  }

  Future<void> _syncResources(List<String> resources) async {
    _cancelRequested = false;
    _retryableResources.removeAll(resources);
    globalState =
        SyncProgressGlobalState.initial(totalResources: resources.length);
    _completedResources = 0;
    _failedResources = 0;

    for (var resourceIndex = 0;
        resourceIndex < resources.length;
        resourceIndex++) {
      final remoteDataSource = resources[resourceIndex];
      try {
        await _syncEntity(
          remoteDataSource,
          resourceIndex: resourceIndex,
          runTotalResources: resources.length,
        );
      } on RevokeTokenException catch (e) {
        logError('Session expired while syncing $remoteDataSource', source: e);
        return;
      } catch (e) {
        logError('Error syncing $remoteDataSource', source: e);
        if (_isConnectivityFailure(e)) {
          _cancelRemaining(
            resources.skip(resourceIndex + 1),
            reason: 'Connection unavailable',
          );
          return;
        }
      }

      if (_cancelRequested) {
        _cancelRemaining(
          resources.skip(resourceIndex + 1),
          reason: 'Sync cancelled',
        );
        return;
      }
    }
  }

  bool _isConnectivityFailure(Object error) {
    if (error is NetworkHttpError) return error.httpErrorCode == null;
    return error is DioException &&
        (error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout);
  }

  void _cancelRemaining(
    Iterable<String> remaining, {
    required String reason,
  }) {
    for (final resourceName in remaining) {
      _completedResources++;
      _failedResources++;
      _retryableResources.add(resourceName);
      globalState = globalState.addSyncStatus(
        syncStatus: SyncProgressState.CANCELLED,
        overallPercentage:
            (_completedResources / globalState.totalResources) * 100,
        currentMessage: resourceName,
        completedResources: _completedResources,
        failedResources: _failedResources,
      );
      _progressController.add(SyncProgressEvent(
        resourceName: resourceName,
        syncProgressState: SyncProgressState.CANCELLED,
        message: reason,
        percentage: 100,
        completed: true,
      ));
    }
  }

  void cancel() {
    _cancelRequested = true;
  }

  @override
  Future<void> onDispose() async {
    if (_disposed) return;
    _disposed = true;
    cancel();
    await _activeRun;
    logDebug('dispose sync Manager');
    await _progressController.close();
  }
}
