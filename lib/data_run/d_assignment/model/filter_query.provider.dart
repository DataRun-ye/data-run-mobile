import 'package:datarunmobile/data_run/d_assignment/model/assignment_filter_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_query.provider.g.dart';

@riverpod
class FilterQuery extends _$FilterQuery {
  @override
  AssignmentFilterQuery build() {
    return AssignmentFilterQuery();
  }

  // Update the sorting parameter and order
  void updateSortBy(String? sortBy, {bool ascending = true}) {
    state = state.copyWith(sortBy: sortBy, ascending: ascending);
  }

  // Update the search query
  void updateSearchQuery(String searchQuery) {
    state = state.copyWith(searchQuery: searchQuery);
  }

  //
  void updateFilters(Map<String, dynamic> selectedFilters) {
    final updatedFilters = Map.of(state.filters);
    for (final entry in selectedFilters.entries) {
      if (entry.value == null ||
          (entry.value is Iterable && entry.value.isEmpty)) {
        updatedFilters.remove(entry.key); // Remove filter if null or empty
      } else {
        updatedFilters[entry.key] = entry.value; // Update or add filter
      }
    }
    state = state.copyWith(filters: updatedFilters);
  }

  // Update or add a filter
  void updateFilter(String filterKey, dynamic filterValue) {
    final updatedFilters = Map.of(state.filters);
    if (filterValue == null ||
        (filterValue is Iterable && filterValue.isEmpty)) {
      updatedFilters.remove(filterKey); // Remove filter if null or empty
    } else {
      updatedFilters[filterKey] = filterValue; // Update or add filter
    }
    state = state.copyWith(filters: updatedFilters);
  }

  // Remove a specific filter
  void removeFilter(String filterKey) {
    final updatedFilters = Map.of(state.filters)..remove(filterKey);
    state = state.copyWith(filters: updatedFilters);
  }

  // Clear all filters
  void clearAllFilters() {
    state = state.copyWith(filters: {}, sortBy: null, ascending: true);
  }

  // Toggle card/table view
  void toggleCardTableView([bool? isCardView]) {
    state = state.copyWith(
        isCardView: isCardView == null ? !state.isCardView : isCardView);
  }

// // Toggle card/table view
// void toggleCardTableView(bool isCardView) {
//   state = state.copyWith(isCardView: isCardView);
// }
}
