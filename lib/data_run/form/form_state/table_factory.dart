// import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
// import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
// import 'package:datarun/data_run/form/form_state/table_state.dart';
// import 'package:datarun/data_run/screens/form_module/form/code_generator.dart';
//
// class TableFactory {
//   static RowState createRow(SectionTemplate config) {
//     final uuid = CodeGenerator.generateUid();
//     final rowId = '${config.path}_${uuid}';
//     final cells = config.fields.map((field) {
//       final cellId = '${rowId}_${field.name}';
//       return CellState(
//         id: cellId,
//         // value: field,
//         // Initialize value as empty
//         isEditable: field.readOnly,
//         template: field,
//       );
//     }).toList();
//     return RowState(id: rowId, cells: cells);
//   }
// }
