import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/paginated_result.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:drift/drift.dart';

class SubmissionTableService {
  SubmissionTableService(this._db);

  final AppDatabase _db;

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
}
