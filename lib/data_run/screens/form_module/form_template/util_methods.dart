import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option.entity.dart';
import 'package:d2_remote/modules/metadatarun/option_set/entities/option_set.entity.dart';
import 'package:d2_remote/shared/utilities/sort_order.util.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

Future<FormVersion> getTemplateByVersionOrLatest(String id) async {
  /// try to get form versions by the specific form version Ids
  /// It would retrieve the specific versions of formTemplate
  final formTemplate = await D2Remote.formModule.formTemplateV
      .where(attribute: 'formTemplate', value: id)
      .orderBy(attribute: 'versionNumber', sortOrder: SortOrder.DESC)
      .getOne();

  if (formTemplate != null) {
    return formTemplate;
  } else {
    /// try to get form versions by form template Ids
    /// if more than one value for the same formTemplate, take latest version
    final FormVersion? formTemplate = await D2Remote.formModule.formTemplateV
        .where(attribute: 'formTemplate', value: id)
        .orderBy(attribute: 'versionNumber', sortOrder: SortOrder.DESC)
        .getOne();

    return formTemplate!;
  }
}

Future<Map<String, List<Option>>> getOptionSets(FormVersion? template) async {
  final List<String> optionSets = (template?.fields ?? IList())
      .where((t) => t.type?.isSelectType == true && t.optionSet != null)
      .map((t) => t.optionSet!)
      .toList();
  Map<String, List<Option>> optionLists = {};

  final List<OptionSet> formOptionSets = [];
  if (optionSets.isNotEmpty) {
    formOptionSets.addAll(await D2Remote.optionSetModule.optionSet
        .byIds(optionSets)
        .withOptions()
        .get());
    optionLists = IMap.fromIterable(formOptionSets,
            keyMapper: (optionSet) => optionSet.id!,
            valueMapper: (optionSet) => (optionSet.options ?? [])
              ..sort(
                  (p1, p2) => p1.sortOrder.compareTo(p2.sortOrder)))
        .unlockView;
  }
  return optionLists;
}
