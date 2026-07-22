import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/paginated_result.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
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

  Future<int> delete(Iterable<String> ids) =>
      _db.dataInstancesDao.hardDeleteIds(ids);

  Future<ImportSummaryModel> sync(Iterable<String> ids) =>
      _uploadService.upload(ids);
}
