import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/data/assignment/assignment.dart';
import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
import 'package:datarunmobile/data/assignment/model/assignment_resource_service.dart';
import 'package:datarunmobile/data/assignment/model/filter_query_service.dart';
import 'package:datarunmobile/data/assignment/model/timeline_service.dart';
import 'package:datarunmobile/data/form/form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AssignmentListViewModel extends ReactiveViewModel {
  final AssignmentListService _assignmentService =
  locator<AssignmentListService>();

  List<AssignmentModelNew> items = [];
  int offset = 0;
  final int limit = 20;
  bool hasMore = true;

  Future<void> loadItems() async {
    if (isBusy || !hasMore) return;
    setBusy(true);
    final newItems = await runBusyFuture(_assignmentService.get(
        query: AssignmentQueryModel(limit: limit, offset: offset)));

    items.addAll(newItems);
    offset += newItems.length;
    setBusy(false);
    notifyListeners();
    if (newItems.length < limit) hasMore = false;
  }
}
