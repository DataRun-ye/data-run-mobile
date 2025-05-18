import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:stacked/stacked.dart';

class SyncBadgesViewModel
    extends FutureViewModel<List<SubmissionSyncStatusModel>> {
  SyncBadgesViewModel({required this.aggregationLevel, required this.id});

  final String id;
  final StatusAggregationLevel aggregationLevel;
  late final DataSubmissionsDao submissionsDao = DSdk.db.dataSubmissionsDao;

  @override
  Future<List<SubmissionSyncStatusModel>> futureToRun() {
    return submissionsDao.watchStatusByLevel(id, aggregationLevel).get();
  }
}
