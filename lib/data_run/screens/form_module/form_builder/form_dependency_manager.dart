// import 'package:d_sdk/core/form/element_template/element_template.dart';
// import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/template_extension.dart';
// import 'package:datarunmobile/data_run/form/processing_dependencies.dart';
//
// class FormDependencyManager {
//   FormDependencyManager({required this.formFlatTemplate});
//
//   late Map<String, List<String>> _dependencyGraph;
//   late Map<String, Set<String>> _reverseDependencyGraph;
//   final FormTemplateRepository formFlatTemplate;
//
//   void initializeGraph() {
//     _dependencyGraph = formFlatTemplate.rootsFlatLookupMap().map(
//         (path, Template field) =>
//             MapEntry(path, buildDependencyGraph(field)));
//
//     _reverseDependencyGraph =
//         buildTransitiveReverseDependencyMap(_dependencyGraph);
//   }
//
//   List<String> buildDependencyGraph(Template element) {
//     final dependenciesPaths = <String>[];
//     for (var dependency in element.dependencies) {
//       final dependencyPath =
//           formFlatTemplate.getScopedDependencyByName(dependency, element.namePath!);
//       if (dependencyPath != null) {
//         dependenciesPaths.add(dependencyPath.namePath!);
//       }
//     }
//     return dependenciesPaths;
//   }
//
//   /// returns an Iterator of affected elements paths
//   Iterable<String> propagateElementChange(String elementPath) {
//     return propagateChange(elementPath, _reverseDependencyGraph);
//   }
// }
