import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/data.dart';
import 'package:datarunmobile/data/form_template_list_service.dart';
import 'package:datarunmobile/features/form/application/form_list_filter.dart';
import 'package:datarunmobile/features/form/application/form_list_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@riverpod
Future<List<FormListItemModel>> formListItems(
    Ref ref, FormListFilter filter) async {
  final templates =
      await appLocator<FormTemplateListService>().fetchByFilter(filter);
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
Future<List<Pair<AssignmentForm, bool>>> availableUserFormTemplates(Ref ref,
    {String? assignmentId}) async {
  return appLocator<FormTemplateListService>()
      .userAvailableForms(assignment: assignmentId);
}

@riverpod
Future<Map<String, List<DataOption>>> formTemplateOptions(Ref ref,
    {required String formId, String? versionId}) async {
  final FormTemplateModel formTemplate =
      await appLocator<FormTemplateListService>().getTemplateByVersionOrLatest(
          templateId: formId, versionId: versionId);

  return appLocator<OptionSetService>().getOptions(formTemplate);
}

@riverpod
Future<DataOptionSet?> optionSet(Ref ref, {required String id}) async {
  return appLocator<OptionSetService>().getOptionSet(id);
}

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
@riverpod
Future<FormTemplateModel> formTemplate(Ref ref,
    {String? formId, String? versionId}) async {
  final form = await appLocator<FormTemplateListService>()
      .getTemplateByVersionOrLatest(templateId: formId, versionId: versionId);
  return form;
}
