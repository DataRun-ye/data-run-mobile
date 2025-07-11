import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/home/form_template/application/form_list_filter.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_list_item_model.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_template_model.dart';
import 'package:datarunmobile/data/form_template_service.dart';
import 'package:datarunmobile/data/option_set_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@riverpod
Future<List<FormListItemModel>> formListItems(
    Ref ref, FormListFilter filter) async {
  final templates =
      await appLocator<FormTemplateService>().fetchByFilter(filter);
  return templates
      .map((t) => FormListItemModel(
            id: t.id,
            name: t.name,
            versionNumber: t.versionNumber,
            label: t.label,
          ))
      .toList();
}

@riverpod
Future<Map<String, List<DataOption>>> formTemplateOptions(Ref ref,
    {required String formId, String? versionId}) async {
  final FormTemplateModel formTemplate = await appLocator<FormTemplateService>()
      .getTemplateByVersionOrLatest(templateId: formId, versionId: versionId);

  return appLocator<OptionSetService>().getOptionSets(formTemplate);
}

@riverpod
Future<DataOptionSet?> optionSet(Ref ref, {required String id}) async {
  return appLocator<OptionSetService>().getOptionSet(id);
}

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
@riverpod
Future<FormTemplateModel> submissionVersionFormTemplate(Ref ref,
    {required String formId}) async {
  return appLocator<FormTemplateService>()
      .getTemplateByVersionOrLatest(templateId: formId);
}
//
// @riverpod
// Future<FormTemplateModel> formTemplateModel(
//   Ref ref, {
//   required String versionIdOrFormId,
// }) async {
//   final flatTemplate =
//       await FormFlatTemplate.fromTemplate(templateId: versionIdOrFormId);
//   return flatTemplate;
// }
//
// @riverpod
// Future<FormFlatTemplate> formFlatTemplate(
//   Ref ref, {
//   required FormMetadata formMetadata,
// }) async {
//   if (formMetadata.submission != null) {
//     final DataSubmission submission = await DSdk.db.managers.dataSubmissions
//         .filter((s) => s.id(formMetadata.submission))
//         .getSingle();
//     final flatTemplate =
//         await FormFlatTemplate.fromTemplate(templateId: submission.form);
//     return flatTemplate;
//   }
//
//   return await appLocator.getAsync<FormFlatTemplate>(
//       param1: formMetadata.formId);
// }
