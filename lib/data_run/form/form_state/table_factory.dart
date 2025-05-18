// import 'package:d_sdk/core/form/element_template/element_template.dart';
// import 'package:d_sdk/core/form/element_template/element_template.dart';
// import 'package:datarunmobile/data_run/form/form_state/table_state.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form/code_generator.dart';
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
