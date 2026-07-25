import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/exception/failure_snapshot.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/dao/data_submissions_dao.dart';
import 'package:datarunmobile/features/data_instance/application/reference_upload_payload_builder.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_result.dart';

class SubmissionUploadService {
  SubmissionUploadService({
    required AppDatabase database,
    required HttpClient<dynamic> apiClient,
    required SessionOperationTracker operationTracker,
  })  : _dao = database.dataInstancesDao,
        _apiClient = apiClient,
        _operationTracker = operationTracker,
        _payloadBuilder = ReferenceUploadPayloadBuilder(database);

  static const _resource = 'dataSubmission/bulk?referenceVersion=1';

  final DataInstancesDao _dao;
  final HttpClient<dynamic> _apiClient;
  final SessionOperationTracker _operationTracker;
  final ReferenceUploadPayloadBuilder _payloadBuilder;

  Future<SubmissionUploadResult> upload(Iterable<String> ids) =>
      _operationTracker.track(() => _upload(ids));

  Future<SubmissionUploadResult> _upload(Iterable<String> ids) async {
    final submissions = await _dao.prepareUpload(ids);
    if (submissions.isEmpty) {
      return SubmissionUploadResult.nothingToUpload();
    }
    final attemptedIds = submissions.map((submission) => submission.id);

    try {
      final payload = await _payloadBuilder.build(submissions);
      final response = await _apiClient.request(
        resourceName: _resource,
        data: payload,
        method: 'post',
      );
      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        throw const FormatException('Invalid submission upload response');
      }
      final summary = ImportSummaryModel.fromJson(responseData);
      await _dao.applyUploadResult(submissions, summary);
      return SubmissionUploadResult.fromSummary(
        attemptedIds: attemptedIds,
        summary: summary,
      );
    } catch (error) {
      final failure = FailureSnapshot.fromError(error);
      await _dao.markUploadFailed(submissions, failure);
      return SubmissionUploadResult.requestFailure(
        attemptedIds: attemptedIds,
        failure: failure,
      );
    }
  }
}
