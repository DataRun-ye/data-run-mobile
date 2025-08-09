// import 'package:built_collection/built_collection.dart';
// import 'package:d_sdk/core/form/element_template/template.dart';
// import 'package:d_sdk/core/form/template_util/element_tree_service.dart';
// import 'package:datarunmobile/di/injection.dart';
// import 'package:datarunmobile/home/form_template/domain/model/form_template_model.dart';
// import 'package:datarunmobile/home/form_template/domain/service/form_template_service.dart';
// import 'package:injectable/injectable.dart';
//
// @injectable
// class SubmissionFormRepository {
//   SubmissionFormRepository(
//       {required this.formTemplate, Iterable<Template>? formElementCache})
//       : this.allFormElementCache = BuiltList.from(formElementCache ?? []);
//
//   @FactoryMethod(preResolve: true)
//   static Future<SubmissionFormRepository> formRepository(
//       {@factoryParam String? versionId}) async {
//     final formTemplateModel = await appLocator<FormTemplateService>()
//         .getTemplateByVersionOrLatest(versionId: versionId);
//     return SubmissionFormRepository(
//         formTemplate: formTemplateModel,
//         formElementCache: [
//           ...formTemplateModel.sections,
//           ...formTemplateModel.fields
//         ].build());
//   }
//
//   // final FieldUiModel fieldUiModel;
//
//   final FormTemplateModel formTemplate;
//   final BuiltList<Template> allFormElementCache;
//
//   List<Template> getSectionImmediateChildren(String path) {
//     return ElementTreeService.getImmediateChildren(path, formTemplate.fields);
//   }
// }
