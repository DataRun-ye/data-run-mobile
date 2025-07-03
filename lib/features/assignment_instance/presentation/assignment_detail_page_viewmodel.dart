import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:stacked/stacked.dart';

class AssignmentDetailPageViewModel extends BaseViewModel {
  AssignmentDetailPageViewModel(this.assignmentId)
      : this._db = appLocator<DbManager>().db;

  final String assignmentId;

  late Assignment assignment;
  int currentStageIndex = 0;
  Map<String, dynamic> drafts = {};

  final AppDatabase _db;

  Future<void> loadItem() async {
    setBusy(true);
    final fetched =
        await runBusyFuture(_db.assignmentsDao.getById(assignmentId));
    assignment = fetched!;
    setBusy(false);
  }

  void startNew(String stageId) {}

  Future<void> save(String stageId, Map data) async {
    // if (assignment!.type.stages.any((s) => s.id == stageId && s.entityBound)) {
    //   await appLocator<EntityInstanceService>()
    //       .upsert(assignmentId, stageId, data);
    // } else {
    //   await locator<StageSubmissionService>().save(assignmentId, stageId, data);
    // }
    // notifyListeners();
  }

  void cancel(String stageId) {}

  void nextStage() {
    currentStageIndex++;
    notifyListeners();
  }

  void prevStage() {
    currentStageIndex--;
    notifyListeners();
  }

  InstanceSyncStatus stageState(int index) {
    // final stageId = assignment!.type.stages[index].id;
    // inspect assignment.stageStates or submissionProvider to decide
    return InstanceSyncStatus.finalized; // example
  }
}
