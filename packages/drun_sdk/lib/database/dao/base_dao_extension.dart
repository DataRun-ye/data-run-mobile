import 'package:d_sdk/core/http/http_client.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/sync/model/sync_config.dart';
import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:d_sdk/core/sync/sync_logger.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/dao/sync_summaries_dao.dart';
import 'package:d_sdk/database/shared/sync_error.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/di/injection.dart';
import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

mixin BaseDaoMixin<D extends Insertable> on DatabaseAccessor<AppDatabase> {
  HttpClient get apiClient => rSdkLocator<HttpClient<dynamic>>();

  SimpleSelectStatement<TableInfo<Table, D>, D> get engine => select(table);

  TableInfo<TableInfo<Table, D>, D> get table;

  String get resourceName;

  D fromApiJson(Map<String, dynamic> data, {ValueSerializer? serializer});

  String get resourcePath => '$resourceName?paged=false';

  SyncSummariesDao get _summariesDao => attachedDatabase.syncSummariesDao;

  /// extract item ID (must match the PK column).
  @protected
  dynamic extractId(Map<String, dynamic> json) => json['uid'];

  /// The master “template” method we’ll never need to override.
  // @override
  Future<List<D>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  }) async {
    final SyncLogger logger = SyncLogger(
        progressCallback: progressCallback, resourceName: resourceName);
    final syncErrors = <SyncError>[];
    List<Map<String, dynamic>> rawJson = [];
    // 1) Fetch
    try {
      // Fetch raw JSON
      rawJson = await getOnlineRaw(options: options);
      logger(percentage: 20, message: rawJson.length.toString());
    } on DioException catch (e) {
      syncErrors.add(SyncError(
          type: SyncStage.fetch, message: 'Fetch error: ${e.message}'));
      logger(
          syncProgressState: SyncProgressState.FAILED,
          message: 'Fetch error: ${e.message}');
      rawJson = []; // proceed with empty payload (or rethrow if you prefer)
    } catch (e) {
      logError('Unexpected fetch error: `$resourcePath`', source: e);
      syncErrors.add(SyncError(
          type: SyncStage.unexpected,
          message: 'Unexpected during fetch error: $e'));
      logger(
          syncProgressState: SyncProgressState.FAILED,
          message: 'Unexpected error during fetch: $e');
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
      } catch (e) {
        logError('Extract extra entities error: `$resourcePath`', source: e);
        syncErrors.add(SyncError(
            type: SyncStage.fetchExtra,
            message: 'Extract extra entities error: $e'));
        logger(
            syncProgressState: SyncProgressState.FAILED,
            message: 'Extract extra entities error: $e');
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
            type: SyncStage.fetchExtra,
            message: 'Mapping error for uid=${item['uid']}: $e',
            extra: {'uid': item['uid']}));
        logger(
            syncProgressState: SyncProgressState.FAILED,
            message: 'Mapping error for uid=${item['uid']}: $e');
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

      logger(percentage: 100, message: rawJson.length.toString());
    } catch (e) {
      logError('Database write error: `$resourcePath`', source: e);
      syncErrors.add(SyncError(
        type: SyncStage.databaseWrite,
        message: 'Database write error: $e',
      ));
      logger(
          syncProgressState: SyncProgressState.FAILED,
          message: 'Database write error: $e');
    }

    // 5) Record summary
    logDebug('saving sync summary: `$resourceName`', data: {
      'mapped': mapped.length,
      'errors': syncErrors.length,
    });

    logger(
        message:
            'summary, errors/mapped: ${syncErrors.length}/${mapped.length}');

    await _summariesDao.upsertSummary(SyncSummary(
      entity: resourceName,
      lastSync: DateTime.now(),
      successCount: mapped.length,
      failureCount: syncErrors.length,
      errors: syncErrors,
    ));

    logger(
        message:
            'sync summary, errors/mapped: ${syncErrors.length}/${mapped.length}',
        syncProgressState: SyncProgressState.SUCCEEDED);

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
  /// Subclasses must implement this, because only they know their `isDisabled` column.
  @protected
  Future<void> disableStale(List<Object> liveIds) async {
    // override in entities with disabling requirements
  }
}
