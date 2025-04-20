// import 'package:datarunmobile/data_run/screens/form_module/form/form_data.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
//
// class FormBuilder {
//   FormBuilder();
//
//   FormData build(FormFlatTemplate template, [initialValue]) {
//     // var root = SectionElementModel(
//     //     elements: FormElementModelFactory.buildFormElements(
//     //         template.formTemplate,
//     //         initialValue: initialValue),
//     //     templatePath: null);
//
//     return FormData(formFlatTemplate: template, initialValue: initialValue);
//   }
//   //
//   // /// will iterate through the full map of formElementMap of the form,
//   // /// for elements can be one of [FieldElementModel],
//   // /// [SectionElementModel], [RepeatElementModel], or [RepeatItemElementModel]
//   // Map<String, Set<String>> buildDependencies(
//   //     Map<String, FormElementModel<dynamic>> formElementMap) {
//   //   final Map<String, Set<String>> dependencyGraph = {};
//   //   for (var element in formElementMap.values) {
//   //     // required by the sorting that every element has an entry
//   //     // in the dependency graph map even empty
//   //     dependencyGraph.putIfAbsent(element.name!, () => {});
//   //     for (var dependency in element.dependencies) {
//   //       dependencyGraph.putIfAbsent(dependency, () => {}).add(element.path!);
//   //     }
//   //   }
//   //   return dependencyGraph;
//   // }
//   //
//   // FormData buildFromForm(FormElementModel<dynamic> root) {
//   //   var clonedForm = root.clone(null);
//   //   var formElementMap = {
//   //     for (var x
//   //         in getFormElementModelIterator<FormElementModel<dynamic>>(clonedForm)
//   //             .where((e) => e.path != null))
//   //       x.path!: x
//   //   };
//   //   final Map<String, Set<String>> dependencyGraph =
//   //       buildDependencies(formElementMap);
//   //
//   //   return _build(clonedForm, formElementMap, dependencyGraph);
//   // }
//
//   // FormData _build(
//   //     FormElementModel<dynamic> root,
//   //     Map<String, FormElementModel<dynamic>> formElementMap,
//   //     Map<String, Set<String>> dependencyGraph) {
//   //   _buildElementsSubscriptionDependencies(root);
//   //
//   //   // var formValidations = getFormElementIterator<Validation>(root).toList();
//   //
//   //   return FormData(
//   //       form: root,
//   //       formElementCache: FormElementCache(formElementMap: formElementMap),
//   //       dependencyGraph: dependencyGraph);
//   // }
//
//   // void _buildCloneableExpressions(
//   //     FormElement form, Map<String, FormElement> expressionProviderElementMap) {
//   //   var formElementExpressions =
//   //       getFormPropertyIterator<CloneableExpressionProperty>(form);
//   //
//   //   for (var expressionValue in formElementExpressions) {
//   //     expressionValue.buildExpression(expressionProviderElementMap);
//   //   }
//   // }
//
//   // void _buildStringExpressions(FormElement root, ExpressionParser parser) {
//   //   var formElementExpressions =
//   //       getFormPropertyIterator<StringExpressionProperty>(root);
//   //
//   //   for (var expressionValue in formElementExpressions) {
//   //     try {
//   //       expressionValue.buildExpression(parser);
//   //     } catch (e, s) {
//   //       throw ExpressionBuilderException(expressionValue, e, s);
//   //     }
//   //   }
//   // }
//
//   // void _buildElementsSubscriptionDependencies(FormElementModel<dynamic> root) {
//   // Iterable<FieldElementModel<dynamic>> formFields =
//   //     getFormElementModelIterator<FieldElementModel<dynamic>>(root);
//
//   // for (var element in formFields) {
//   //   for (var sourceProperty
//   //       in element.dependencies) {
//   //     (sourceProperty as Property)
//   //         .addSubscriber(element as ExpressionProperty<dynamic>);
//   //   }
//   // }
//   // }
// }
