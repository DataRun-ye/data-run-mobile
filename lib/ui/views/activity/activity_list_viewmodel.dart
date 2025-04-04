import 'package:datarunmobile/data/activity/activity.dart';
import 'package:stacked/stacked.dart';

class ActivityListViewModel extends BaseViewModel {
  List<ActivityModel> activities = [];
  int assignedCount = 0;
  String project = '';
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    // TODO: Fetch and assign the list of activities
    isLoading = false;
    notifyListeners();
  }

  void updateQuery(String query) {
    project = query;
    // Optionally filter assignments based on query
    notifyListeners();
  }
}
