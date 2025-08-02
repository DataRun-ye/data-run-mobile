import 'package:d_sdk/core/utilities/date_helper.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/data_instance_table_vm.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/action_cell.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/date_cell.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/status_cell.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/submission_table_cell.dart';
import 'package:flutter/material.dart';

class DataInstancesTableDatasource extends DataTableSource {
  DataInstancesTableDatasource({
    required this.vm,
    required this.templateModel,
    this.onEdit,
    this.onFailedSyncClicked,
    this.onDelete,
  });

  final DataInstanceTableVm vm;
  final FormTemplateModel templateModel;
  final Function(SubmissionSummary submission)? onEdit;
  final Function(SubmissionSummary submission)? onDelete;
  final Function(SubmissionSummary submission)? onFailedSyncClicked;

  @override
  DataRow getRow(int index) {
    final d = vm.submissions[index];
    final selected = vm.selectedIds.contains(d.id);
    return DataRow2(
      selected: selected,
      onSelectChanged: (_) => vm.toggleSelection(d.id),
      cells: [
        _getStatusCell(d),
        _getEditCell(d),
        _getDeleteCell(d),
        ..._getFieldsCells(d),
        ..._getDateCells(d),
      ],
    );
  }

  DataCell _getStatusCell(SubmissionSummary d) {
    return DataCell(StatusCell(
        syncState: d.syncStatus,
        onTap: d.syncStatus.isSyncFailed
            ? () => onFailedSyncClicked?.call(d)
            : null));
  }

  DataCell _getEditCell(SubmissionSummary d) {
    return DataCell(ActionCell(
      onPressed: () => onEdit?.call(d),
      icon: Icon(Icons.edit_document),
    ));
  }

  List<DataCell> _getFieldsCells(SubmissionSummary d) {
    return templateModel.fields
        .where((f) => f.mainField)
        .map((f) => DataCell(Center(
          child: SubmissionTableCell(
                fieldValue: d.formData.get(f.name!),
              ),
        )))
        .toList();
  }

  DataCell _getDeleteCell(SubmissionSummary d) {
    return DataCell(ActionCell(
      onPressed: () => onDelete?.call(d),
      icon: Icon(Icons.delete, color: Colors.red,),
    ));
  }

  List<DataCell> _getDateCells(SubmissionSummary d) {
    return [
      DataCell(DateCell(
          date: d.createdDate != null
              ? DateHelper.formatForUi(d.createdDate!, includeTime: true)
              : null)),
      DataCell(DateCell(
          date: d.lastModifiedDate != null
              ? DateHelper.formatForUi(d.lastModifiedDate!, includeTime: true)
              : null)),
    ];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => vm.totalRowCount;

  @override
  int get selectedRowCount => vm.selectedIds.length;
}
