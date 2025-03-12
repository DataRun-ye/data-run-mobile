// import 'package:d2_remote/d2_remote.dart';
// import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
// import 'package:d2_remote/modules/datarun/form/shared/form_element_template.dart';
// import 'package:d2_remote/modules/datarun/form/shared/rule/rule_action.dart';
// import 'package:datarunmobile/data_run/errors_management/error_management.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'form_element_instance.provider.g.dart';
//
// class FormTemplateNotFoundException extends DException<dynamic> {
//   FormTemplateNotFoundException(String form, int version)
//       : super(
//             'FormTemplateNotFoundException: form $form, version $version NotFound.');
// }
//
// class ElementTemplateNotFoundException extends DException<dynamic> {
//   ElementTemplateNotFoundException(String path)
//       : super(
//       'ElementTemplateNotFoundException: $path.');
// }
//
// @riverpod
// FormTemplateV formTemplate(FormTemplateRef ref) {
//   // final FormTemplateV? formTemplate = await D2Remote.formModule.formTemplateV
//   //     .byVersion(version)
//   //     .byFormTemplate(form)
//   //     .getOne();
//   //
//   // if (formTemplate == null) {
//   //   throw FormTemplateNotFoundException(form, version);
//   // }
//   // return formTemplate;
//   throw UnimplementedError();
// }
//
// @riverpod
// Future<FormElementInstance<T>> formElement<T>(
//     FormElementRef<T> ref, path) async {
//   final form = ref.watch(formTemplateProvider);
//   final template = form.getElementByPath(path);
//   if(template == null) {
//     throw ElementTemplateNotFoundException(path);
//   }
//
//   if(template == null) {
//     throw ElementTemplateNotFoundException(path);
//   }
//   return template;
// }
//
// @riverpod
// class ElementTemplate extends _$ElementTemplate {
//   FormElementTemplate build(String path) {
//     throw UnimplementedError();
//   }
// }
//
// @riverpod
// class FormElements extends _$FormElements {
//   List<FormElementInstance<dynamic>> build(String submission) {
//
//     throw UnimplementedError();
//   }
// }
//
// @riverpod
// class FormElement<T> extends _$FormElement<T> {
//   T build(String path) {
//     throw UnimplementedError();
//   }
// }
//
// @riverpod
// class ElementRuleState extends _$ElementRuleState {
//   RuleState? build(String elementPath) {
//     return null;
//   }
// }
//
// class RuleState {
//   RuleState(
//       {required this.elementPath,
//       required this.isInEffect,
//       required this.action,
//       required this.dependencies});
//
//   final String elementPath;
//   final bool isInEffect;
//   final ActionType action;
//   final List<String> dependencies;
// }
//
// class isVisible {}
//
