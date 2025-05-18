import 'package:d_sdk/database/dbManager.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked/stacked.dart';

class AssignmentListViewModel extends BaseViewModel {
  AssignmentListViewModel({this.activityId, this.pageSize = 20});

  String _searchTerm = '';
  final String? activityId;
  final int pageSize;

  late final pagingController = PagingController<int, AssignmentModel>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) => _fetchAssignments(
      page: pageKey,
      pageSize: pageSize,
    ),
  );

  Future<List<AssignmentModel>> _fetchAssignments(
      {String? activity, int page = 0, int pageSize = 20}) {
    final db = appLocator<DbManager>().db;

    return db.assignmentsDao
        .watchAssignmentCardsForActivity(
            activityId: activity,
            ouSearchFilter: _searchTerm,
            page: page,
            pageSize: pageSize)
        .get();
  }

  void updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    pagingController.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }
}
