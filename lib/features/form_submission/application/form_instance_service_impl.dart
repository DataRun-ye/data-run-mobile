import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/paginated_result.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FormInstanceService)
class FormInstanceServiceImpl extends FormInstanceService {
  final AppDatabase _db = appLocator<AppDatabase>();

  @override
  Future<PaginatedResult<SubmissionSummary>> fetchByFilter(
    SubmissionsFilter templateFilter, {
    required int page,
    required int pageSize,
  }) async {
    final totalCount = await countByFilter(templateFilter).getSingle();
    final result = await _db.dataInstancesDao
        .selectable(templateFilter, page: page, pageSize: pageSize)
        .get();
    return PaginatedResult(items: result, totalCount: totalCount);
  }

  @override
  Selectable<int> countByFilter(SubmissionsFilter templateFilter) =>
      _db.dataInstancesDao.countSubmissions(templateFilter);
}
