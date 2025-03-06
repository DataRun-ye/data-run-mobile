import 'package:datarun/core/element_instance/element_state.dart';
import 'package:datarun/core/element_instance/element_vistor/element_vistor.dart';
import 'package:datarun/core/element_instance/sction_instance/section_state.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class RepeatState extends SectionState {
  RepeatState(
      {required super.id,
      this.isEditable = true,
      super.fields,
      required super.templatePath});

  factory RepeatState.fromTemplate(SectionElementTemplate template,
      {List<Map<String, dynamic>?> value = const []}) {
    return RepeatState(
        templatePath: template.path,
        fields: const IMapConst({}),
        id: template.id!);
  }

  // final SectionTemplate template;
  final bool isEditable;

  // final IList<RowState> _fields; // Hierarchical structure

  // IList<RowState> get elements =>
  //     super.elements as IList<RowState>; // Hierarchical structure
  /// Flat map for quick lookups
  /// { "row.1_col1": CellState, "row1_col2": CellState, ... }
  // final Map<String, FieldState> cells;


  // // Immutable update to a specific cell
  // RepeatState updateCell(String rowKey, String colKey, int? newValue) {
  //   final updatedCellKey = '${rowKey}_$colKey';
  //   final updatedCell = cells[updatedCellKey]?.copyWith(value: newValue);
  //
  //   if (updatedCell == null) return this;
  //
  //   // Update the row containing this cell
  //   final updatedRows = rows.map((row) {
  //     if (row.id == rowKey) {
  //       return row.updateCell(colKey, updatedCell);
  //     }
  //     return row;
  //   }).toList();
  //
  //   // Update the flat index
  //   final updatedCells = {...cells, updatedCellKey: updatedCell};
  //
  //   return copyWith(rows: updatedRows, cells: updatedCells);
  // }

  RepeatState copyWith(
      {String? id,
      bool? isVisible,
      IMap<String, ElementStat>? fields,
      bool? isEditable}) {
    return RepeatState(
      id: id ?? this.id,
      isEditable: isEditable ?? this.isEditable,
      fields: fields ?? this.fields,
      templatePath: templatePath,
    );
  }

  // Derived state for column-based calculations
  // num calculateColumnSum(int colIndex) {
  //   return fields.entries
  //       .where((entry) => entry.key.endsWith('_col$colIndex'))
  //       .fold(
  //           0,
  //           (sum, entry) =>
  //               sum + ((entry.value is num) ? entry.value.value ?? 0 : 0));
  // }

  // // Derived state for column sums or filtered views.
  // List<int> get columnSums => List.generate(columnCount, (colIndex) {
  //       return rows.fold(
  //           0, (sum, row) => sum + (row.cells[colIndex].value ?? 0));
  //     });

  // num calculateColumnSum(int colIndex) {
  //   return rows.fold(0, (sum, row) => sum + (row.cells[colIndex].value ?? 0));
  // }

  // FieldState? findCell(String rowKey, String colKey) {
  //   return cells['${rowKey}_$colKey'];
  // }
  //
  // List<FieldState> getCellsWithErrors() {
  //   return cells.values.where((cell) => cell.hasError).toList();
  // }

  @override
  void accept(ElementVisitor<dynamic> visitor) {
    visitor.doForRepeatSection(this);
  }
}
