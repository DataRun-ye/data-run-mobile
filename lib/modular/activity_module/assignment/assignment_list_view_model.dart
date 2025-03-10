import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:stacked/stacked.dart';

// Assume you have an Assignment model defined elsewhere
class AssignmentListViewModel extends BaseViewModel {
  List<Assignment> assignments = [];
  String searchQuery = '';
  bool isLoading = false;

  Future<void> loadAssignments() async {
    isLoading = true;
    notifyListeners();
    // TODO: Fetch and assign the list of assignments
    isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    // Optionally filter assignments based on query
    notifyListeners();
  }
}
