import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/form_option.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

Future<FormTemplate> getFormTemplate(String formId) async {
  final formTemplate = await DSdk.db.managers.formTemplates
      .filter((f) => f.id(formId))
      .getSingle();
  return formTemplate;
}

Future<FormTemplateVersion> getTemplateByVersionOrLatest(String id) async {
  /// try to get form versions by the specific form version Ids
  /// It would retrieve the specific versions of formTemplate
  final formTemplate = await DSdk.db.managers.formTemplateVersions
      .filter((f) => f.id(id))
      .orderBy((o) => o.versionNumber.desc())
      .limit(1)
      .getSingleOrNull();

  if (formTemplate != null) {
    return formTemplate;
  } else {
    /// try to get form versions by form template Ids
    /// if more than one value for the same formTemplate, take latest version

    final FormTemplateVersion? formTemplate = await DSdk
        .db.managers.formTemplateVersions
        .filter((f) => f.id.startsWith(id))
        .orderBy((o) => o.versionNumber.desc())
        .limit(1)
        .getSingleOrNull();

    return formTemplate!;
  }
}

Future<IMap<String, IList<FormOption>>> getOptionSets(
    FormTemplateVersion? template) async {
  final List<String> optionSets = (template?.fields ?? [])
      .where((t) => t.type?.isSelectType == true && t.optionSet != null)
      .map((t) => t.optionSet!)
      .toList();
  IMap<String, IList<FormOption>> optionLists = IMap();

  final List<DataOptionSet> formOptionSets = [];
  if (optionSets.isNotEmpty) {
    formOptionSets.addAll(await DSdk.dataOptionSet.getByIds(optionSets));
    optionLists = IMap.fromIterable(formOptionSets,
        keyMapper: (optionSet) => optionSet.id,
        valueMapper: (optionSet) => IList(
            optionSet.options..sort((p1, p2) => p1.order.compareTo(p2.order))));
  }
  return optionLists;
}
