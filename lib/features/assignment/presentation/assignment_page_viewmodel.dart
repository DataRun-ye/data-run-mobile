// import 'package:d_sdk/database/shared/assignment_model.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// class AssignmentPageViewModel extends BaseViewModel {
//   // final FilterQueryService _filterService = appLocator<FilterQueryService>();
//   // final AssignmentListService _assignmentService =
//   //     appLocator<AssignmentListService>();
//
//   List<AssignmentModel> items = [];
//
//   String get searchQuery => '_filterService.filterQuery.searchQuery';
//
//   bool get isCardView => true /*_filterService.filterQuery.isCardView*/;
//
//   Map<String, dynamic> get filters => {} /*_filterService.filterQuery.filters*/;
//
//   // Use a TextEditingController if needed for the search field.
//   final TextEditingController searchController = TextEditingController();
//   final focusNode = FocusNode();
//
//   Future<void> loadItems() async {
//     // if (isBusy || !hasMore) return;
//     setBusy(true);
//     // final newItems = await runBusyFuture(_assignmentService.get(
//     //     query: AssignmentQueryModel(/*limit: limit, offset: offset*/)));
//
//     // items.addAll(newItems);
//     // offset += newItems.length;
//     setBusy(false);
//     notifyListeners();
//     // if (newItems.length < limit) hasMore = false;
//   }
//
//   // Expose properties for binding:
//   void clearAllFilters() {
//     // _filterService.clearAll();
//     notifyListeners();
//   }
//
//   void removeFilter(String key) {
//     // _filterService.removeFilter(key);
//     notifyListeners();
//   }
//
//   void updateSearchQuery(String query) {
//     // _filterService.updateSearchQuery(query);
//     searchController.text = query;
//     notifyListeners();
//   }
//
//   void clearSearchQuery() {
//     updateSearchQuery('');
//   }
//
//   void toggleCardTableView(bool value) {
//     // _filterService.toggleCardTableView(value);
//     notifyListeners();
//   }
//
//   void updateFilters(Map<String, dynamic> newFilters) {
//     // _filterService.updateFilters(newFilters);
//     notifyListeners();
//   }
//
//   void addFilter(String key, dynamic filter) {
//     // _filterService.addFilter(key, filter);
//     notifyListeners();
//   }
//
//   // Navigation example using Stacked's NavigationService
//   // final NavigationService _navigationService = appLocator<NavigationService>();
//
//   void navigateToAssignmentDetails(AssignmentModel assignment) {
//     // _navigationService.navigateTo(
//     //   Routes.assignmentDetailPage,
//     //   arguments: AssignmentDetailPageArguments(assignment: assignment),
//     // );
//   }
//
//   // Optionally add methods to show bottom sheets (using Stacked dialogs)...
//   void showFilterBottomSheet(BuildContext context) {
//     // Wrap your existing filter bottom sheet logic into a separate widget or use a Stacked dialog.
//     // For brevity, we could delegate to a separate widget.
//   }
// }
