import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/sync/model/sync_config.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/sync_error.dart';
import 'package:datarunmobile/datasource/base_datasource.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    await appLocator.reset();
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'sync-test',
    );
    appLocator.registerSingleton<AppDatabase>(
      database,
      dispose: (db) => db.close(),
    );
  });

  tearDown(appLocator.reset);

  test('a fetch failure remains failed after local persistence completes',
      () async {
    final events = <SyncProgressEvent>[];
    final datasource = _OutcomeDatasource(
      fetch: () => throw StateError('offline'),
    );

    await datasource.syncWithRemote(progressCallback: events.add);

    expect(events.last.syncProgressState, SyncProgressState.FAILED);
    expect(events.last.completed, isTrue);
    expect(
      events.skipWhile((event) => !event.syncProgressState.isFailed),
      isNot(contains(
        isA<SyncProgressEvent>().having(
          (event) => event.syncProgressState,
          'state',
          SyncProgressState.SUCCEEDED,
        ),
      )),
    );
    final summary = await (database.select(database.syncSummaries)
          ..where((row) => row.entity.equals('outcomes')))
        .getSingle();
    expect(summary.successCount, 0);
    expect(summary.failureCount, 1);
    expect(summary.errors?.single.type, SyncStage.fetch);
  });

  test('mapping errors finish as partial instead of successful', () async {
    final events = <SyncProgressEvent>[];
    final datasource = _OutcomeDatasource(
      fetch: () async => [
        {'uid': 'broken-project'}
      ],
      failMapping: true,
    );

    await datasource.syncWithRemote(progressCallback: events.add);

    expect(events.last.syncProgressState, SyncProgressState.PARTIAL_ERROR);
    expect(events.last.completed, isTrue);
    final summary = await (database.select(database.syncSummaries)
          ..where((row) => row.entity.equals('outcomes')))
        .getSingle();
    expect(summary.successCount, 0);
    expect(summary.failureCount, 1);
    expect(summary.errors?.single.type, SyncStage.mapping);
  });

  test('connection failures persist their outcome before stopping the queue',
      () async {
    final events = <SyncProgressEvent>[];
    final request = RequestOptions(path: '/api/v1/outcomes');
    final connectionFailure = NetworkHttpError.fromDioException(
      DioException(
        requestOptions: request,
        type: DioExceptionType.connectionError,
        error: StateError('offline'),
      ),
    );
    final datasource = _OutcomeDatasource(
      fetch: () => throw connectionFailure,
    );

    await expectLater(
      datasource.syncWithRemote(progressCallback: events.add),
      throwsA(same(connectionFailure)),
    );

    expect(events.last.syncProgressState, SyncProgressState.FAILED);
    expect(events.last.completed, isTrue);
    final summary = await (database.select(database.syncSummaries)
          ..where((row) => row.entity.equals('outcomes')))
        .getSingle();
    expect(summary.failureCount, 1);
    expect(summary.errors?.single.type, SyncStage.fetch);
  });
}

class _OutcomeDatasource extends BaseDataSource<$ProjectsTable, Project> {
  _OutcomeDatasource({
    required this.fetch,
    this.failMapping = false,
  });

  final Future<List<Map<String, dynamic>>> Function() fetch;
  final bool failMapping;

  @override
  String get resourceName => 'outcomes';

  @override
  $ProjectsTable get table => db.projects;

  @override
  Future<List<Map<String, dynamic>>> getOnlineRaw({
    SyncConfig? options,
    Map<String, dynamic>? params,
  }) {
    return fetch();
  }

  @override
  Project mapRemoteItem(Map<String, dynamic> json) {
    if (failMapping) throw FormatException('invalid project', json);
    return super.mapRemoteItem(json);
  }

  @override
  Project fromApiJson(
    Map<String, dynamic> data, {
    ValueSerializer? serializer,
  }) {
    return Project.fromJson(data, serializer: serializer);
  }
}
