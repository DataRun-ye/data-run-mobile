import 'package:datarunmobile/database/domain/filter.dart';
import 'package:datarunmobile/database/shared/paginated_result.dart';
import 'package:datarunmobile/database/shared/submission_summary.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:drift/drift.dart';

abstract class FormInstanceService {
  Future<PaginatedResult<SubmissionSummary>> fetchByFilter(
    SubmissionsFilter templateFilter, {
    required int page,
    required int pageSize,
    Iterable<FilterCondition> filters,
    String? sortColumn,
    bool sortAscending = true,
  });

  Selectable<int> countByFilter(
    SubmissionsFilter templateFilter, {
    Iterable<FilterCondition> filters,
  });

  Stream<PaginatedResult<SubmissionSummary>> watchByFilterWithCount(
    SubmissionsFilter templateFilter, {
    required int page,
    required int pageSize,
    Iterable<FilterCondition> filters,
    String? sortColumn,
    bool sortAscending = true,
  });

  Future<bool> isSoftDelete(String instanceUid);

// Future<int> delete(Iterable<String> instanceUid);
//
// Future<void> sync(Iterable<String> instanceUid);
}
