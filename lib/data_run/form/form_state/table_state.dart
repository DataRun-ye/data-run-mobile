// import 'package:d_sdk/core/form/field_template/field_template.dart';
// import 'package:d_sdk/core/form/field_template/field_template.dart';
// import 'package:d_sdk/core/form/field_template/field_template.dart';
// import 'package:datarunmobile/data_run/form/form_state/field_state.dart';
// import 'package:datarunmobile/data_run/form/form_template/field_template_traverse.extension.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form/code_generator.dart';
//
// enum CellStatus { valid, invalid }
//
// class TableState extends ElementStat {
//
//   TableState(
//       {this.id,
//       required SectionTemplate template,
//       List<FieldTemplate> cellTemplates = const [],
//       this.isEditable = true,
//       required this.rows,
//       required this.cells})
//       : _template = template;
//   final SectionTemplate _template;
//   final String? id;
//   final bool isEditable;
//   final List<RowState> rows; // Hierarchical structure
//   /// Flat map for quick lookups
//   /// { "row.1_col1": CellState, "row1_col2": CellState, ... }
//   final Map<String, CellState> cells;
//
//   // Immutable update to a specific cell
//   TableState updateCell(String rowKey, String colKey, int? newValue) {
//     final updatedCellKey = '${rowKey}_$colKey';
//     final updatedCell = cells[updatedCellKey]?.copyWith(value: newValue);
//
//     if (updatedCell == null) return this;
//
//     // Update the row containing this cell
//     final updatedRows = rows.map((row) {
//       if (row.id == rowKey) {
//         return row.updateCell(colKey, updatedCell);
//       }
//       return row;
//     }).toList();
//
//     // Update the flat index
//     final updatedCells = {...cells, updatedCellKey: updatedCell};
//
//     return copyWith(rows: updatedRows, cells: updatedCells);
//   }
//
//   TableState copyWith(
//       {String? id,
//       bool? isEditable,
//       List<RowState>? rows,
//       Map<String, CellState>? cells}) {
//     return TableState(
//       id: id ?? this.id,
//       isEditable: isEditable ?? this.isEditable,
//       rows: rows ?? this.rows,
//       cells: cells ?? this.cells,
//       template: _template,
//     );
//   }
//
//   // Derived state for column-based calculations
//   num calculateColumnSum(int colIndex) {
//     return cells.entries
//         .where((entry) => entry.key.endsWith('_col$colIndex'))
//         .fold(
//             0,
//             (sum, entry) =>
//                 sum + ((entry.value is num) ? entry.value.value ?? 0 : 0));
//   }
//
//   // // Derived state for column sums or filtered views.
//   // List<int> get columnSums => List.generate(columnCount, (colIndex) {
//   //       return rows.fold(
//   //           0, (sum, row) => sum + (row.cells[colIndex].value ?? 0));
//   //     });
//
//   // num calculateColumnSum(int colIndex) {
//   //   return rows.fold(0, (sum, row) => sum + (row.cells[colIndex].value ?? 0));
//   // }
//
//   CellState? findCell(String rowKey, String colKey) {
//     return cells['${rowKey}_$colKey'];
//   }
//
//   List<CellState> getCellsWithErrors() {
//     return cells.values.where((cell) => cell.error != null).toList();
//   }
// }
//
// class RowState {
//
//   RowState({required this.id, required this.cells});
//
//   factory RowState.fromTemplate(SectionTemplate template,
//       [dynamic initialValue]) {
//     final uuid = CodeGenerator.generateUid();
//     final rowId = '${template.path}_${uuid}';
//     final cells = template.fields.map((field) {
//       return CellState.fromTemplate(rowId, field, initialValue?[field.name]);
//     }).toList();
//     return RowState(id: rowId, cells: cells);
//   }
//   final String id;
//   final List<CellState> cells;
//
//   RowState updateCell(String colKey, CellState updatedCell) {
//     final updatedCells = cells.map((cell) {
//       return cell.id == colKey ? updatedCell : cell;
//     }).toList();
//
//     return RowState(id: id, cells: updatedCells);
//   }
// }
//
// class CellState {
//
//   CellState({
//     required this.id,
//     this.value,
//     this.error,
//     this.isEditable = false,
//     required Template template,
//   }) : _template = template;
//
//   factory CellState.fromTemplate(String rowId, Template template,
//       [dynamic value]) {
//     return CellState(
//       id: '${rowId}_${template.name}',
//       isEditable: template.readOnly,
//       value: value,
//       template: template,
//     );
//   }
//   Template _template;
//
//   final String id;
//   final dynamic value;
//   final bool isEditable;
//   final String? error;
//
//   CellState copyWith({int? value, String? error}) {
//     return CellState(
//         id: id,
//         value: value ?? this.value,
//         error: error ?? this.error,
//         template: _template);
//   }
// }
//
// extension TableStateExtension on TableState {
//   int get columnCount =>
//       getDfsTemplateIterator<FieldTemplate>(_template).toList().length;
//
//   List<ColType> getColsOfType<ColType extends Template>() =>
//       getDfsTemplateIterator<ColType>(_template).toList();
// }
