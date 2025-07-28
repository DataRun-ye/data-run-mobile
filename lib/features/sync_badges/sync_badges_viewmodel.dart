import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:stacked/stacked.dart';

class SyncBadgesViewModel
    extends StreamViewModel<List<SubmissionSyncStatusModel>> {
  SyncBadgesViewModel({
    required this.aggregationLevel,
    required this.id,
    this.assignmentId,
  });

  final String id;
  final String? assignmentId;
  final StatusAggregationLevel aggregationLevel;
  late final DataInstancesDao submissionsDao = DSdk.db.dataInstancesDao;

  @override
  Stream<List<SubmissionSyncStatusModel>> get stream => submissionsDao
      .selectStatusByLevel(
          id: id,
          aggregationLevel: aggregationLevel,
          assignmentId: assignmentId)
      .watch();
}
