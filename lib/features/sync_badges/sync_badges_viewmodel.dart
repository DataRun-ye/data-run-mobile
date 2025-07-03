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
  final List<SubmissionSyncStatusModel> data = [];

  Future<void> run() async {
    setError(null);
    setBusy(true);
    try {
      final assignmentFormTemplates =
          await runBusyFuture<List<SubmissionSyncStatusModel>>(futureToRun(),
              throwException: true);
      data.addAll(assignmentFormTemplates);
      setBusy(false);
      notifyListeners();
    } catch (error) {
      setError(error);
      setBusy(false);
      notifyListeners();
      rethrow;
    } finally {}
  }

  Future<List<SubmissionSyncStatusModel>> futureToRun() {
    return submissionsDao.selectStatusByLevel(id, aggregationLevel).get();
  }
}
