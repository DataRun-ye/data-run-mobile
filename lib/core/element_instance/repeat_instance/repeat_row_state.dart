import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/core/element_instance/element_state_factory.dart';
import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

enum CellStatus { valid, invalid }

class RowState extends SectionState {
  RowState({
    required super.id,
    super.fields,
    this.parent,
    required this.repeatIndex,
    required super.templatePath,
  });

  factory RowState.fromTemplate(SectionTemplate template,
      {required String rowId,
      required int repeatIndex,
      Map<String, dynamic>? initialValue}) {
    // final uuid = CodeGenerator.generateUid();
    // final rowId = '${template.path}_${uuid}';
    final cells = IMap.fromIterable(template.children,
        keyMapper: (t) => t.id,
        valueMapper: (t) => fromTemplate(template, value: initialValue));

    return RowState(
        id: rowId,
        repeatIndex: repeatIndex,
        fields: cells,
        templatePath: template.path);
  }

  final String? parent;
  final int repeatIndex;

// final List<FieldState> cells;
// IMap<String, ElementStat> get cells => fields;

// RowState updateCell(String colKey, FieldState updatedCell) {
//   final updatedCells = cells.values.map((cell) {
//     return cell.id == colKey ? updatedCell : cell;
//   }).toList();
//
//   // cells.updateAll((key, value) => );
//   cells.update(colKey, (value) => )
//
//   return RowState(id: id, fields: updatedCells);
// }
}

// extension TableStateExtension on RepeatState {
//   int get columnCount =>
//       getDfsTemplateIterator<FieldTemplate>(template).toList().length;
//
//   List<ColType> getColsOfType<ColType extends Template>() =>
//       getDfsTemplateIterator<ColType>(template).toList();
// }
