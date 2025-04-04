import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
import 'package:datarunmobile/data/assignment/model/assignment_list.service.dart';
import 'package:datarunmobile/data/assignment/repository/assignment_query_model.dart';
import 'package:datarunmobile/ui/views/assignment/filter/filter_query.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssignmentPageService {
  AssignmentPageService({required AssignmentListService assignmentListService})
      : _assignmentListService = assignmentListService;

  final AssignmentListService _assignmentListService;

  List<AssignmentModelNew> items = [];

  Future<void> loadNextPage({FilterQuery? filterQuery}) async {
    final result =
        await _assignmentListService.get(query: AssignmentQueryModel());

    items.addAll(result);
    // notifyListeners();
  }
}
