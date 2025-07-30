// import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
// import 'package:d_sdk/d_sdk.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:datarunmobile/app/di/injection.dart';
// import 'package:datarunmobile/data/form_template_list_service.dart';
// import 'package:datarunmobile/features/form/application/form_template_model.dart';
// import 'package:drift/src/runtime/query_builder/query_builder.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:stacked/stacked.dart';
//
// class DetailSubmissionsViewModel extends BaseViewModel {
//   DetailSubmissionsViewModel();
//
//   // Pagination state
//   int currentPage = 0;
//   int pageSize = 5;
//   int totalCount = 0;
//
//   //
//
//   FormTemplateModel? formTemplateModel;
//
//   // Data & state
//   List<SubmissionSummary> _submissions = [];
//
//   List<SubmissionSummary> get submissions => _submissions;
//
//   Set<String> selectedIds = {};
//
//   Set<String> get syncableSelectedIds => submissions
//       .where((s) => selectedIds.contains(s.id))
//       .where((s) => s.syncStatus.isFinalized)
//       .map((s) => s.id)
//       .toSet();
//
//   int? sortColumnIndex;
//   bool sortAscending = true;
//
//   final IMap<String, GeneratedColumn<Object>> colsMap = IMap.fromIterable(
//       DSdk.db.dataInstances.$columns,
//       keyMapper: (c) => c.name,
//       valueMapper: (c) => c);
//
//   final templateService = appLocator<FormTemplateListService>();
//   final db = DSdk.db;
//
//   /// Initialization
//   Future<void> initialise(String formId, String? assignmentId) async {
//     setBusy(true);
//     formTemplateModel =
//         await templateService.getTemplateByVersionOrLatest(templateId: formId);
//     await _loadPage(formId, assignmentId, page: 0);
//     setBusy(false);
//   }
//
//   void setPageSize(int pageSize) async {
//     this.pageSize = pageSize;
//     await _loadPage(_formId!, _assignmentId, page: 0);
//   }
//
//   Future<void> _loadPage(
//     String formId,
//     String? assignmentId, {
//     required int page,
//   }) async {
//     setBusy(true);
//     currentPage = page;
//     // total number of matching rows
//
//     var query =
//         db.managers.dataInstances.filter((f) => f.formTemplate.id(formId));
//     if (assignmentId != null) {
//       query = query..filter((f) => f.assignment.id(assignmentId));
//     }
//     totalCount = await query.count();
//
//     final loaded = await db.dataInstancesDao
//         .selectSubmissions(
//           formId,
//           filter: SubmissionsFilter(assignment: assignmentId),
//           page: page,
//           pageSize: pageSize,
//         )
//         .get();
//     _submissions.addAll(loaded);
//     setBusy(false);
//     notifyListeners();
//   }
//
//   // Sorting
//   void sort<T>(Comparable<T> Function(SubmissionSummary d) getField,
//       int columnIndex, bool ascending) {
//     _submissions.sort((a, b) {
//       final aVal = getField(a);
//       final bVal = getField(b);
//       return ascending
//           ? Comparable.compare(aVal, bVal)
//           : Comparable.compare(bVal, aVal);
//     });
//     sortColumnIndex = columnIndex;
//     sortAscending = ascending;
//     notifyListeners();
//   }
//
//   // Pagination callback
//   void onPageChanged(int rowIndex) async {
//     final newPage = rowIndex ~/ pageSize;
//     if (newPage != currentPage && submissions.length <= rowIndex) {
//       // pass in formId and assignmentId as stored or via params
//       await _loadPage(_formId!, _assignmentId, page: newPage);
//     }
//   }
//
//   // Selection
//   void toggleSelection(String id) {
//     if (selectedIds.contains(id))
//       selectedIds.remove(id);
//     else
//       selectedIds.add(id);
//     notifyListeners();
//   }
//
//   // Sync
//   Future<void> syncSelected() async {
//     if (selectedIds.isEmpty) return;
//     setBusy(true);
//     await DSdk.db.dataInstancesDao.upload(selectedIds.toList());
//     setBusy(false);
//     // reload current page to reflect sync changes
//     await _loadPage(_formId!, _assignmentId, page: currentPage);
//   }
//
//   // Delete/Restore
//   Future<void> delete(String id) async {
//     await db.dataInstancesDao.deleteById(id);
//     // reload current page
//     await _loadPage(_formId!, _assignmentId, page: currentPage);
//   }
//
//   // Internal to store params for reload
//   String? _formId;
//   String? _assignmentId;
//
//   void setParams(String formId, String? assignmentId) {
//     _formId = formId;
//     _assignmentId = assignmentId;
//   }
//
//   String getLabelString(Map<String, dynamic> label,
//       {String? defaultValue = ''}) {
//     return getItemLocalString(label, defaultString: defaultValue);
//   }
// }
