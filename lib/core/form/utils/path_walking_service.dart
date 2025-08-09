// import 'package:d_sdk/core/form/element_template/section_template.entity.dart';
// import 'package:d_sdk/core/form/tree/template_path_walking_service.dart';
// import 'package:d_sdk/core/form/tree/tree_element.dart';
// import 'package:d_sdk/core/util/list_extensions.dart';
//
// mixin PathDependencyWalkingService<T extends TreeElement>
//     on TemplatePathWalkingService<T> {
//   T? getScopedDependencyByName(String name, String currentPath) {
//     final pathSegments = currentPath.split('.');
//
//     // upwards in the path
//     for (int i = pathSegments.length - 1; i >= 0; i--) {
//       final currentPathSegment = pathSegments.sublist(0, i + 1).join('.');
//
//       // in the current scope
//       final element = getTemplateByPath(currentPathSegment + '.' + name);
//       if (element != null) {
//         return element;
//       }
//     }
//
//     // If not found, check the global scope
//     final rootElements = flatFields.values
//         .where((element) => element.path!.split('.').length == 1);
//
//     for (final rootElement in rootElements) {
//       final scopedElement = getScopedElement(rootElement, name);
//       if (scopedElement != null) {
//         return scopedElement;
//       }
//     }
//
//     return null;
//   }
//
//   T? getScopedElement(T rootElement, String name) {
//     if (rootElement.name == name) {
//       return rootElement;
//     }
//
//     if (rootElement is SectionTemplate) {
//       for (final child in getDescendants(rootElement.path)) {
//         final element = getScopedElement(child, name);
//         if (element != null) {
//           return element;
//         }
//       }
//     }
//
//     // // Check if it is a repeat section with children
//     // if (rootElement is RepeatSectionElement) {
//     //   for (final child in rootElement.fields) {
//     //     final element = getScopedElement(child as T, name);
//     //     if (element != null) {
//     //       return element;
//     //     }
//     //   }
//     // }
//
//     return null;
//   }
//
//   /// Get element by name (nearest in scope)
//   T? getScopedDependencyByName2(String name, String currentPath) {
//     final pathSegments = currentPath.split('.');
//
//     // Look for the element in the current hierarchy, moving up through ancestors
//     for (int i = pathSegments.length - 1; i >= 0; i--) {
//       final currentPathSegment = pathSegments.sublist(0, i + 1).join('.');
//       final scopedElement = getTemplateByPath(currentPathSegment + '.' + name);
//
//       if (scopedElement != null) {
//         return scopedElement;
//       }
//     }
//
//     // Check for siblings (elements sharing the same parent path)
//     final parentPath = pathSegments.length > 1
//         ? pathSegments.sublist(0, pathSegments.length - 1).join('.')
//         : ''; // Root level has no parent path
//     final siblingElement = flatFields.values.firstOrNullWhere((element) =>
//         element.name == name &&
//         element.path!.startsWith(parentPath) &&
//         element.path != currentPath && // Not the same element
//         element.path!.split('.').length ==
//             currentPath.split('.').length); // Same level
//
//     if (siblingElement != null) {
//       return siblingElement;
//     }
//
//     // Check global scope (elements at the root level)
//     return flatFields.values.firstOrNullWhere((element) =>
//         element.name == name && element.path!.split('.').length == 1);
//   }
// }
