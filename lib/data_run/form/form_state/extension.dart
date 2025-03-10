// import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
// import 'package:datarun/data_run/form/form_state/form_state.dart';
//
// extension FormStateExtension on FormState {
//   Template buildTree(String rootPath, List<Template> allNodes) {
//     final rootNode = allNodes.firstWhere((node) => node.path == rootPath);
//     final children = getImmediateChildren(rootPath, allNodes)
//         .map((child) => buildTree(child.path, allNodes))
//         .toList();
//     return TreeNodeWithChildren(
//       id: rootNode.id,
//       path: rootNode.path,
//       data: rootNode.data,
//       children: children,
//     );
//   }
//   String _getBasePath(String path) {
//     // Extract the base path before the UID
//     final parts = path.split('.');
//     parts.removeLast();
//     return parts.join('.');
//   }
//
//   FormState addItemToRepeatSectionWithLimit(
//       String basePath, RepeatElementTemplate template,
//       {int? maxItems, List<Map<String, dynamic>> initialValues = const []}) {
//     final currentItems =
//         fields.keys.where((key) => key.startsWith(basePath)).length;
//     if (maxItems != null && currentItems >= maxItems) {
//       throw Exception("Max items limit reached for $basePath");
//     }
//     return addItemToRepeatSection(basePath, template,
//         initialValues: initialValues);
//   }
//
//   Map<String, dynamic> serializeState() {
//     return fields.map((path, field) => MapEntry(path, field.value));
//   }
//
//   FormState updateFromSerialized(Map<String, dynamic> json) {
//     final newFields = Map<String, FieldState>.from(fields);
//     json.forEach((path, value) {
//       if (newFields.containsKey(path)) {
//         newFields[path] = newFields[path]!.copyWith(value: value);
//       }
//     });
//
//     return copyWith(fields: newFields);
//   }
//
//
//   FormState addDynamicField(String parentPath, FieldElementTemplate template) {
//     final fullPath = '$parentPath.${template.name}';
//     if (fields.containsKey(fullPath)) {
//       throw Exception('Field already exists at $fullPath');
//     }
//     final newFields = Map<String, FieldState>.from(fields);
//     _initializeValues(template, newFields, basePath: parentPath);
//     return copyWith(fields: newFields);
//   }
//
//   void evaluateRulesAfterAddition(String path) {
//     // Fetch affected dependencies and evaluate their rules
//     // resolveDependencies(path).forEach((dep) {
//     //   evaluateRulesForField(dep);
//     // });
//
//     //   Map<String, String> aggregateErrors() {
//     //     return fields.entries
//     //         .where((entry) => entry.value.hasError)
//     //         .map((entry) => MapEntry(entry.key, entry.value.errorMessage!))
//     //         .toMap();
//     //   }
//     //
//     //   Map<String, String> getErrorsForPath(String path) {
//     //     return fields.entries
//     //         .where((entry) => entry.key.startsWith(path) && entry.value.hasError)
//     //         .map((entry) => MapEntry(entry.key, entry.value.errorMessage!))
//     //         .toMap();
//     //   }
//     // }
//
//     /// materialized path utils
//     List<FieldState> getChildren(String path) {
//       return fields.entries
//           .where((entry) => entry.key.startsWith(path) && entry.key != path)
//           .map((entry) => entry.value)
//           .toList();
//     }
//
//     List<FieldState> getDirectChildren(String path) {
//       final baseDepth = path.split('.').length;
//       return fields.entries
//           .where((entry) =>
//       entry.key.startsWith(path) &&
//           entry.key.split('.').length == baseDepth + 1)
//           .map((entry) => entry.value)
//           .toList();
//     }
//   }
//
// /// evaluation
// // formState.evaluateRulesForPath('path.to.section');
// }
