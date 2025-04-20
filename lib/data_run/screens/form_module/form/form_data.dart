// import 'package:datarunmobile/data_run/screens/form_module/form_builder/form_dependency_manager.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_builder/form_element_model_factory.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_builder/form_element_model_iterator.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
//
// class FormData {
//   FormData({
//     required this.formFlatTemplate,
//     initialValue,
//   })  : _rootElement = SectionElementModel(
//             elements: FormElementModelFactory.buildFormElements(
//                 formFlatTemplate.formTemplate,
//                 initialValue: initialValue),
//             templatePath: null),
//         formDependencyManager =
//             FormDependencyManager(formFlatTemplate: formFlatTemplate) {
//     _formFlatElements.addAll({
//       for (var x in getFormElementModelIterator<FormElementModel<dynamic>>(
//               _rootElement)
//           .where((e) => e.templatePath != null))
//         x.elementPath!: x
//     });
//
//     formDependencyManager.initializeGraph();
//   }
//
//   final FormFlatTemplate formFlatTemplate;
//   final FormDependencyManager formDependencyManager;
//   final SectionElementModel _rootElement;
//   final Map<String, FormElementModel<dynamic>> _formFlatElements = {};
//
//   SectionElementModel get rootElement => _rootElement;
//
//   Map<String, FormElementModel<dynamic>> get formFlatElements =>
//       Map.unmodifiable(_formFlatElements);
//
//   void updateFieldValue(String path, dynamic value) {
//     final node = _formFlatElements[path];
//     if (node is FieldElementModel) {
//       node.updateValue(value); // Updates both `flatIndex` and the tree.
//     }
//     // for (var dependency in formDependencyManager.propagateElementChange(path)) {
//     //   try {
//     //     formFlatTemplate.flatFields[dependency]?.ruleActions().forEach((ruleAction) {
//     //       logDebug(
//     //           info:
//     //           '$dependency\'s Evaluating: ${ruleAction.expression}, action: ${ruleAction.action}');
//     //       ruleAction.evaluate(evalContext)
//     //           ? ruleAction.apply(this)
//     //           : ruleAction.reset(this);
//     //     });
//     //   } catch (e) {
//     //     logError('Error Evaluating: ');
//     //   } finally {
//     //     _isEvaluating = false;
//     //   }
//     //
//     //   // _formFlatElements[dependency].evaluate();
//     // }
//   }
//
//   void addNode(RepeatElementModel parent, RepeatItemElementModel newNode) {
//     // Locate parent node in the tree
//     // final parentNode = _formFlatElements[path];
//     parent.add(newNode);
//     _formFlatElements['${parent.elementPath}.${newNode.uid}'] = newNode;
//     // formDependencyManager.buildDependencyGraph(newNode.templatePath!);
//   }
// }
