import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/extensions/list_extensions.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';
import 'package:datarun/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../d_activity/activity_model.dart';

class RepeatTableDataSource extends DataTableSource {
  RepeatTableDataSource(
      {this.onDelete,
      this.onEdit,
      this.editable = true,
      required this.activityModel,
      List<RepeatItemInstance> elements = const []}) {
    this.elements.addAll(elements);
  }

  final ActivityModel Function() activityModel;

  void markEnabled() {
    if (editable) {
      return;
    }
    editable = true;
    notifyListeners();
  }

  void removeItem(RepeatItemInstance item) {
    elements.remove(item);
    notifyListeners();
  }

  void updateItems(List<RepeatItemInstance> items) {
    elements.updateById(items, (item) => item.elementPath == item.elementPath);
    notifyListeners();
  }

  void addItem(RepeatItemInstance item) {
    elements.add(item);
    notifyListeners();
  }

  void setItems(List<RepeatItemInstance> items) {
    elements.clear();
    elements.addAll(items);
    notifyListeners();
  }

  final Function(int)? onDelete;
  final Function(int)? onEdit;
  final List<RepeatItemInstance> elements = [];
  bool editable;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= elements.length) return null;

    final repeatItem = elements[index];
    final Iterable<FieldInstance<dynamic>> rowFields =
        getFormElementIterator<FieldInstance<dynamic>>(elements[index]);

    final rowFieldsStates =
        rowFields.map((field) => field).toList().reversedView;

    return DataRow.byIndex(index: index, selected: repeatItem.selected, cells: [
      DataCell(Text('${index + 1}')),
      ...rowFieldsStates
          .map((field) => DataCell(userFriendlyValue(field)))
          .toList(),
      if (editable)
        DataCell(IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              onEdit?.call(index);
            })),
      if (editable)
        DataCell(IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: editable
                ? () {
                    onDelete?.call(index);
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
          '  '.toString(),
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
            SizedBox(width: 4),
            Text(modelToViewValue(field.value) ?? '-'),
          ],
        );
        break;
      case ValueType.Progress:
        cellContent = field.value != null
            ? Row(
                children: [
                  buildStatusBadge(AssignmentStatus.getType(field.value)!),
                  SizedBox(width: 4),
                  Text(field.value ?? ''),
                ],
              )
            : Text('${field.value ?? '-'}');
      case ValueType.Team:
        cellContent = Row(
          children: [
            Icon(MdiIcons.accountGroup),
            SizedBox(width: 4),
            Text(activityModel
                    .call()
                    .managedTeams
                    .where((t) => t.id == field.value)
                    .firstOrNull
                    ?.name ??
                field.value ??
                ''),
          ],
        );
        break;

      case ValueType.Date:
      case ValueType.DateTime:
      case ValueType.Time:
        cellContent = Text(modelToViewValue(field.value) ?? '-');
        break;
      case ValueType.SelectMulti:
        cellContent = Text(field.visibleOption
            .where((option) => option.name == field.value)
            .whereType<String>()
            .join(', '));
        break;
      case ValueType.SelectOne:
        if (field.hasErrors == true) {
          cellContent = Text(
            S.current.fieldContainErrors,
            style: const TextStyle(color: Colors.red),
          );
        } else {
          cellContent = Text(getItemLocalString(
              field.visibleOption
                  .firstOrNullWhere((option) => option.name == field.value)
                  ?.label
                  .unlockView,
              defaultString: '-'));
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

  String? modelToViewValue(String? modelValue) {
    return modelValue == null
        ? null
        : DateHelper.fromDbUtcToUiLocalFormat(modelValue);
  }

  @override
  int get rowCount => elements.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
