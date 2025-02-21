// import 'package:datarun/data_run/screens/form/element/form_element.dart';
// import 'package:flutter/material.dart';
//
// abstract class FormElementWidget extends StatelessWidget {
//   final FormElementInstance<dynamic> element;
//
//   const FormElementWidget({
//     required this.element,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // AsyncValue(error: final error?, stackTrace: final stackTrace)
//     return switch (element) {
//       FieldInstance<dynamic> f => _buildField(f),
//       // RepeatItemInstance(elements: final elements) when elements.isEmpty => _buildSection(element),
//       RepeatItemInstance e => _buildRepeatItem(e),
//       RepeatSection r => _buildRepeat(r),
//       Section e => _buildSection(e),
//     };
//   }
//
//   Widget _buildField(FieldInstance<dynamic> e) {
//     return TextFormField(
//       // ... field-specific properties
//       decoration: InputDecoration(labelText: e.label),
//     );
//   }
//
//   Widget _buildSection(Section section) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Section header
//         _SectionHeader(title: section.title),
//         // Recursive children
//         ...section.fields.map((e) => FormElementBuilder(element: e)),
//       ],
//     );
//   }
//
//   Widget _buildRepeat(RepeatSection repeat) {
//     return Column(
//       children: [
//         _SectionHeader(title: repeat.title),
//         _buildRepeatTable(repeat),
//         // Add row button
//       ],
//     );
//   }
//
//   Widget _buildRepeatItem(RepeatItemInstance repeat) {
//     return Column(
//       children: [
//         _SectionHeader(title: repeat.title),
//         _buildRepeatTable(repeat),
//         // Add row button
//       ],
//     );
//   }
//
//   Widget _buildRepeatTable(RepeatElement repeat) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scrollbar(
//           thumbVisibility: true,
//           controller: _horizontalScrollController,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minWidth: constraints.maxWidth),
//               child: DataTable(
//                 columns: _buildTableColumns(repeat),
//                 rows: repeat.children.map((section) {
//                   return DataRow(
//                     cells: section.fields.map((field) {
//                       return DataCell(FormElementBuilder(element: field));
//                     }).toList(),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _SectionHeader extends StatelessWidget {
//   const _SectionHeader({super.key, required this.title});
//
//   final String title;
//
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(title, style: Theme.of(context).textTheme.titleMedium),
//     );
//   }
// }
