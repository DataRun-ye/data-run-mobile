import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/paginated_result.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_result.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SubmissionTableService {
  SubmissionTableService({
    required AppDatabase database,
    required SubmissionUploadService uploadService,
  })  : _db = database,
        _uploadService = uploadService;

  final AppDatabase _db;
  final SubmissionUploadService _uploadService;

  Future<PaginatedResult<SubmissionSummary>> fetchByFilter(
    SubmissionsFilter filter, {
    required int page,
    required int pageSize,
  }) async {
    final totalCount = await countByFilter(filter).getSingle();
    final result = await _db.dataInstancesDao
        .selectable(filter, page: page, pageSize: pageSize)
        .get();
    return PaginatedResult(items: result, totalCount: totalCount);
  }

  Selectable<int> countByFilter(SubmissionsFilter filter) =>
      _db.dataInstancesDao.countSubmissions(filter);

  Future<List<String>> getSyncableIds(ISet<String> ids) async {
    final items = await _db.managers.dataInstances
        .filter((f) =>
            f.id.isIn(ids) &
            f.syncState.isIn([
              InstanceSyncStatus.finalized,
              InstanceSyncStatus.syncFailed,
            ]))
        .get();
    return items.map((item) => item.id).toList();
  }

  Future<bool> canDeleteLocalOnly(Iterable<String> ids) async {
    final requestedIds = ids.toSet();
    if (requestedIds.isEmpty) return true;

    final rows = await (_db.select(_db.dataInstancesDao.table)
          ..where((row) => row.id.isIn(requestedIds)))
        .get();
    return !_containsServerRetainedRow(rows);
  }

  Future<LocalSubmissionDeletionResult> deleteLocalOnly(
      Iterable<String> ids) async {
    final requestedIds = ids.toSet();
    if (requestedIds.isEmpty) return LocalSubmissionDeletionResult.deleted;

    return _db.transaction(() async {
      final table = _db.dataInstancesDao.table;
      final rows = await (_db.select(table)
            ..where((row) => row.id.isIn(requestedIds)))
          .get();

      if (_containsServerRetainedRow(rows)) {
        return LocalSubmissionDeletionResult.blockedByServerRetention;
      }

      await (_db.delete(table)..where((row) => row.id.isIn(requestedIds))).go();
      return LocalSubmissionDeletionResult.deleted;
    });
  }

  bool _containsServerRetainedRow(Iterable<DataInstance> rows) => rows.any(
        (row) =>
            row.isToUpdate ||
            row.syncState == InstanceSyncStatus.synced ||
            row.syncState == InstanceSyncStatus.uploading,
      );

  Future<SubmissionUploadResult> sync(Iterable<String> ids) =>
      _uploadService.upload(ids);
}

enum LocalSubmissionDeletionResult { deleted, blockedByServerRetention }
