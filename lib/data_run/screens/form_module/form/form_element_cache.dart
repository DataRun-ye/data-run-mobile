// import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
//
// class FormElementCache {
//   final Map<String, FormElementModel<dynamic>> _formElementMap = {};
//   final FormFlatTemplate formFlatTemplate;
//
//   FormElementCache({
//     Map<String, FormElementModel<dynamic>> formElementMap = const {},
//     required this.formFlatTemplate,
//   }) {
//     _formElementMap.addAll(formElementMap);
//   }
//
//   void addElement(FormElementModel<dynamic> element) {
//     _formElementMap[element.templatePath] = element;
//     if (element is SectionElementModel) {
//       for (var child in element.elements.values) {
//         addElement(child);
//       }
//     }
//
//     if (element is CollectionElementModel) {
//       for (var child in element.elementsList) {
//         addElement(child);
//       }
//     }
//   }
//
//   FormElementModel<dynamic>? getElementById(String id) {
//     return _formElementMap[id];
//   }
//
//   /// **Depth-First Search (DFS):**
//   ///
//   /// Use DFS when you need to explore as far down a branch as possible
//   /// before backtracking. This is useful for deep dependency resolution.
//   void dfs(FormElementModel<dynamic> root,
//       void Function(FormElementModel<dynamic>) action) {
//     action(root);
//     if (root is CollectionElementModel) {
//       for (var child in root.elementsList) {
//         dfs(child, action);
//       }
//     }
//   }
//
//   /// **Breadth-First Search (BFS):**
//   ///
//   /// Use BFS when you need to explore all nodes at the present depth
//   /// level before moving to nodes at the next depth level.
//   /// This can be useful for level-order operations like aggregating
//   /// values at a particular level.
//   void bfs(FormElementModel<dynamic> root,
//       void Function(FormElementModel<dynamic>) action) {
//     final queue = <FormElementModel<dynamic>>[root];
//     while (queue.isNotEmpty) {
//       final node = queue.removeAt(0);
//       action(node);
//       if (node is CollectionElementModel) {
//         queue.addAll(node.elementsList);
//       }
//     }
//   }
//
//   /// **Handling Different Contexts:**
//   ///
//   /// Depending on whether you care about sections, repeated sections,
//   /// or only specific elements, tailor your traversal and lookup
//   /// strategies accordingly.
//   void gatherFieldsForExport(
//       FormElementModel<dynamic> root, List<FormElementModel<dynamic>> fields) {
//     void traverse(FormElementModel<dynamic> element) {
//       if (element is FieldElementModel<dynamic>) {
//         fields.add(element);
//       } else if (element is SectionElementModel) {
//         for (var child in element.elementsList) {
//           traverse(child);
//         }
//       } else if (element is RepeatElementModel) {
//         final List<FormElementModel<dynamic>> rows = [];
//         for (var row in element.elements) {
//           traverse(row);
//         }
//       }
//     }
//
//     traverse(root);
//   }
//
//   void removeFromCache(FormElementModel<dynamic> element) {
//     _formElementMap.remove(element.id);
//     if (element is SectionElementModel) {
//       for (var child in element.elements.values) {
//         removeFromCache(child);
//       }
//     } else if (element is RepeatElementModel) {
//       for (var row in element.elements) {
//         removeFromCache(row);
//       }
//     }
//   }
//
// // void resolveDependencies(FormElementModel<dynamic> element, FormElementCache cache, [Set<String>? visited]) {
// //   visited ??= {};
// //   if (visited.contains(element.id)) {
// //     // Circular dependency detected
// //     // Logger.log('Circular dependency detected for element: ${element.id}');
// //     return;
// //   }
// //   visited.add(element.id);
// //
// //   for (var dependency in element.dependencies) {
// //     var dependentElement = cache.getElementById(dependency);
// //     if (dependentElement != null) {
// //       resolveDependencies(dependentElement, cache, visited);
// //       element.updateBasedOnDependency(dependentElement);
// //     }
// //   }
// // }
// //
// //
// // void handleDependenciesDuringInteraction(FormElement element, FormElementCache cache) {
// //   // Check local section
// //   evaluateDependencies(element, cache);
// //
// //   // Check parent section
// //   var parent = element.parent;
// //   while (parent != null) {
// //     evaluateDependencies(parent, cache);
// //     parent = parent.parent;
// //   }
// // }
// }
