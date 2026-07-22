import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/sync/sync_summary_model.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/dao/data_submissions_dao.dart';
import 'package:datarunmobile/database/extensions/data_submission.extension.dart';

class SubmissionUploadService {
  SubmissionUploadService({
    required AppDatabase database,
    required HttpClient<dynamic> apiClient,
  })  : _dao = database.dataInstancesDao,
        _apiClient = apiClient;

  static const _resource = 'dataSubmission/bulk';

  final DataInstancesDao _dao;
  final HttpClient<dynamic> _apiClient;

  Future<ImportSummaryModel> upload(Iterable<String> ids) async {
    final submissions = await _dao.prepareUpload(ids);
    if (submissions.isEmpty) return ImportSummaryModel.empty();

    try {
      final response = await _apiClient.request(
        resourceName: _resource,
        data: submissions.map((submission) => submission.toUpload()).toList(),
        method: 'post',
      );
      final summary = ImportSummaryModel.fromJson(response.data);
      await _dao.applyUploadResult(submissions, summary);
      return summary;
    } catch (error) {
      await _dao.markUploadFailed(submissions, error);
      return ImportSummaryModel.empty();
    }
  }
}
