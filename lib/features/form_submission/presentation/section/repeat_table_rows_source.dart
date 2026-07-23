import 'dart:collection';

import 'package:datarunmobile/core/util/date_helper.dart';
import 'package:datarunmobile/database/shared/assignment_status.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form/presentation/widgets/value_type_value_display.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RepeatTableDataSource extends DataTableSource {
  RepeatTableDataSource(
      {this.onDelete,
      this.onEdit,
      this.onSelectionChanged,
      this.editable = true,
      // required this.activityModel,
      List<RepeatItemInstance> elements = const []}) {
    _elements.addAll(elements);
  }

  void replaceItems(List<RepeatItemInstance> items) {
    final previousSelectedCount = _selectedItems.length;
    _elements
      ..clear()
      ..addAll(items);
    _selectedItems.removeWhere(
      (selected) => !_elements.any((item) => identical(item, selected)),
    );
    notifyListeners();
    if (_selectedItems.length != previousSelectedCount) {
      onSelectionChanged?.call();
    }
  }

  final ValueChanged<RepeatItemInstance>? onDelete;
  final ValueChanged<RepeatItemInstance>? onEdit;
  final VoidCallback? onSelectionChanged;
  final List<RepeatItemInstance> _elements = [];
  final Set<RepeatItemInstance> _selectedItems = HashSet.identity();
  List<RepeatItemInstance> get elements => List.unmodifiable(_elements);
  List<RepeatItemInstance> get selectedItems => List.unmodifiable(
        _elements.where(_selectedItems.contains),
      );
  bool editable;

  void _setSelected(RepeatItemInstance item, bool selected) {
    final changed =
        selected ? _selectedItems.add(item) : _selectedItems.remove(item);
    if (!changed) {
      return;
    }
    _notifySelectionChanged();
  }

  void setSelectedRange(int start, int count, bool selected) {
    var changed = false;
    for (var index = start;
        index >= 0 && index < start + count && index < _elements.length;
        index++) {
      changed = (selected
              ? _selectedItems.add(_elements[index])
              : _selectedItems.remove(_elements[index])) ||
          changed;
    }
    if (!changed) {
      return;
    }
    _notifySelectionChanged();
  }

  void _notifySelectionChanged() {
    notifyListeners();
    onSelectionChanged?.call();
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _elements.length) return null;

    final repeatItem = _elements[index];
    final Iterable<FieldInstance<dynamic>> rowFields =
        getFormElementIterator<FieldInstance<dynamic>>(_elements[index])
            .where((field) => field.parentSection == repeatItem);

    final rowFieldsStates = rowFields.map((field) => field).toList();

    return DataRow.byIndex(
        index: index,
        selected: _selectedItems.contains(repeatItem),
        onSelectChanged: editable
            ? (selected) => _setSelected(repeatItem, selected ?? false)
            : null,
        cells: [
          DataCell(Text('${index + 1}')),
          ...rowFieldsStates
              .map((field) => DataCell(userFriendlyValue(field)))
              .toList(),
          if (editable)
            DataCell(IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  onEdit?.call(repeatItem);
                })),
          if (editable)
            DataCell(IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: editable
                    ? () {
                        onDelete?.call(repeatItem);
                      }
                    : null)),
        ]);
  }

  Widget userFriendlyValue(FieldInstance<dynamic> field) {
    final value = field.value ?? '-';

    if (field.hasErrors == true) {
      return Text(
        '$value! ${S.current.fieldContainErrors}',
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    }

    if (field.hidden) {
      return Container(
        color: Colors.grey.shade300,
        // Light grey background for the entire cell
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '    '.toString(),
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    Widget cellContent;

    switch (field.type) {
      case ValueType.ScannedCode:
        cellContent = Row(
          children: [
            Icon(MdiIcons.barcode),
            const SizedBox(width: 4),
            Text(field.value?.toString().substring(0, 10) ?? '-'),
          ],
        );
        break;
      case ValueType.Progress:
        cellContent = field.value != null
            ? Row(
                children: [
                  buildStatusBadge(AssignmentStatus.getType(field.value)!),
                  const SizedBox(width: 4),
                  Text(field.value ?? ''),
                ],
              )
            : Text('${field.value ?? '-'}');
      case ValueType.Team:
        cellContent = Row(
          children: [
            Icon(MdiIcons.accountGroup),
            const SizedBox(width: 4),
            ValueTypeValueDisplay(
              valueType: field.template.type,
              value: field.value,
            )
          ],
        );
        break;

      case ValueType.Date:
      case ValueType.DateTime:
      case ValueType.Time:
        final viewFormat = DateHelper.getEffectiveUiFormat(field.type, 'en_US');
        final pickedValue = DateTime.tryParse(field.value ?? '');
        final value =
            pickedValue != null ? viewFormat.format(pickedValue) : null;
        cellContent = Text(value ?? '-');
        break;
      case ValueType.SelectMulti:
        final selectedValues = field.value is Iterable
            ? (field.value as Iterable).whereType<String>()
            : const <String>[];
        cellContent = Text(selectedValues
            .map((value) =>
                findFormOptionByValue(field.visibleOption, value)
                    ?.displayName ??
                value)
            .join(', '));
        break;
      case ValueType.SelectOne:
        if (field.hasErrors == true) {
          cellContent = Text(
            S.current.fieldContainErrors,
            style: const TextStyle(color: Colors.red),
          );
        } else {
          cellContent = Text(
              findFormOptionByValue(field.visibleOption, field.value)
                      ?.displayName ??
                  '-');
        }
        break;
      default:
        cellContent = Text('${field.value ?? '-'}');
        break;
    }

    if (field.hidden) {
      return Container(
        color: Colors.grey.shade300,
        padding: const EdgeInsets.all(8.0),
        child: cellContent,
      );
    }

    return cellContent;
  }

  @override
  int get rowCount => _elements.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedItems.length;
}
