import 'dart:io';

import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/features/activity/application/activity.provider.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_filter.provider.g.dart';

/// filters the list of assignment by certain
@Riverpod(dependencies: [activityModel, Assignments])
Future<List<AssignmentModel>> filterAssignments(Ref ref) async {
  final assignments = await ref.watch(assignmentsProvider.future);
  final query = ref.watch(filterQueryProvider);
  final teamsAsync = await ref.watch(teamsProvider().future);
  final lowerCaseQuery = query.searchQuery.toLowerCase();
  assignments.sort((a, b) => (a.startDay ?? 11).compareTo((b.startDay ?? 11)));
  final filteredAssignments = assignments.where((assignment) {
    for (var entry in query.filters.entries) {
      final key = entry.key;
      final value = entry.value;

      final selectedTeams = teamsAsync
          .where((t) =>
              key == 'teams' &&
              value is Iterable &&
              value.isNotEmpty &&
              value.contains(t.name))
          .map((t) => t.id)
          .toList();

      if (key == 'status' &&
          value is Iterable &&
          value.isNotEmpty &&
          (!value.contains(assignment.status))) {
        return false;
      }
      // TODO add date range
      if (key == 'days' &&
          value is Iterable &&
          value.isNotEmpty &&
          (assignment.startDay == null ||
              !value.contains(assignment.startDay))) {
        return false;
      }

      if (key == 'teams' &&
          value is Iterable &&
          value.isNotEmpty &&
          (!selectedTeams.contains(assignment.team.id))) {
        return false;
      }
    }
    //   if (key == 'status' && assignment.status != value) {
    //     return false;
    //   }
    //   if (key == 'scope' && assignment.scope != value) {
    //     return false;
    //   }
    //   if (key == 'days' &&
    //       value is Iterable &&
    //       value.isNotEmpty &&
    //       (assignment.startDay == null ||
    //           !value.contains(assignment.startDay))) {
    //     return false;
    //   }
    //   if (key == 'teams' &&
    //       value is Iterable &&
    //       value.isNotEmpty &&
    //       (!value.contains(assignment.teamId))) {
    //     return false;
    //   }
    // }

    if (query.searchQuery.isNotEmpty) {
      final lowerCaseActivity = assignment.activity?.name.toLowerCase() ?? '';
      final lowerCaseEntityCode = assignment.orgUnit.code?.toLowerCase() ?? '';
      final lowerCaseEntityName = assignment.orgUnit.name.toLowerCase();
      final lowerCaseTeamName = assignment.team.name.toLowerCase();

      if (!lowerCaseActivity.contains(lowerCaseQuery) &&
          !lowerCaseEntityCode.contains(lowerCaseQuery) &&
          !lowerCaseEntityName.contains(lowerCaseQuery) &&
          !lowerCaseTeamName.contains(lowerCaseQuery)) {
        return false;
      }
    }

    return true;
  }).toList();

  // Apply sorting
  if (query.sortBy != null) {
    filteredAssignments.sort((a, b) {
      final aValue = _getAssignmentFieldValue(a, query.sortBy!);
      final bValue = _getAssignmentFieldValue(b, query.sortBy!);

      if (aValue == null || bValue == null) return 0;
      return query.ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  return filteredAssignments;
}

// Helper function to get field values dynamically
dynamic _getAssignmentFieldValue(AssignmentModel assignment, String field) {
  switch (field) {
    case 'dueDate':
      return assignment.dueDate;
    case 'status':
      return assignment.status.index; // Assuming `AssignmentStatus` is an enum
    case 'teamName':
      return assignment.team.code;
    // Add more fields as needed
    default:
      return null;
  }
}

/// filter query model notifier that store filtering cretirias
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

class AssignmentFilterQuery with EquatableMixin {
  AssignmentFilterQuery({
    this.searchQuery = '',
    Map<String, dynamic>? filters,
    this.sortBy,
    this.ascending = true,
    bool? isCardView,
  })  : filters = filters ?? {},
        this.isCardView = isCardView ?? Platform.isAndroid;

  final String searchQuery;
  final Map<String, dynamic> filters;
  final String? sortBy; // Sorting field, e.g., "dueDate"
  final bool ascending; // Sorting order
  final bool isCardView;

  bool get hasFilters => filters.isNotEmpty || searchQuery.isNotEmpty;

  AssignmentFilterQuery copyWith({
    String? searchQuery,
    Map<String, dynamic>? filters,
    String? sortBy,
    bool? ascending,
    bool? isCardView,
  }) {
    return AssignmentFilterQuery(
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      isCardView: isCardView ?? this.isCardView,
    );
  }

  @override
  List<Object?> get props =>
      [searchQuery, filters, sortBy, ascending, isCardView];
}
