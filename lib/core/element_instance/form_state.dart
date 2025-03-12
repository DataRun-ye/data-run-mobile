import 'package:datarunmobile/core/element_instance/element_state.dart';
import 'package:datarunmobile/core/element_instance/element_state_factory.dart';
import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormState extends SectionState {
  FormState({
    this.version = 0,
    required super.id,
    super.fields = const IMapConst({}),
    this.isValid = true,
    this.isSubmitting = false,
    required super.templatePath,
  });

  factory FormState.fromTemplate(FormFlatTemplate template,
      [Map<String, dynamic>? value]) {
    return FormState(
        id: template.name!,
        version: 0,
        fields: IMap.fromIterable(template.rootElementTemplate.children,
            keyMapper: (t) => t.id!,
            valueMapper: (t) => fromTemplate(t, value: value?[t.path])),
        templatePath: null);
  }

  final int version;

  // final Map<String, SectionState> sections; // Keyed by section IDs
  // final String id;
  // final IMap<String, ElementStat> fields;
  final bool isValid;
  final bool isSubmitting;

  FormState copyWith({
    String? id,
    bool? isVisible,
    IMap<String, ElementStat>? fields,
    bool? isValid,
    bool? isSubmitting,
    int? version,
  }) {
    return FormState(
      id: id ?? this.id,
      fields: fields ?? this.fields,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      version: version ?? this.version,
      templatePath: null,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([version]);
// FormState updateCell(path, int? newValue) {
//   final updatedCellKey = '${rowKey}_$colKey';
//   final updatedCell = fields[path]?.copyWith(value: newValue);
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
}
