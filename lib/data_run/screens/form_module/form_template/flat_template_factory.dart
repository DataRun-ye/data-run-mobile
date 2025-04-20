import 'dart:async';

import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FlatTemplateFactory {
  FlatTemplateFactory(
      this._formVersion, IMap<String, IList<FormOption>> optionLists)
      : this._optionLists = optionLists;

  final FormVersion _formVersion;
  IMap<String, IList<FormOption>> _optionLists;

  FutureOr<List<FormElementTemplate>> createFlatTemplate() async {
    List<FormElementTemplate> result = [];
    for (var template in _formVersion.treeFields) {
      result.addAll(await _flattenElementTemplate(template));
    }
    return result;
  }

  List<FormElementTemplate> _flatSectionWithPath(List<Template> templates,
      {String? initialPath}) {
    List<FormElementTemplate> result = [];
    for (var template in templates) {
      result.addAll(_flattenElementTemplate(template, prefix: initialPath));
    }
    return result;
  }

  List<FormElementTemplate> _flattenElementTemplate(Template template,
      {String? prefix}) {
    List<FormElementTemplate> result = [];
    String fullPrefix =
        prefix != null ? '$prefix.${template.name}' : template.name!;
    if (template is SectionTemplate) {
      // template as SectionTemplate;
      result.add(SectionElementTemplate(
          id: template.id,
          name: template.name,
          label: template.label.unlockView,
          order: template.order,
          fieldValueRenderingType: template.fieldValueRenderingType,
          path: template.path,
          namePath: fullPrefix,
          properties: template.properties?.unlockView ?? {},
          rules: template.rules,
          itemTitle: template.itemTitle,
          repeatable: template.repeatable,
          // fieldValueRenderingType: template.fieldValueRenderingType,
          ruleDependencies: template.dependencies,
          children: _flatSectionWithPath(
              _formVersion.getImmediateChildren(template.path),
              initialPath: fullPrefix)));
    } else if (template is FieldTemplate) {
      result.add(FieldElementTemplate(
        id: template.id,
        type: template.type!,
        readOnly: template.readOnly,
        name: template.name,
        order: template.order,
        listName: template.listName,
        label: template.label.unlockView,
        path: template.path,
        namePath: fullPrefix,
        mandatory: template.mandatory,
        gs1Enabled: template.gs1Enabled,
        mainField: template.mainField,
        rules: template.rules,
        choiceFilter: template.choiceFilter,
        defaultValue: template.defaultValue,
        options: template.optionSet != null
            ? _optionLists[template.optionSet!] ?? []
            : [],
        calculation: template.calculation,
        calculationDependencies: template.calculationDependencies,
        scannedCodeProperties: template.scannedCodeProperties,
        filterDependencies: template.filterDependencies,
        ruleDependencies: template.dependencies,
      ));
    }

    return result;
  }

  // 3) Optional: sort each node’s children by the `order` property:
  void sortRecursively(List<Template> list) {
    list.sort((a, b) => a.order.compareTo(b.order));
    for (var n in list) {
      if (n.children.isNotEmpty) sortRecursively(n.children);
    }
  }
}
