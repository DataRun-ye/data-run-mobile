import 'dart:async';

import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_selection_list_controller.g.dart';

@riverpod
class AssignmentSelectionListController
    extends _$AssignmentSelectionListController {
  // final _debounce = Debounce(Duration(milliseconds: 500));
  // final ScrollController _scrollController = ScrollController();
  // String _currentFilter = '';

  @override
  Future<PagingState<int, AssignmentModel>> build(
      {String? activity, int pageSize = 20}) async {
    // final db = appLocator<DbManager>().db;

    // final itemsAsyncValue = await AsyncValue.guard(() => _fetchAssignments(
    //       activity: activity,
    //       page: 0,
    //       pageSize: pageSize,
    //     ));
    //
    // if (itemsAsyncValue.hasError) {
    //   return PagingState(isLoading: false, error: itemsAsyncValue.error);
    // }
    final List<AssignmentModel> items = await _fetchAssignments(
      activity: activity,
      page: 0,
      pageSize: pageSize,
    );

    PagingState<int, AssignmentModel> paginatedList = PagingState(
      pages: [items],
      keys: [0],
      hasNextPage: !items.isEmpty, // (items.length < pageSize),
      isLoading: false,
    );

    return paginatedList;
  }

  Future<List<AssignmentModel>> _fetchAssignments(
      {String? activity, int page = 0, int pageSize = 20, bool reset = false}) {
    final db = appLocator<DbManager>().db;

    return db.assignmentsDao.selectAssignments(activityId: activity).get();
  }

  Future<void> _loadMore() async {
    // state = await AsyncValue.guard(() async {
    //   final current = state.value!;
    //   final nextPage = await GetIt.I
    //       .get<AssignmentsService>()
    //       .getPaginatedAssignments(
    //           filter: _currentFilter, page: current.page + 1);
    //   return current.copyWith(
    //     items: [...current.items, ...nextPage.items],
    //     hasMore: nextPage.hasMore,
    //     page: nextPage.page,
    //   );
    // });
  }

  String _currentFilter = '';

  Timer? _debounce;

  void onSearchChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _currentFilter = text;
      // _pagingController.refresh();
    });
  }

  void handleFilterChange(String filter) {
    // _currentFilter = filter;
    // _debounce?.run(() => state = AsyncValue.loading()
    //     .copyWithPrevious(state)
    //     .whenData((_) => _fetchAssignments(reset: true)));
  }

// @override
// void dispose() {
//   _scrollController.dispose();
//   _debounce.dispose();
//   super.dispose();
// }
}
