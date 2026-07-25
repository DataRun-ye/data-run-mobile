import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/sync/model/sync_config.dart';
import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/sync/sync_logger.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/sync_error.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:dio/dio.dart' hide ProgressCallback;
import 'package:drift/drift.dart';

class ReferenceEntryDatasource extends AbstractDatasource<ReferenceEntry> {
  ReferenceEntryDatasource(
    this._database,
    this._apiClient, {
    ReferenceEntryRepository? repository,
  }) : _repository = repository ?? ReferenceEntryRepository(_database);

  static const int pageSize = ReferenceEntryRepository.maxRemotePageSize;

  final AppDatabase _database;
  final HttpClient<dynamic> _apiClient;
  final ReferenceEntryRepository _repository;

  @override
  String get resourceName => 'referenceEntries';

  @override
  String get resourcePath => resourceName;

  @override
  Future<List<Insertable<ReferenceEntry>>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  }) async {
    final logger = SyncLogger(
      progressCallback: progressCallback,
      resourceName: resourceName,
    );
    var persistedCount = 0;

    try {
      final scopes = await _repository.findSyncScopes();
      logger(percentage: 5, message: 'Found ${scopes.length} scopes');

      for (var scopeIndex = 0; scopeIndex < scopes.length; scopeIndex++) {
        final scope = scopes[scopeIndex];
        var pageNumber = 0;
        while (true) {
          final page = await _fetchPage(
            assignmentUid: scope.assignmentUid,
            pageNumber: pageNumber,
          );
          _validatePage(page, requestedPage: pageNumber);
          final entries =
              page.items.map(_mapRemoteItem).toList(growable: false);
          await _repository.upsertRemotePage(
            orgUnitUid: scope.orgUnitUid,
            entries: entries,
          );
          persistedCount += entries.length;

          final totalPages = page.totalPages < 1 ? 1 : page.totalPages;
          final scopeProgress = (pageNumber + 1) / totalPages;
          logger(
            percentage: 5 + ((scopeIndex + scopeProgress) / scopes.length) * 90,
            message: 'Saved page ${pageNumber + 1} of ${page.totalPages}',
            resources: persistedCount,
          );

          if (page.totalPages == 0 || pageNumber + 1 >= page.totalPages) {
            break;
          }
          pageNumber++;
        }
      }

      await _recordSummary(
        successCount: persistedCount,
        errors: const [],
        successful: true,
      );
      logger(
        percentage: 100,
        message: 'Saved $persistedCount references',
        resources: persistedCount,
        syncProgressState: SyncProgressState.SUCCEEDED,
        completed: true,
      );
      return const [];
    } catch (error, stackTrace) {
      logError(
        'Reference catalog sync failed',
        source: error,
        stackTrace: stackTrace,
      );
      final syncError = SyncError(
        type: _stageFor(error),
        message: error.toString(),
      );
      await _recordSummary(
        successCount: persistedCount,
        errors: [syncError],
        successful: false,
      );
      logger(
        percentage: 100,
        message: 'Reference catalog sync failed',
        resources: persistedCount,
        syncProgressState: SyncProgressState.FAILED,
        completed: true,
      );
      rethrow;
    }
  }

  Future<_ReferencePage> _fetchPage({
    required String assignmentUid,
    required int pageNumber,
  }) async {
    final path = 'assignments/$assignmentUid/referenceEntries'
        '?page=$pageNumber&size=$pageSize';
    final response = await _apiClient.request(
      resourceName: path,
      method: 'get',
    );
    final data = response.data;
    if (data is! Map) {
      throw const FormatException('Reference page must be a JSON object');
    }
    return _ReferencePage.fromJson(Map<String, dynamic>.from(data));
  }

  ReferenceEntry _mapRemoteItem(Map<String, dynamic> json) {
    final uid = json['uid'];
    final orgUnitUid = json['orgUnitUid'];
    final name = json['name'];
    if (uid is! String ||
        orgUnitUid is! String ||
        name is! String ||
        uid.isEmpty ||
        orgUnitUid.isEmpty ||
        name.trim().isEmpty) {
      throw const FormatException('Reference entry is incomplete');
    }
    return ReferenceEntry(
      uid: uid,
      orgUnitUid: orgUnitUid,
      displayName: name,
    );
  }

  void _validatePage(
    _ReferencePage page, {
    required int requestedPage,
  }) {
    if (!page.paged ||
        page.page != requestedPage ||
        page.totalPages < 0 ||
        (page.totalPages == 0 && page.items.isNotEmpty) ||
        (page.totalPages > 0 && page.page >= page.totalPages) ||
        page.items.length > pageSize) {
      throw const FormatException('Reference page metadata is invalid');
    }
  }

  SyncStage _stageFor(Object error) {
    if (error is NetworkHttpError ||
        error is RevokeTokenException ||
        error is DioException) {
      return SyncStage.fetch;
    }
    if (error is FormatException || error is ReferenceEntryScopeConflict) {
      return SyncStage.mapping;
    }
    return SyncStage.databaseWrite;
  }

  Future<void> _recordSummary({
    required int successCount,
    required List<SyncError> errors,
    required bool successful,
  }) async {
    final now = DateTime.now().toUtc();
    final previous = await (_database.select(_database.syncSummaries)
          ..where((row) => row.entity.equals(resourceName)))
        .getSingleOrNull();
    await _database.syncSummariesDao.upsertSummary(
      SyncSummary(
        entity: resourceName,
        lastSync: now,
        successCount: successCount,
        failureCount: errors.length,
        errors: errors,
        lastSuccessfulSync: successful ? now : previous?.lastSuccessfulSync,
      ),
    );
  }
}

class _ReferencePage {
  const _ReferencePage({
    required this.paged,
    required this.page,
    required this.totalPages,
    required this.items,
  });

  factory _ReferencePage.fromJson(Map<String, dynamic> json) {
    final paged = json['paged'];
    final page = json['page'];
    final totalPages = json['totalPages'];
    final rawItems = json['referenceEntries'];
    if (paged is! bool ||
        page is! int ||
        totalPages is! int ||
        rawItems is! List) {
      throw const FormatException('Reference page metadata is incomplete');
    }
    return _ReferencePage(
      paged: paged,
      page: page,
      totalPages: totalPages,
      items: rawItems.map((item) {
        if (item is! Map) {
          throw const FormatException(
            'Reference page item must be an object',
          );
        }
        return Map<String, dynamic>.from(item);
      }).toList(growable: false),
    );
  }

  final bool paged;
  final int page;
  final int totalPages;
  final List<Map<String, dynamic>> items;
}
