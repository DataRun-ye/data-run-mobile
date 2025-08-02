import 'package:d_sdk/database/shared/status_aggregation_level.dart';
import 'package:d_sdk/database/shared/submission_card_summary.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/custom_widgets/exception_indicators/empty_list_indicator.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/data_instance_table_vm.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/data_instances_table_datasource.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/table_header_label.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/submission_sync_dialog.widget.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DataInstancesTableView extends ViewModelWidget<DataInstanceTableVm> {
  const DataInstancesTableView({super.key});

  @override
  Widget build(BuildContext context, DataInstanceTableVm vm) {
    if (vm.isBusy) return const Center(child: CircularProgressIndicator());

    final syncableSelectedIds = vm.syncableSelectedIds;
    final minTableWidth = (_buildColumns(vm).length * 150.0);
    return PaginatedDataTable2(
      fixedTopRows: 1,
      empty: EmptyListIndicator(
        message: S.of(context).addAnItem,
      ),
      showFirstLastButtons: true,
      actions: [
        if (syncableSelectedIds.length > 0)
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                  onPressed: syncableSelectedIds.isNotEmpty
                      ? () async {
                          await _showSyncDialog(
                              context, syncableSelectedIds, vm);
                        }
                      : null,
                  icon: const Icon(
                    Icons.cloud_upload_sharp,
                    color: Colors.green,
                  ),
                  label: Text(
                      '${S.of(context).syncSubmissions(syncableSelectedIds.length)}')),
              if (vm.selectedIds.isNotEmpty)
                ElevatedButton.icon(
                    onPressed: vm.selectedIds.isNotEmpty
                        ? () async {
                            await _showSyncDialog(
                                context, syncableSelectedIds, vm);
                          }
                        : null,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    label: Text(
                        '${S.of(context).deleteSelected(syncableSelectedIds.length)}'))
            ],
          )
      ],
      header: SyncStatusBadgesView(
          id: vm.formId,
          aggregationLevel: StatusAggregationLevel.form,
          assignmentId: vm.assignmentId),
      sortColumnIndex: vm.sortColumnIndex,
      sortAscending: vm.sortAscending,
      rowsPerPage: vm.pageSize,
      // initialFirstRowIndex: vm.currentPage * vm.pageSize,
      availableRowsPerPage: <int>[
        vm.pageSize,
        vm.pageSize * 2,
        vm.pageSize * 5,
        vm.pageSize * 10
      ],
      onRowsPerPageChanged: (rows) {
        if (rows != null) {
          vm.setPageSize(rows);
        }
      },
      onPageChanged: vm.onPageChanged,
      columns: _buildColumns(vm),
      source: DataInstancesTableDatasource(
        vm: vm,
        onEdit: (s) {
          vm.editInstance(s);
        },
        onFailedSyncClicked: (s) {},
        templateModel: vm.templateModel,
        onDelete: (SubmissionSummary s) {
          appLocator<ConfirmationService>().confirmAndExecute(
              context: context,
              title: S.of(context).confirm,
              body: S.of(context).deleteConfirmationMessage,
              confirmLabel: S.of(context).deleteConfirmationMessage,
              action: () {
                vm.delete(s.id);
                // _deleteAndShowUndoSnack(context, s.id);
              });
        },
      ),
      showCheckboxColumn: vm.syncableSelectedIds.isNotEmpty,
      minWidth: minTableWidth,
      columnSpacing: 12,
      // A smaller spacing
      horizontalMargin: 12,
      // Margin between the table edges and content
      dataRowHeight: 60, // A good height for your content
      // columnSpacing: 16,
    );
  }

  List<DataColumn> _buildColumns(DataInstanceTableVm vm) {
    return [
      _getStatusColumn(vm),
      _getEditColumn(vm),
      _getDeleteColumn(vm),
      ..._getDynamicFormFields(vm),
      ..._getDatesColumn(vm),
    ];
  }

  List<DataColumn> _getDynamicFormFields(DataInstanceTableVm vm) {
    return vm.templateModel.fields
        .where((f) => f.mainField)
        .map(
          (f) => DataColumn2(
              label: TableHeaderLabel(
                  label:
                      vm.getLabelString(f.label.unlock, defaultValue: f.name)),
              numeric: f.type?.isNumeric == true,
              size: ColumnSize.M),
        )
        .toList();
  }

  DataColumn _getStatusColumn(DataInstanceTableVm vm) {
    return DataColumn2(
      label: TableHeaderLabel(label: S.current.status),
      onSort: (i, asc) => vm.sort('syncStatus', i, asc),
      size: ColumnSize.S,
      fixedWidth: 70,
    );
  }

  DataColumn _getEditColumn(DataInstanceTableVm vm) {
    return DataColumn2(
      label: TableHeaderLabel(label: S.current.edit),
      size: ColumnSize.S,
      fixedWidth: 80,
    );
  }

  DataColumn _getDeleteColumn(DataInstanceTableVm vm) {
    return DataColumn2(
      label: TableHeaderLabel(label: S.current.delete),
      size: ColumnSize.S,
      fixedWidth: 50,
    );
  }

  List<DataColumn> _getDatesColumn(DataInstanceTableVm vm) {
    return [
      DataColumn2(
        label: TableHeaderLabel(label: S.current.created),
        onSort: (i, asc) => vm.sort('createdDate', i, asc),
        size: ColumnSize.M,
      ),
      DataColumn2(
        label: TableHeaderLabel(label: S.current.modified),
        onSort: (i, asc) => vm.sort('lastModifiedDate', i, asc),
        size: ColumnSize.M,
      ),
    ];
  }

  Future<void> _goToDataEntryForm(
      BuildContext context, SubmissionSummary submission) async {}

  Future<void> _showSyncDialog(BuildContext context, Set<String> entityIds,
      DataInstanceTableVm vm) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog(
          entityIds: entityIds.toList(),
          syncEntity: (ids) async {
            if (ids != null) {
              await vm.sync(ids);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
        );
      },
    );
  }

// void _deleteAndShowUndoSnack(BuildContext context, String toDeleteId) {
//   final scaffoldMessenger = ScaffoldMessenger.of(context);
//   scaffoldMessenger.showSnackBar(
//     SnackBar(
//       content: Text(S.of(context).itemRemoved),
//       action: SnackBarAction(
//         label: S.of(context).undo,
//         onPressed: () {
//           // appLocator<SubmissionsTableService>().deleteInstance(toDeleteId);
//           // listSubmissionsNotifier.deleteSubmission([toDeleteId]);
//         },
//       ),
//     ),
//   );
// }
}
