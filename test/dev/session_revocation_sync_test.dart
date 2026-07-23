import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/sync/model/sync_config.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/sync/sync_logger.dart';
import 'package:datarunmobile/core/sync_manager/sync_manager.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await appLocator.reset();
    appLocator.enableRegisteringMultipleInstancesOfOneType();
  });

  tearDown(appLocator.reset);

  test('configuration sync stops and drains after session revocation',
      () async {
    final operationTracker = SessionOperationTracker();
    late Future<void> drain;
    final rejected = _FakeDatasource(
      resourceName: 'rejected',
      onSync: (_) {
        drain = operationTracker.stopAndWaitForIdle();
        throw RevokeTokenException(
          requestOptions: RequestOptions(path: '/rejected'),
        );
      },
    );
    final later = _FakeDatasource(resourceName: 'later');
    appLocator
      ..registerFactory<AbstractDatasource<dynamic>>(() => rejected)
      ..registerFactory<AbstractDatasource<dynamic>>(() => later);
    final manager = SyncManager(operationTracker);
    addTearDown(() async {
      await manager.onDispose();
    });

    await manager.syncAll();
    await drain;

    expect(rejected.syncCalls, 1);
    expect(later.syncCalls, 0);
  });

  test('global sync completes only after the final resource finishes',
      () async {
    final operationTracker = SessionOperationTracker();
    final finalResourceStarted = Completer<void>();
    final releaseFinalResource = Completer<void>();
    final first = _FakeDatasource(
      resourceName: 'first',
      onSync: (progress) {
        progress?.call(_succeeded('first'));
      },
    );
    final finalResource = _FakeDatasource(
      resourceName: 'final',
      onSync: (progress) async {
        progress?.call(const SyncProgressEvent(
          resourceName: 'final',
          syncProgressState: SyncProgressState.RUNNING,
          message: 'fetching',
          percentage: 20,
        ));
        finalResourceStarted.complete();
        await releaseFinalResource.future;
        progress?.call(_succeeded('final'));
      },
    );
    appLocator
      ..registerFactory<AbstractDatasource<dynamic>>(() => first)
      ..registerFactory<AbstractDatasource<dynamic>>(() => finalResource);
    final manager = SyncManager(operationTracker);
    addTearDown(manager.onDispose);

    final sync = manager.syncAll();
    await finalResourceStarted.future;

    expect(manager.globalState.completedResources, 1);
    expect(manager.globalState.completed, isFalse);
    expect(manager.globalState.overallPercentage, lessThan(100));

    releaseFinalResource.complete();
    await sync;

    expect(manager.globalState.completedResources, 2);
    expect(manager.globalState.failedResources, 0);
    expect(manager.globalState.completed, isTrue);
    expect(manager.globalState.overallState, SyncProgressState.SUCCEEDED);
    expect(manager.globalState.overallPercentage, 100);
  });

  test('failed resources prevent global success and counters reset per run',
      () async {
    final operationTracker = SessionOperationTracker();
    final failed = _FakeDatasource(
      resourceName: 'failed',
      onSync: (progress) {
        progress?.call(const SyncProgressEvent(
          resourceName: 'failed',
          syncProgressState: SyncProgressState.FAILED,
          message: 'network unavailable',
          percentage: 100,
          completed: true,
        ));
      },
    );
    final succeeded = _FakeDatasource(
      resourceName: 'succeeded',
      onSync: (progress) {
        progress?.call(_succeeded('succeeded'));
      },
    );
    appLocator
      ..registerFactory<AbstractDatasource<dynamic>>(() => failed)
      ..registerFactory<AbstractDatasource<dynamic>>(() => succeeded);
    final manager = SyncManager(operationTracker);
    addTearDown(manager.onDispose);

    await manager.syncAll();

    expect(manager.globalState.completed, isTrue);
    expect(manager.globalState.completedResources, 2);
    expect(manager.globalState.failedResources, 1);
    expect(manager.globalState.overallState, SyncProgressState.PARTIAL_ERROR);

    await manager.syncAll();

    expect(manager.globalState.completedResources, 2);
    expect(manager.globalState.failedResources, 1);
    expect(manager.globalState.overallPercentage, 100);
  });

  test('retry runs only failed resources and preserves successful work',
      () async {
    final operationTracker = SessionOperationTracker();
    var failingAttempts = 0;
    final failsOnce = _FakeDatasource(
      resourceName: 'failsOnce',
      onSync: (progress) {
        failingAttempts++;
        progress?.call(
          failingAttempts == 1
              ? const SyncProgressEvent(
                  resourceName: 'failsOnce',
                  syncProgressState: SyncProgressState.FAILED,
                  message: 'temporary failure',
                  percentage: 100,
                  completed: true,
                )
              : _succeeded('failsOnce'),
        );
      },
    );
    final alwaysSucceeds = _FakeDatasource(
      resourceName: 'alwaysSucceeds',
      onSync: (progress) {
        progress?.call(_succeeded('alwaysSucceeds'));
      },
    );
    appLocator
      ..registerFactory<AbstractDatasource<dynamic>>(() => failsOnce)
      ..registerFactory<AbstractDatasource<dynamic>>(() => alwaysSucceeds);
    final manager = SyncManager(operationTracker);
    addTearDown(manager.onDispose);

    await manager.syncAll();

    expect(manager.retryableResourceCount, 1);
    expect(failsOnce.syncCalls, 1);
    expect(alwaysSucceeds.syncCalls, 1);

    await manager.retryFailed();

    expect(manager.retryableResourceCount, 0);
    expect(failsOnce.syncCalls, 2);
    expect(alwaysSucceeds.syncCalls, 1);
    expect(manager.globalState.totalResources, 1);
    expect(manager.globalState.overallState, SyncProgressState.SUCCEEDED);
  });

  test('cancel stops the queue after the in-flight resource', () async {
    final operationTracker = SessionOperationTracker();
    final firstStarted = Completer<void>();
    final releaseFirst = Completer<void>();
    final first = _FakeDatasource(
      resourceName: 'first',
      onSync: (progress) async {
        firstStarted.complete();
        await releaseFirst.future;
        progress?.call(_succeeded('first'));
      },
    );
    final later = _FakeDatasource(resourceName: 'later');
    appLocator
      ..registerFactory<AbstractDatasource<dynamic>>(() => first)
      ..registerFactory<AbstractDatasource<dynamic>>(() => later);
    final manager = SyncManager(operationTracker);
    addTearDown(manager.onDispose);

    final sync = manager.syncAll();
    await firstStarted.future;
    manager.cancel();
    releaseFirst.complete();
    await sync;

    expect(first.syncCalls, 1);
    expect(later.syncCalls, 0);
    expect(manager.retryableResourceCount, 1);
    expect(manager.globalState.completed, isTrue);
    expect(manager.globalState.overallState, SyncProgressState.PARTIAL_ERROR);
  });

  test('connection failure skips remaining requests until retry', () async {
    final operationTracker = SessionOperationTracker();
    final unavailable = _FakeDatasource(
      resourceName: 'unavailable',
      onSync: (_) => throw _connectionFailure(),
    );
    final later = _FakeDatasource(resourceName: 'later');
    appLocator
      ..registerFactory<AbstractDatasource<dynamic>>(() => unavailable)
      ..registerFactory<AbstractDatasource<dynamic>>(() => later);
    final manager = SyncManager(operationTracker);
    addTearDown(manager.onDispose);

    await manager.syncAll();

    expect(unavailable.syncCalls, 1);
    expect(later.syncCalls, 0);
    expect(manager.retryableResourceCount, 2);
    expect(manager.globalState.completed, isTrue);
    expect(manager.globalState.failedResources, 2);
    expect(manager.globalState.overallState, SyncProgressState.FAILED);
  });
}

SyncProgressEvent _succeeded(String resourceName) => SyncProgressEvent(
      resourceName: resourceName,
      syncProgressState: SyncProgressState.SUCCEEDED,
      message: 'saved',
      percentage: 100,
      completed: true,
    );

NetworkHttpError _connectionFailure() {
  final request = RequestOptions(path: '/configuration');
  return NetworkHttpError.fromDioException(
    DioException(
      requestOptions: request,
      type: DioExceptionType.connectionError,
      error: StateError('offline'),
    ),
  );
}

class _FakeDatasource implements AbstractDatasource<dynamic> {
  _FakeDatasource({
    required this.resourceName,
    this.onSync,
  });

  @override
  final String resourceName;
  final FutureOr<void> Function(ProgressCallback? progress)? onSync;
  var syncCalls = 0;

  @override
  Future<List<Insertable<dynamic>>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  }) async {
    syncCalls++;
    await onSync?.call(progressCallback);
    return const [];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
