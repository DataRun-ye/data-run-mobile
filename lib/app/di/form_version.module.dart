// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/shared/utilities/sort_order.util.dart';
// import 'package:injectable/injectable.dart';
//
// @module
// abstract class FormVersionModule {
//   @FactoryMethod(preResolve: true)
//   Future<FormTemplateVersion> formVersion(@factoryParam String? formId) async {
//     /// try to get form versions by the specific form version Ids
//     /// It would retrieve the specific versions of formTemplate
//     final formVersionByVersionId = await D2Remote.formModule.formTemplateV
//         .byId(formId!)
//         .orderBy(attribute: 'version', order: SortOrder.DESC)
//         .getOne();
//
//     if (formVersionByVersionId != null) {
//       return formVersionByVersionId;
//     } else {
//       /// try to get form versions by form template Ids
//       /// if more than one value for the same formTemplate, take latest version
//       final FormTemplateVersion? formVersionByFormId = await D2Remote
//           .formModule.formTemplateV
//           .where(attribute: 'formTemplate', value: formId)
//           .orderBy(attribute: 'version', order: SortOrder.DESC)
//           .getOne();
//
//       return formVersionByFormId!;
//     }
//   }
// }
