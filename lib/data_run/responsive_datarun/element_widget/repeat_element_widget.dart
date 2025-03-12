// import 'package:datarunmobile/data_run/responsive_datarun/element_widget/form_element_widget.dart';
// import 'package:flutter/material.dart';
//
// class RepeatElementWidget extends FormElementWidget {
//   RepeatElementWidget({required super.element});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildHeader(),
//         _buildTable(),
//         _buildAddRowButton(),
//       ],
//     );
//   }
//
//   Widget _buildTable() {
//     return HorizontalScrollWrapper(
//         child: DataTable(
//             columns: element.rowTemplate.columns.map((col) =>
//                 DataColumn(label: Text(col.label))).toList(),
//             rows: element.rows.map((row) =>
//                 DataRow(
//                     cells: row.cells.map((cell) =>
//                         DataCell(FormElementWidget(
//                             element: cell,
//                             stateManager: stateManager
//                         ))
//                     ).toList()
//                 )
//             ).toList()
//         )
//     );
//   }
// }
