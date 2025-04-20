import 'dart:async';

import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:datarunmobile/data/template.provider.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_configuration.provider.g.dart';

@riverpod
Future<FormConfiguration> formConfiguration(FormConfigurationRef ref,
    {required String form, required int version}) async {
  final FormVersion? formTemplateVersion = await ref
      .watch(formVersionAsyncProvider(form: form, version: version).future);

  Iterable<String> orgUnits = [];

  // if (formTemplateVersion != null) {
  //   final assignments = await D2Remote.assignmentModuleD.assignment
  //       .byActivity(formTemplateVersion.activity)
  //       .get();
  //   final assigned =
  //       assignments.where((a) => a.orgUnit != null).map((a) => a.orgUnit!);
  //   orgUnits = orgUnits.where((o) => assigned.contains(o));
  // }

  return FormConfiguration(
      label: IMap(formTemplateVersion!.label),
      fields: formTemplateVersion.treeFields.unlock,
      options: formTemplateVersion.options,
      orgUnits: orgUnits.toList());
}

class FormConfiguration {
  FormConfiguration(
      {required List<Template> fields,
      required List<FormOption> options,
      required this.label,
      required List<String> orgUnits})
      : this.allFields = IMap.fromIterable<String, Template, Template>(fields,
            keyMapper: (Template field) => field.path!,
            valueMapper: (Template field) => field)
        /*this.allFields = IMap.fromIterable<String, Template, Template>(
            getDfsTemplateIterator(SectionTemplate(fields: fields))
                .where((t) => t.path != null),
            keyMapper: (Template field) => field.path!,
            valueMapper: (Template field) => field)*/
        ,
        this.optionLists =
            IMap.fromIterable<String, IList<FormOption>, FormOption>(
                (options)..sort((p1, p2) => p1.order.compareTo(p2.order)),
                keyMapper: (FormOption option) => option.listName,
                valueMapper: (FormOption option) => options
                    .where((o) => o.listName == option.listName)
                    .toIList()),
        this.orgUnitTreeUids = IList(orgUnits);

  final IMap<String, String> label;

  /// {field.path: field}
  final IMap<String, Template> allFields;

  /// {listName: List<option>}
  final IMap<String, IList<FormOption>> optionLists;

  final IList<String> orgUnitTreeUids;

  FormOption? getOption(String listName, value) =>
      optionLists.get(listName)?.where((t) => t.name == value).firstOrNull;

  // dynamic getUserFriendlyValue(String fieldName, dynamic value) =>
  //     switch (allFields.get(fieldName)) {
  //       FieldTemplate(type: final type, listName: final listName?)
  //           when type?.selectTypes == true =>
  //         getItemLocalString(getOption(listName, value)?.label.unlockView,
  //             defaultString: value),
  //       FieldTemplate(type: final type) when type?.isDate == true =>
  //         DDateUtils.format(value) ??
  //             DDateUtils.uiDateFormat().tryParse(value ?? '') ??
  //             value,
  //       FieldTemplate(type: final type) when type?.isDateTime == true =>
  //         DDateUtils.dateTimeFormat().tryParse(value ?? '') ?? value,
  //       FieldTemplate(type: final type) when type?.isTime == true =>
  //         DDateUtils.twelveHourTimeFormat().tryParse(value ?? '') ?? value,
  //       _ => value
  //     };

  String getFieldDisplayName(String fieldName) =>
      getItemLocalString(allFields.get(fieldName)?.label.unlockView,
          defaultString: fieldName);
}
