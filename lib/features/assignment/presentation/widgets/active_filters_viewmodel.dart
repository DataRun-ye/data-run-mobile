import 'package:datarunmobile/data/assignment/model/filter_query_service.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/assignment/domain/models/filter_query.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ActiveFiltersViewModel extends BaseViewModel {
  final FilterQueryService _filterService = appLocator<FilterQueryService>();

  FilterQuery filterQuery = FilterQuery();

  Map<String, dynamic> get activeFilters => _filterService.filterQuery.filters;

  String get searchQuery => _filterService.filterQuery.searchQuery;

  bool get isCardView => _filterService.filterQuery.isCardView;

  // Use a TextEditingController if needed for the search field.
  final TextEditingController searchController = TextEditingController();
  final focusNode = FocusNode();

  void clearAllFilters() {
    _filterService.clearAll();
    notifyListeners();
  }

  void removeFilter(String key) {
    _filterService.removeFilter(key);
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _filterService.updateSearchQuery(query);
    searchController.text = query;
    notifyListeners();
  }

  void clearSearchQuery() {
    updateSearchQuery('');
  }

  void toggleCardTableView(bool value) {
    _filterService.toggleCardTableView(value);
    notifyListeners();
  }

  void updateFilters(Map<String, dynamic> newFilters) {
    _filterService.updateFilters(newFilters);
    notifyListeners();
  }

  void addFilter(String key, dynamic filter) {
    _filterService.addFilter(key, filter);
    notifyListeners();
  }
}
