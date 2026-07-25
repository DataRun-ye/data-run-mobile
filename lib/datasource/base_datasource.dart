import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/sync/model/sync_config.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/sync/sync_logger.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/converters/custom_serializer.dart';
import 'package:datarunmobile/database/dao/sync_summaries_dao.dart';
import 'package:datarunmobile/database/shared/sync_error.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

abstract class BaseDataSource<T extends TableInfo<T, D>,
    D extends Insertable<D>> extends AbstractDatasource<D> {
  HttpClient<dynamic> get apiClient => appLocator<HttpClient<dynamic>>();

  T get table;

  AppDatabase get db {
    final instance = appLocator<AppDatabase>();
    return instance;
  }

  SyncSummariesDao get _summariesDao => db.syncSummariesDao;

  /// The master “template” method we’ll never need to override.
  @override
  Future<List<D>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  }) async {
    final SyncLogger logger = SyncLogger(
        progressCallback: progressCallback, resourceName: resourceName);
    final syncErrors = <SyncError>[];
    RevokeTokenException? sessionExpired;
    NetworkHttpError? connectivityFailure;
    var fetchFailed = false;
    var databaseWriteFailed = false;
    List<Map<String, dynamic>> rawJson = [];
    // 1) Fetch
    try {
      // Fetch raw JSON
      rawJson = await getOnlineRaw(options: options);
      logger(percentage: 20, message: 'fetched ${rawJson.length} items');
    } on RevokeTokenException catch (e) {
      sessionExpired = e;
      fetchFailed = true;
      syncErrors.add(SyncError(
        type: SyncStage.fetch,
        message: 'Session expired while fetching configuration',
      ));
      logger(
        syncProgressState: SyncProgressState.RUNNING,
        message: 'Session expired while fetching configuration',
        completed: false,
      );
      rawJson = [];
    } on NetworkHttpError catch (e) {
      fetchFailed = true;
      if (e.httpErrorCode == null) {
        connectivityFailure = e;
      }
      syncErrors.add(SyncError(
          type: SyncStage.fetch, message: 'Fetch error: ${e.message}'));
      logger(
        syncProgressState: SyncProgressState.RUNNING,
        message: 'Fetch error: ${e.message}',
        completed: false,
      );
      rawJson = []; // proceed with empty payload (or rethrow if you prefer)
    } on DioException catch (e) {
      fetchFailed = true;
      syncErrors.add(SyncError(
          type: SyncStage.fetch, message: 'Fetch error: ${e.message}'));
      logger(
        syncProgressState: SyncProgressState.RUNNING,
        message: 'Fetch error: ${e.message}',
        completed: false,
      );
      rawJson = [];
    } catch (e) {
      fetchFailed = true;
      logError('Unexpected fetch error: `$resourcePath`', source: e);
      syncErrors.add(SyncError(
          type: SyncStage.fetch, message: 'Unexpected during fetch error: $e'));
      logger(
        syncProgressState: SyncProgressState.RUNNING,
        message: 'Unexpected error during fetch: $e',
        completed: false,
      );
      rawJson = [];
    }

    logger(message: 'fetching extra');

    // 2) Extract extras
    List<CompanionInsert> extra = [];
    if (rawJson.isNotEmpty) {
      try {
        // A hook, let subclass extract any “auxiliary” entities
        extra = await extractExtraEntities(rawJson);
        logger(percentage: 40, message: extra.length.toString());
      } on RevokeTokenException {
        rethrow;
      } catch (e) {
        logError('Extract extra entities error: `$resourcePath`', source: e);
        syncErrors.add(SyncError(
            type: SyncStage.fetchExtra,
            message: 'Extract extra entities error: $e'));
        logger(
          syncProgressState: SyncProgressState.PARTIAL_ERROR,
          message: 'Extract extra entities error: $e',
          completed: false,
        );
        extra = [];
      }
    }

    logger(message: 'identifiers');

    // 3) Map & collect IDs
    // Map JSON → your D objects, and collect the server’s “live” IDs
    final mapped = <D>[];
    final liveIds = <String>[];
    for (var item in rawJson) {
      try {
        final entity = mapRemoteItem(item);
        mapped.add(entity);
        liveIds.add(extractId(item) as String);
        logger(percentage: 60, message: liveIds.length.toString());
      } catch (e) {
        logError('Mapping error: `$resourcePath`, for uid=`${item['uid']}`',
            source: e);
        syncErrors.add(SyncError(
            type: SyncStage.mapping,
            message: 'Mapping error for uid=${item['uid']}: $e',
            extra: {'uid': item['uid']}));
        logger(
          syncProgressState: SyncProgressState.PARTIAL_ERROR,
          message: 'Mapping error for uid=${item['uid']}: $e',
          completed: false,
        );
      }
    }

    // Transaction (upserts + disable)
    try {
      await db.transaction(() async {
        if (mapped.isNotEmpty) {
          logger(message: 'persisting $resourceName');
          await db.batch((b) => b.insertAllOnConflictUpdate(table, mapped));
        }

        // let subclass write any extra tables it needs
        if (extra.isNotEmpty) {
          logger(message: 'persisting extra');
          await db.batch((b) {
            b.deleteAll(extra.first.table);
            for (var ci in extra) {
              b.insertAllOnConflictUpdate(ci.table, [ci.entity]);
            }
          });
        }

        logger(percentage: 80, message: rawJson.length.toString());

        // to not disable all in case of fetch error empty list
        if (liveIds.isNotEmpty &&
            syncErrors.where((e) => e.type == SyncStage.fetch).isEmpty) {
          logger(message: 'disable ${liveIds} Stale items');

          // disable anything not in liveIds only if no errors
          await disableStale(liveIds);
        }
      });
    } catch (e) {
      databaseWriteFailed = true;
      logError('Database write error: `$resourcePath`', source: e);
      syncErrors.add(SyncError(
        type: SyncStage.databaseWrite,
        message: 'Database write error: $e',
      ));
      logger(
        syncProgressState: SyncProgressState.RUNNING,
        message: 'Database write error: $e',
        completed: false,
      );
    }

    final finalState = fetchFailed || databaseWriteFailed
        ? SyncProgressState.FAILED
        : syncErrors.isEmpty
            ? SyncProgressState.SUCCEEDED
            : SyncProgressState.PARTIAL_ERROR;
    await _summariesDao.upsertSummary(SyncSummary(
      entity: resourceName,
      lastSync: DateTime.now(),
      successCount: mapped.length,
      failureCount: syncErrors.length,
      errors: syncErrors,
    ));

    logger(
      percentage: 100,
      message: finalState.isSuccess
          ? 'Saved ${rawJson.length}'
          : 'Completed with ${syncErrors.length} error(s)',
      resources: mapped.length,
      syncProgressState: finalState,
      completed: true,
    );

    if (sessionExpired != null) {
      throw sessionExpired;
    }
    if (connectivityFailure != null) {
      throw connectivityFailure;
    }

    return mapped;
  }

  /// Step 1: fetch the raw JSON list—subclasses only override if they must page, add headers, etc.
  @protected
  Future<List<Map<String, dynamic>>> getOnlineRaw({
    SyncConfig? options,
    Map<String, dynamic>? params,
  }) async {
    final response = await apiClient.request(
      resourceName: resourcePath,
      method: 'get',
    );
    final raw = response.data?[resourceName] as List? ?? [];
    return raw.cast<Map<String, dynamic>>();
  }

  /// Step 2: subclasses can override to return extra companion objects for other tables.
  /// Hook2: subclasses override to pull out extra tables’ inserts.
  /// E.g. TeamDS would pull out its `ManagedTeam` inserts here.
  /// Now async
  @protected
  Future<List<CompanionInsert>> extractExtraEntities(
      List<Map<String, dynamic>> raw) async {
    return [];
  }

  /// Step 3a: map one JSON item → to Drift entity.
  @protected
  D mapRemoteItem(Map<String, dynamic> json) {
    // default just calls your existing fromApiJson
    final withFlags = {
      ...json,
      'id': extractId(json),
      'dirty': false,
      'isToUpdate': true,
      'label': json['label'] ?? <String, dynamic>{},
      'translations': (json['translations'] as List?) ?? [],
    };
    return fromApiJson(withFlags, serializer: CustomSerializer());
  }

  /// Hook4: disable (soft‑delete) any rows not in [liveIds].
  /// disables any authoritative enabled items, if they are no longer in current sync scope
  ///
  /// Subclasses must implement this, because only they know their `disable/soft delete` column.
  @protected
  Future<void> disableStale(List<Object> liveIds) async {
    // override in entities with disabling requirements
  }

  /// extract item ID (must match the PK column).
  @protected
  dynamic extractId(Map<String, dynamic> json) => json['uid'];

  D fromApiJson(
    Map<String, dynamic> data, {
    ValueSerializer? serializer,
  });
}

/// Helper for “extra” batch inserts
@protected
class CompanionInsert<T extends Table, D extends DataClass> {
  CompanionInsert(this.table, this.entity);

  final TableInfo<T, D> table;
  final Insertable<D> entity;
}
