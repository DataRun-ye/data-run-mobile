import 'package:datarunmobile/database/shared/paginated_result.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:drift/drift.dart';

abstract class FormInstanceService {
  Future<PaginatedResult<SubmissionSummary>> fetchByFilter(
    SubmissionsFilter templateFilter, {
    required int page,
    required int pageSize,
  });

  Selectable<int> countByFilter(SubmissionsFilter templateFilter);
}
