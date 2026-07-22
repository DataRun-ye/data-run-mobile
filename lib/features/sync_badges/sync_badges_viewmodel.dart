import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/dao/data_submissions_dao.dart';
import 'package:datarunmobile/database/shared/submission_sync_status_model.dart';
import 'package:stacked/stacked.dart';

class SyncBadgesViewModel
    extends StreamViewModel<List<SubmissionSyncStatusModel>> {
  SyncBadgesViewModel({
    this.formId,
    this.assignmentId,
    this.submissionId,
  });

  final String? formId;
  final String? assignmentId;
  final String? submissionId;
  late final DataInstancesDao submissionsDao =
      appLocator<AppDatabase>().dataInstancesDao;

  @override
  Stream<List<SubmissionSyncStatusModel>> get stream => submissionsDao
      .selectStatusByLevel(
          formId: formId,
          submissionId: submissionId,
          assignmentId: assignmentId)
      .watch();
}
