import 'dart:io';

import 'package:equatable/equatable.dart';

class FilterQuery with EquatableMixin {
  FilterQuery({
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

  FilterQuery removeFilter(String key) =>
      copyWith(filters: {...filters..remove(key)});

  FilterQuery addFilter(String key, dynamic value) =>
      copyWith(filters: {...filters..[key] = value});

  FilterQuery copyWith({
    String? searchQuery,
    Map<String, dynamic>? filters,
    String? sortBy,
    bool? ascending,
    bool? isCardView,
  }) {
    return FilterQuery(
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
