import 'package:d_sdk/database/shared/shared.dart';
import 'package:stacked/stacked.dart';

class AssignmentTypeListViewModel extends ReactiveViewModel {
  // final AssignmentListService _assignmentService =
  // appLocator<AssignmentListService>();

  List<AssignmentModel> items = [];
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;

  Future<void> loadItems() async {
    if (isBusy || !hasMore) return;
    setBusy(true);
    // final newItems = await runBusyFuture(_assignmentService.get(
    //     query: AssignmentQueryModel(limit: limit, offset: offset)));

    // items.addAll(newItems);
    // offset += newItems.length;
    setBusy(false);
    notifyListeners();
    // if (newItems.length < limit) hasMore = false;
  }
}
