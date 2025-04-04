import 'package:datarunmobile/ui/views/assignment/filter/filter_query.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilterQueryService {
  FilterQuery filterQuery = FilterQuery();

  void updateSearchQuery(String query) {
    filterQuery = filterQuery.copyWith(searchQuery: query);
  }

  void toggleCardTableView(bool value) {
    filterQuery = filterQuery.copyWith(isCardView: value);
  }

  void updateFilters(Map<String, dynamic> newFilters) {
    filterQuery = filterQuery.copyWith(filters: newFilters);
  }

  void clearAll() {
    filterQuery = FilterQuery();
  }

  void removeFilter(String key) {
    filterQuery = filterQuery.removeFilter(key);
  }

  void addFilter(String key, filter) {
    filterQuery = filterQuery.addFilter(key, filter);
  }
}
