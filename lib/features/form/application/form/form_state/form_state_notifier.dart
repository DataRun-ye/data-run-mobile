// import 'package:datarunmobile/data_run/form/form_state/form_state.data.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class FormNotifier extends StateNotifier<Map<String, FieldState>> {
//   FormNotifier() : super({});
//
//   // Update a field's visibility
//   void setVisibility(String path, bool isVisible) {
//     state = {
//       ...state,
//       path: state[path]!.copyWith(isVisible: isVisible),
//     };
//     _handleVisibilityChange(path);
//   }
//
//   // Update a field's value
//   void updateValue(String path, dynamic value) {
//     state = {
//       ...state,
//       path: state[path]!.copyWith(value: value),
//     };
//     _evaluateRules(path);
//   }
//
//   // Handle visibility change and trigger dependent updates
//   void _handleVisibilityChange(String path) {
//     final dependents = _resolveDependencies(path);
//     for (final dep in dependents) {
//       _evaluateRules(dep);
//     }
//   }
//
//   // Evaluate rules for a given field
//   void _evaluateRules(String path) {
//     // Add rule evaluation logic here
//   }
//
//   // Resolve dependencies for a field
//   List<String> _resolveDependencies(String path) {
//     // Return a list of dependent field paths
//     return [];
//   }
//
//   void updateFieldValue(String fieldId, dynamic newValue) {
//     final fieldState = _getField<FieldState>(fieldId);
//     if (fieldState != null) {
//       final updatedField = FieldState(
//         id: fieldState.id,
//         value: newValue,
//         isVisible: fieldState.isVisible,
//         errors: fieldState.errors,
//       );
//       _updateNode(fieldId, updatedField);
//     }
//   }
//
//   void updateSection(String sectionId, Map<String, FieldState> newChildren) {
//     final sectionState = _getField<SectionState>(sectionId);
//     if (sectionState != null) {
//       final updatedSection = sectionState.copyWith(children: newChildren);
//       _updateNode(sectionId, updatedSection);
//     }
//   }
//
//   void addRowToTable(String tableId, Map<String, FieldState> newRow) {
//     final tableState = _getField<TableState>(tableId);
//     if (tableState != null) {
//       final updatedRows = [...tableState.rows, newRow];
//       final updatedTable = tableState.copyWith(rows: updatedRows);
//       _updateNode(tableId, updatedTable);
//     }
//   }
//
//   FieldState? _getField<T extends FieldState>(String nodeId) {
//     return state.fields[nodeId] as T?;
//   }
//
//   void _updateNode(String nodeId, dynamic value) {
//     state = {
//       ...state,
//       nodeId: state[nodeId]!.copyWith(value: value),
//     };
//   }
//
//   void loadSection(String sectionId, Map<String, TreeNodeState> initialData) {
//     if (!_getField<SectionState>(sectionId).exists) {
//       final newSection = SectionState(id: sectionId, children: initialData);
//       _updateNode(sectionId, newSection);
//     }
//   }
// }
