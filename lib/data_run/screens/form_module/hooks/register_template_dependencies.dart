// import 'package:datarunmobile/data_run/form/form_element_factories/form_element_control_builder.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/template_extension.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// Map<String, FormElementInstance<dynamic>> useResolveDependencies(
//     FormElementTemplate element, SectionElement<dynamic>? parent) {
//   return useMemoized(() {
//     return _resolveFormElementDependencies(element, parent);
//   }, [element.path]);
// }
//
// void useRegisterTemplateDependencies(
//     FormElementTemplate element, SectionElement<dynamic>? parent) {
//   /// resolve and cache a form element dependencies
//   final resolvedDependency =
//       useResolveDependencies(element, parent);
//
//   /// bind dependencies
//   useEffect(() {
//     if (element is FieldElementTemplate) {
//       element.elementControl!.valueChanges.listen((value) {
//         if (value == null) {
//           element.updateStatus(element.elementState.reset(value: value));
//         } else {
//           element.updateStatus(element.elementState.copyWith(value: value));
//         }
//       });
//     }
//
//     // bind to the
//     for (final elementDependency in resolvedDependency.values) {
//       // add a dependency entry in the the element's dependencies map
//       element.addDependency(elementDependency);
//       // add/bind action behaviour to the element
//       // evaluate element's initial status
//       // element.evaluate(elementDependency.name);
//     }
//
//     element.evaluate();
//
//     return () => element.dispose();
//   }, [element.elementPath]);
// }
//
// Map<String, FormElementInstance<dynamic>> _resolveFormElementDependencies(
//     FormElementTemplate element, SectionElement<dynamic>? parent) {
//   final List<String> dependencies = <String>[
//     ...element.dependencies,
//     if (element is FieldElementTemplate) ...element.choicesDependencies
//   ].toSet().toList();
//   if (!element.type.isSectionType) {
//     logDebug(
//         info:
//             'resolving dependencies for: ${element.name} ${dependencies.length > 0 ? ', dependencies: ${dependencies}' : '... has no dependencies'}');
//   }
//
//   final Map<String, FormElementInstance<dynamic>> resolved = {};
//   for (final dependencyName in dependencies) {
//     final dependency = (parent?.contains(dependencyName) ?? false)
//         ? parent?.element(dependencyName)
//         : parent?.findElementInParentSection(dependencyName);
//     if (dependency != null) {
//       resolved[dependency.name] = dependency;
//     }
//   }
//
//   return resolved;
// }
//
// //
// // final loggerInitialization = Logger(
// //     printer: PrettyPrinter(
// //         colors: true,
// //         methodCount: 0,
// //         printEmojis: false,
// //         excludeBox: {Level.trace: true, Level.info: true}),
// //     level: Level.debug);
// //
