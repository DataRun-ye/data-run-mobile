import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/shared/shared.dart';
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
  late final DataInstancesDao submissionsDao = DSdk.db.dataInstancesDao;

  @override
  Stream<List<SubmissionSyncStatusModel>> get stream => submissionsDao
      .selectStatusByLevel(
          formId: formId,
          submissionId: submissionId,
          assignmentId: assignmentId)
      .watch();
}
