import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/sync/model/sync_config.dart';
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
      onSync: () {
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
}

class _FakeDatasource implements AbstractDatasource<dynamic> {
  _FakeDatasource({
    required this.resourceName,
    this.onSync,
  });

  @override
  final String resourceName;
  final void Function()? onSync;
  var syncCalls = 0;

  @override
  Future<List<Insertable<dynamic>>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  }) async {
    syncCalls++;
    onSync?.call();
    return const [];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
