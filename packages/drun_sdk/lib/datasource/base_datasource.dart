import 'package:d_sdk/core/http/http_client.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/sync/model/sync_config.dart';
import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:d_sdk/core/sync/sync_logger.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/dao/sync_summaries_dao.dart';
import 'package:d_sdk/database/dbManager.dart';
import 'package:d_sdk/database/shared/sync_error.dart';
import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:d_sdk/di/injection.dart';
import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

abstract class BaseDataSource<T extends TableInfo<T, D>,
    D extends Insertable<D>> extends AbstractDatasource<D> {
  HttpClient get apiClient => rSdkLocator<HttpClient<dynamic>>();

  T get table;

  AppDatabase get db {
    final instance = rSdkLocator<DbManager>().db;
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
    List<Map<String, dynamic>> rawJson = [];
    // 1) Fetch
    try {
      // Fetch raw JSON
      rawJson = await getOnlineRaw(options: options);
      logger(percentage: 20, message: 'fetched ${rawJson.length} items');
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

      logger(
          percentage: 100,
          message: 'Saved ${rawJson.length}',
          resources: rawJson.length,
          syncProgressState: SyncProgressState.SUCCEEDED);
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

    // logger(
    //     message:
    //         'mapped ${mapped.length}, errors: ${syncErrors.length}');

    await _summariesDao.upsertSummary(SyncSummary(
      entity: resourceName,
      lastSync: DateTime.now(),
      successCount: mapped.length,
      failureCount: syncErrors.length,
      errors: syncErrors,
    ));

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

  /// extract item ID (must match the PK column).
  @protected
  dynamic extractId(Map<String, dynamic> json) => json['uid'];
}

/// Helper for “extra” batch inserts
@protected
class CompanionInsert<T extends Table, D extends DataClass> {
  final TableInfo<T, D> table;
  final Insertable<D> entity;

  CompanionInsert(this.table, this.entity);
}

// ## What is a “Hook”?
//
// A **hook** is simply an extension point in an algorithm where subclasses (or clients) can plug in custom behavior without having to re‑write the entire algorithm. In code terms it’s:
//
// 1. **A protected (or abstract) method** declared in the base class.
// 2. **Called at a well‑defined spot** inside the template method.
// 3. **Overridden by subclasses** to customize just that one piece.
//
// Your `BaseDataSource.syncWithRemote()` is the **template method**—it defines the overall steps:
//
// 1. Fetch raw JSON
// 2. Ask for “extra” inserts
// 3. Map + collect IDs
// 4. Batch‑write main table
// 5. Batch‑write extras
// 6. Disable stale rows
//
// Each of those numbered steps is a potential hook. Subclasses simply override the hook(s) they need:
//
// * `extractExtraEntities(...)` to pull in child tables
// * `mapRemoteItem(...)` or `fromApiJson(...)` to tweak per‑row mapping
// * `disableStale(...)` to soft‑delete their own rows
//
// Everything else—transaction boundaries, progress callbacks, batched upserts—remains central and un‑duplicated.
//
// ---
//
// ## Why Hooks Matter
//
// * **DRY**: You avoid copy‑pasting the same transaction logic in every datasource.
// * **Separation of Concerns**: The base class cares about *how* to sync (the steps), and subclasses care only about *what* data they need to pull or modify at each step.
// * **Evolvability**: If you ever need to change “how” you upsert or disable stale rows, you do it once in the base—not in dozens of datasources.
//
// ---
//
// ## The Hook Pattern in Other Contexts
//
// You’ll see hooks everywhere, for example:
//
// * **UI frameworks** (React’s `useEffect` or Flutter hooks) expose lifecycle hooks so you can run code on mount/unmount.
// * **Logging libraries** let you hook into “before log” or “after log” events to add context or filter messages.
// * **Web frameworks** often have request lifecycle hooks (e.g. “onRequest”, “onResponse”) so you can inject authentication, metrics, etc.
//
// At heart it’s all the same idea: **“I’ll call you here if you need to do something extra.”**
//
// that’s exactly what people mean when they talk about “hooks” or “hook points” in an application.
