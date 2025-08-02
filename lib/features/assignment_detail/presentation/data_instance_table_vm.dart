import 'dart:async';

import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/datasource/util/submission_aggregator.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DataInstanceTableVm extends BaseViewModel {
  late SubmissionsFilter _filter;
  List<SubmissionSummary> _submissions = [];
  int _totalRowCount = 0;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  Set<String> selectedIds = {};

  late FormTemplateModel templateModel;

  List<SubmissionSummary> get submissions => _submissions;

  int get pageSize => _filter.pageSize;

  String get formId => _filter.formId;

  String? get assignmentId => _filter.assignmentId;

  int get totalRowCount => _totalRowCount;

  int get sortColumnIndex => _sortColumnIndex;

  bool get sortAscending => _sortAscending;

  InstanceSyncStatus? get currentSyncStateFilter => _filter.syncState;

  Set<String> get syncableSelectedIds => submissions
      .where((s) => selectedIds.contains(s.id))
      .where((s) => s.syncStatus.isFinalized)
      .map((s) => s.id)
      .toSet();

  final db = DSdk.db;

  void setParams(String formId, String? assignmentId) async {
    _filter = SubmissionsFilter(
        formId: formId,
        assignmentId: assignmentId,
        page: 0,
        pageSize: 10,
        paged: false);
  }

  void setPageSize(int pageSize) async {
    this._filter = _filter.copyWith(pageSize: pageSize);
    run();
  }

  /// Initialization
  Future<void> initialise() async {
    // setBusy(true);
    // templateModel = await appLocator<FormTemplateListService>()
    //     .getTemplateByVersionOrLatest(templateId: _filter.formId);
    // _filter = _filter.copyWith(page: 0);
    run();
  }

  Future<void> run() {
    return runBusyFuture(_futureToRun());
  }

  Future<void> _futureToRun() async {
    final PagedItems<SubmissionSummary> loaded =
        await appLocator<FormInstanceService>().fetchByFilter(_filter);
    _submissions.clear();
    _submissions.addAll(loaded.items);
    _totalRowCount = loaded.totalCount;
  }

  // New method to apply the sync status filter.
  void filterBySyncState(InstanceSyncStatus? newSyncState) {
    // If the filter is already set to this value, do nothing.
    if (_filter.syncState == newSyncState) return;

    _filter = _filter.copyWith(
      syncState: newSyncState,
      page: 0,
    );

    run();
  }

  void onPageChanged(int firstRowIndex) {
    _filter = _filter.copyWith(page: firstRowIndex ~/ _filter.pageSize);
    run();
  }

  // The new, robust sorting method
  void sort(String sortColumnName, int columnIndex, bool ascending) {
    // Check if the sort column has changed
    if (_filter.sortColumn != sortColumnName) {
      // If so, set the new column and sort order
      _filter = _filter.copyWith(
          sortColumn: sortColumnName, sortAscending: ascending);
    } else {
      // If the column is the same, just toggle the sort order
      _filter = _filter.copyWith(sortAscending: ascending);
    }

    _sortAscending = _filter.sortAscending;
    _sortColumnIndex = columnIndex;

    // Trigger a new stream with the updated filter.
    // This is the key to fetching sorted data from the database.
    run();
  }

  // Selection
  void toggleSelection(String id) {
    if (selectedIds.contains(id))
      selectedIds.remove(id);
    else
      selectedIds.add(id);
    notifyListeners();
  }

  // Sync
  Future<void> syncSelected() async {
    if (selectedIds.isEmpty) return;
    setBusy(true);
    await DSdk.db.dataInstancesDao.upload(selectedIds.toList());
    setBusy(false);
    notifyListeners();
  }

  // Delete/Restore
  Future<void> delete(String id) async {
    await db.dataInstancesDao.deleteById(id);
    // reload current page
    run();
    // await _loadPage(_formId!, _assignmentId, page: currentPage);
  }

  String getLabelString(Map<String, dynamic> label,
      {String? defaultValue = ''}) {
    return getItemLocalString(label, defaultString: defaultValue);
  }

  void addNewInstance(String formId, String? assignmentId) async {
    await appLocator<NavigationService>().navigateToFormFlowBootstrapper(
        formId: formId, assignmentId: assignmentId);
    run();
  }

  void editInstance(SubmissionSummary submission) async {
    await appLocator<NavigationService>().navigateToFormFlowBootstrapper(
      formId: submission.form.id,
      versionId: submission.formVersionId,
      assignmentId: submission.assignment,
      submissionId: submission.id,
    );
    await run();
  }

  Future<void> sync(List<String> ids) async {
    await appLocator<SubmissionListAggregator>().syncEntities(ids);
    await run();
    // appLocator<NavigationService>().back();
  }
}
