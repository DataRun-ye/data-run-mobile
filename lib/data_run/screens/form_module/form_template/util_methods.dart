// import 'package:d_sdk/d_sdk.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:drift/drift.dart';
//
// Future<FormTemplate> getFormTemplate(String formId) async {
//   final formTemplate = await DSdk.db.managers.formTemplates
//       .filter((f) => f.id(formId))
//       .getSingle();
//   return formTemplate;
// }
//
// //
// Future<FormTemplateVersion> getTemplateByVersionOrLatest(String id) async {
//   /// try to get form versions by the specific form version Ids
//   /// It would retrieve the specific versions of formTemplate
//   final formTemplate = await DSdk.db.managers.formTemplateVersions
//       .filter((f) => f.id(id))
//       .orderBy((o) => o.versionNumber.desc())
//       .limit(1)
//       .getSingleOrNull();
//
//   if (formTemplate != null) {
//     return formTemplate;
//   } else {
//     /// try to get form versions by form template Ids
//     /// if more than one value for the same formTemplate, take latest version
//
//     final FormTemplateVersion? formTemplate = await DSdk
//         .db.managers.formTemplateVersions
//         .filter((f) => f.id.startsWith(id))
//         .orderBy((o) => o.versionNumber.desc())
//         .limit(1)
//         .getSingleOrNull();
//
//     return formTemplate!;
//   }
// }
// // Future<FormTemplateVersion> getTemplateByVersionOrLatest(String id) async {
// //   /// try to get form versions by the specific form version Ids
// //   /// It would retrieve the specific versions of formTemplate
// //   final formTemplate = await D2Remote.formModule.formTemplateV
// //       .where(attribute: 'formTemplate', value: id)
// //       .orderBy(attribute: 'versionNumber', sortOrder: SortOrder.DESC)
// //       .getOne();
// //
// //   if (formTemplate != null) {
// //     return formTemplate;
// //   } else {
// //     /// try to get form versions by form template Ids
// //     /// if more than one value for the same formTemplate, take latest version
// //     final FormTemplateVersion? formTemplate = await D2Remote.formModule.formTemplateV
// //         .where(attribute: 'formTemplate', value: id)
// //         .orderBy(attribute: 'versionNumber', sortOrder: SortOrder.DESC)
// //         .getOne();
// //
// //     return formTemplate!;
// //   }
// // }
//
// Future<Map<String, List<DataOption>>> getOptionSets(
//     FormTemplateVersion? template) async {
//   final List<String> optionSets = (template?.fields ?? [])
//       .where((t) => t.type?.isSelectType == true && t.optionSet != null)
//       .map((t) => t.optionSet!)
//       .toList();
//   Map<String, List<DataOption>> optionLists = {};
//
//   final List<DataOptionSet> formOptionSets = [];
//   if (optionSets.isNotEmpty) {
//     final List<DataOption> options = await DSdk.db.managers.dataOptions
//         .filter((f) => f.optionSet.id.isIn(optionSets))
//         .get();
//
//     optionLists = Map.fromIterable(options,
//         key: (option) => option.optionSet,
//         value: (option) =>
//             options.where((o) => o.optionSet == option.optionSet).toList());
//   }
//
//   return optionLists;
// }
//
// // Future<Map<String, List<DataOption>>> getOptionSets(FormTemplateVersion? template) async {
// //   final List<String> optionSets = (template?.fields ?? IList())
// //       .where((t) => t.type?.isSelectType == true && t.optionSet != null)
// //       .map((t) => t.optionSet!)
// //       .toList();
// //   Map<String, List<DataOption>> optionLists = {};
// //
// //   final List<OptionSet> formOptionSets = [];
// //   if (optionSets.isNotEmpty) {
// //     formOptionSets.addAll(await D2Remote.optionSetModule.optionSet
// //         .byIds(optionSets)
// //         .withOptions()
// //         .get());
// //     optionLists = IMap.fromIterable(formOptionSets,
// //             keyMapper: (optionSet) => optionSet.id!,
// //             valueMapper: (optionSet) => (optionSet.options ?? [])
// //               ..sort(
// //                   (p1, p2) => p1.sortOrder.compareTo(p2.sortOrder)))
// //         .unlockView;
// //   }
// //   return optionLists;
// // }
