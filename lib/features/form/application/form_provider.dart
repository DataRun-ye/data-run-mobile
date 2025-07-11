import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/data.dart';
import 'package:datarunmobile/data/form_template_service.dart';
import 'package:datarunmobile/data/option_set_service.dart';
import 'package:datarunmobile/features/form/application/form_list_filter.dart';
import 'package:datarunmobile/features/form/application/form_list_item_model.dart';
import 'package:datarunmobile/features/form/application/form_template_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@riverpod
Future<List<FormListItemModel>> assignmentFormSelectionItems(
    Ref ref, String assignment) async {
  userAvailableFormsProvider();
  final templates =
      await appLocator<FormTemplateService>().fetchByAssignment(assignment);
  return templates
      .map((t) => FormListItemModel(
            id: t.id,
            name: t.name,
            description: t.description,
            label: t.label,
            versionNumber: t.versionNumber,
            versionUid: t.versionUid,
          ))
      .toList();
}

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
            description: t.description,
            versionUid: t.versionUid,
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
