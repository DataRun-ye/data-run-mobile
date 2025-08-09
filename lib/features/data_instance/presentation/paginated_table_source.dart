import 'package:d_sdk/core/util/date_helper.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/data_instance/presentation/cell_widgets/edit_action_icon_cell.dart';
import 'package:datarunmobile/features/data_instance/presentation/cell_widgets/table_widgets.dart';
import 'package:flutter/material.dart';

typedef OnRowSelected = void Function(String itemId, bool? selected);

class PaginatedTableSource extends DataTableSource {
  PaginatedTableSource({
    required this.templateModel,
    this.disabledCellColor,
    this.onEdit,
    this.assignmentId,
    this.onFailedSyncClicked,
    this.onSelectedItem,
    this.isSelected,
  });

  List<SubmissionSummary> _data = [];
  final FormTemplateModel templateModel;
  final String? assignmentId;
  final Function(SubmissionSummary submission)? onEdit;
  final Function(SubmissionSummary submission)? onFailedSyncClicked;
  final Function(String submission)? onSelectedItem;
  final bool Function(String submission)? isSelected;
  final WidgetStateProperty<Color?>? disabledCellColor;

  List<String> _selectedItems = [];

  int get _selectedCount => _selectedItems.length;
  int _totalRowCount = 0;
  int _offset = 0;

  /// A helper to update your backing data and notify the table
  void update({
    required List<SubmissionSummary> pageData,
    required int total,
    required int offset,
  }) {
    _data = pageData;
    _totalRowCount = total;
    _offset = offset;
    notifyListeners();
  }

  /// A helper to update backing data and notify the table
  void updateSelectedItems({required List<String> ids}) {
    _selectedItems = ids;
    notifyListeners();
  }

  /// Called by PaginatedDataTable to know how many rows exist
  @override
  int get rowCount => _totalRowCount;

  /// We know exactly how many: no “approximate”
  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  @override
  DataRow? getRow(int index) {
    final local = index - _offset;
    if (local < 0 || local >= _data.length) {
      return null;
    }
    final item = _data[local];
    return DataRow.byIndex(
      color:
          item.deleted && disabledCellColor != null ? disabledCellColor : null,
      index: item.id.hashCode,
      selected: isSelected?.call(item.id) ?? false,
      onSelectChanged: (selected) => onSelectedItem?.call(item.id),
      cells: [
        _getStatusCell(item),
        _getEditCell(item),
        ..._getFieldsCells(item),
        ..._getDateCells(item),
      ],
    );
  }

  DataCell _getStatusCell(SubmissionSummary d) {
    return DataCell(StatusCell(
        id: d.id,
        onTap: d.syncStatus.isSyncFailed
            ? () => onFailedSyncClicked?.call(d)
            : null));
  }

  DataCell _getEditCell(SubmissionSummary d) {
    return DataCell(EditActionIconCell(
      onPressed: () => onEdit?.call(d),
      submissionId: d.id,
    ));
  }

  List<DataCell> _getFieldsCells(SubmissionSummary d) {
    return templateModel.fields
        .where((f) => f.mainField)
        .map((f) => DataCell(Center(
              child: SubmissionTableCell(
                fieldValue: d.formData.get(f.path!),
              ),
            )))
        .toList();
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
}
