import 'package:d_sdk/database/shared/submission_card_summary.dart';
import 'package:d_sdk/database/shared/submissions_filter.dart';

abstract class FormInstanceService {
  Future<List<SubmissionSummary>> fetchByAssignment(String assignmentId);

  Future<List<SubmissionSummary>> fetchByFilter(SubmissionsFilter? filter);

  Future<bool> isSoftDelete(String instanceUid);
}
