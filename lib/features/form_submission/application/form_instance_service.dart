import 'package:d_sdk/database/shared/paged_items.dart';
import 'package:d_sdk/database/shared/submission_card_summary.dart';
import 'package:d_sdk/database/shared/submissions_filter.dart';

abstract class FormInstanceService {
  Future<List<SubmissionSummary>> fetchByAssignment(String assignmentId);

  Future<PagedItems<SubmissionSummary>> fetchByFilter(SubmissionsFilter filter);

  Future<bool> isSoftDelete(String instanceUid);

  Stream<List<SubmissionSummary>> watchByAssignment(String assignmentId);

  Stream<List<SubmissionSummary>> watchByFilter(SubmissionsFilter filter);

  Stream<PagedItems<SubmissionSummary>> watchByFilterWithCount(
      SubmissionsFilter filter);
}
