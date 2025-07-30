// import 'package:d_sdk/core/form/element_template/template.dart';
// import 'package:d_sdk/database/shared/status_aggregation_level.dart';
// import 'package:d_sdk/database/shared/submission_card_summary.dart';
// import 'package:datarunmobile/features/assignment_detail/presentation/submission_table_datasource.dart';
// import 'package:datarunmobile/features/assignment_detail/presentation/submission_table_viewmodel.dart';
// import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
// import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart';
// import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
// import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:stacked/stacked.dart';
//
// class DetailSubmissionsView extends StackedView<DetailSubmissionsViewModel> {
//   const DetailSubmissionsView({
//     super.key,
//     required this.formId,
//     this.assignmentId,
//   });
//
//   final String formId;
//   final String? assignmentId;
//
//   @override
//   Widget builder(
//       BuildContext context, DetailSubmissionsViewModel vm, Widget? child) {
//     if (vm.isBusy) return const Center(child: CircularProgressIndicator());
//     return PaginatedDataTable(
//       dragStartBehavior: DragStartBehavior.down,
//       primary: true,
//       showFirstLastButtons: true,
//       actions: [
//         ElevatedButton(
//           onPressed: vm.syncableSelectedIds.length > 0
//               ? () async {
//                   // final repeatItem =
//                   // formInstance.onAddRepeatedItem(_repeatInstance);
//                   // _dataSource.addItem(repeatItem);
//                   // await _showEditPanel(context, formInstance, repeatItem);
//                 }
//               : null,
//           child: const Icon(Icons.cloud_upload_sharp),
//         ),
//       ],
//       header: SyncStatusBadgesView(
//           id: formId,
//           aggregationLevel: StatusAggregationLevel.form,
//           assignmentId: assignmentId),
//       sortColumnIndex: vm.sortColumnIndex,
//       sortAscending: vm.sortAscending,
//       rowsPerPage: vm.pageSize,
//       // initialFirstRowIndex: vm.currentPage * vm.pageSize,
//       availableRowsPerPage: <int>[
//         vm.pageSize,
//         vm.pageSize * 2,
//         vm.pageSize * 5,
//         vm.pageSize * 10
//       ],
//       onRowsPerPageChanged: (rows) {
//         if (rows != null) {
//           vm.setPageSize(rows);
//         }
//       },
//       onPageChanged: vm.onPageChanged,
//       columns: _buildColumns(vm),
//       source: SubmissionDataSource(
//         vm: vm,
//         onEdit: (s) {
//           _goToDataEntryForm(context, s);
//         },
//         onFailedSyncClicked: (s) {},
//         onDelete: (s) {},
//       ),
//       showCheckboxColumn: true,
//       columnSpacing: 16,
//     );
//   }
//
//   @override
//   DetailSubmissionsViewModel viewModelBuilder(BuildContext context) {
//     final vm = DetailSubmissionsViewModel();
//     vm.setParams(formId, assignmentId);
//     // vm.initialise(formId, assignmentId);
//     return vm;
//   }
//
//   @override
//   void onViewModelReady(DetailSubmissionsViewModel viewModel) =>
//       SchedulerBinding.instance.addPostFrameCallback(
//           (timeStamp) => viewModel.initialise(formId, assignmentId));
//
//   List<DataColumn> _buildColumns(DetailSubmissionsViewModel vm) {
//     return [
//       _getStatusColumn(vm),
//       _getEditColumn(vm),
//       ..._getDynamicFormFields(vm),
//       ..._getDatesColumn(vm),
//       _getDeleteColumn(vm)
//     ];
//   }
//
//   List<DataColumn> _getDynamicFormFields(DetailSubmissionsViewModel vm) {
//     return (vm.formTemplateModel?.fields ?? <Template>[])
//         .where((f) => f.mainField)
//         .map((f) => DataColumn(
//             label:
//                 Text(vm.getLabelString(f.label.unlock, defaultValue: f.name)),
//             numeric: f.type?.isNumeric == true))
//         .toList();
//   }
//
//   DataColumn _getStatusColumn(DetailSubmissionsViewModel vm) {
//     return DataColumn(
//       label: Text(S.current.status),
//       onSort: (i, asc) =>
//           vm.sort<String>((SubmissionSummary d) => d.syncStatus.name, i, asc),
//     );
//   }
//
//   DataColumn _getEditColumn(DetailSubmissionsViewModel vm) {
//     return DataColumn(label: Text(S.current.edit));
//   }
//
//   DataColumn _getDeleteColumn(DetailSubmissionsViewModel vm) {
//     return DataColumn(label: Text(S.current.delete));
//   }
//
//   List<DataColumn> _getDatesColumn(DetailSubmissionsViewModel vm) {
//     return [
//       DataColumn(
//         label: Text(S.current.created),
//         onSort: (i, asc) => vm.sort<DateTime>((d) => d.createdDate!, i, asc),
//       ),
//       DataColumn(
//         label: Text(S.current.modified),
//         onSort: (i, asc) =>
//             vm.sort<DateTime>((d) => d.lastModifiedDate!, i, asc),
//       ),
//     ];
//   }
//
//   Future<void> _goToDataEntryForm(
//       BuildContext context, SubmissionSummary submission) async {
//     await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => FormMetadataWidget(
//                   formMetadata: FormMetadata(
//                     assignmentId: submission.assignment!,
//                     versionUid: submission.formVersionId,
//                     formId: submission.form.id,
//                     submission: submission.id,
//                   ),
//                   child: const FormSubmissionScreen(currentPageIndex: 1),
//                 )));
//   }
// }
