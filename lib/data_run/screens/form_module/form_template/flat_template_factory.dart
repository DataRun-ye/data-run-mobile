import 'package:d_sdk/core/form/form_traverse_extension.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/core/form/field_template/field_template.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';

class FlatTemplateFactory {
  FlatTemplateFactory(this._formVersion)
      : this._optionLists = Map.fromIterable(
            (_formVersion.options)
              ..sort((p1, p2) => p1.order.compareTo(p2.order)),
            key: (option) => option.listName,
            value: (option) => _formVersion.options
                .where((o) => o.listName == option.listName)
                .toList());

  final FormVersion _formVersion;
  final Map<String, List<FormOption>> _optionLists;

  List<FormElementTemplate> createFlatTemplate() {
    List<FormElementTemplate> result = [];
    for (var template in _formVersion.formFlatFields.values) {
      result.addAll(_flattenElementTemplate(template));
    }
    return result;
  }

  Iterable<FormElementTemplate> _flatSectionWithPath(List<Template> templates,
      {String? initialPath, String? initialRuntimePath}) {
    List<FormElementTemplate> result = [];
    for (var template in templates) {
      result.addAll(_flattenElementTemplate(template,
          prefix: initialPath, runtimePrefix: initialRuntimePath));
    }
    return result;
  }

  List<FormElementTemplate> _flattenElementTemplate(Template template,
      {String? prefix, String? runtimePrefix}) {
    List<FormElementTemplate> result = [];
    String fullPrefix =
        prefix != null ? '$prefix.${template.name}' : template.name!;
    String fullRuntimePrefix = runtimePrefix != null
        ? '$runtimePrefix.${template.name}.{key}'
        : '${template.name!}.{key}';
    if (template is SectionTemplate) {
      // template as SectionTemplate;
      result.add(SectionElementTemplate(
          id: template.id,
          name: template.name,
          label: template.label.unlockView,
          order: template.order,
          fieldValueRenderingType: template.fieldValueRenderingType,
          // path: fullPrefix,
          path: template.path,
          runtimePath: fullRuntimePrefix,
          properties: template.properties?.unlockView ?? {},
          rules: template.rules,
          itemTitle: template.itemTitle,
          isRepeat: template.isRepeat,
          // fieldValueRenderingType: template.fieldValueRenderingType,
          ruleDependencies: template.dependencies,
          // children: flatTemplateWithPath(template.fields.unlockView,
          //     initialPath: fullPrefix, initialRuntimePath: fullRuntimePrefix)));
          // children: _flatSectionWithPath(template.treeFields.unlockView,
          //     initialPath: fullPrefix, initialRuntimePath: fullRuntimePrefix)));
          children: _flatSectionWithPath(
              _formVersion.getImmediateChildren(template.path!),
              initialPath: fullPrefix,
              initialRuntimePath: fullRuntimePrefix)));
      // result.addAll(
      //     flatTemplateWithPath(template.fields, initialPath: fullPrefix));
    }
    /*else if (template.isRepeat) {
      template as SectionTemplate;
      result.add(RepeatElementTemplate(
          id: template.id,
          name: template.name,
          label: template.label.unlockView,
          order: template.order,
          fieldValueRenderingType: template.fieldValueRenderingType,
          path: template.path,
          // path: fullPrefix,
          runtimePath: fullRuntimePrefix,
          properties: template.properties?.unlockView ?? {},
          rules: template.rules,
          itemTitle: template.itemTitle,
          ruleDependencies: template.dependencies,
          // pathTemplate: '${fullPrefix}.{key}',
          // children: flatTemplateWithPath(template.fields.unlockView,
          //     initialPath: fullPrefix, initialRuntimePath: fullRuntimePrefix))
          children: _flatSectionWithPath(
              _formVersion.getImmediateChildren(template.path!),
              initialPath: fullPrefix,
              initialRuntimePath: fullRuntimePrefix)));
    }*/
    else if (template is FieldTemplate) {
      // template as FieldTemplate;
      result.add(FieldElementTemplate(
        id: template.id,
        type: template.type!,
        readOnly: template.readOnly,
        name: template.name,
        order: template.order,
        listName: template.listName,
        label: template.label.unlockView,
        path: template.path,
        // path: fullPrefix,
        runtimePath: fullRuntimePrefix,
        mandatory: template.mandatory,
        gs1Enabled: template.gs1Enabled,
        mainField: template.mainField,
        rules: template.rules,
        choiceFilter: template.choiceFilter,
        defaultValue: template.defaultValue,
        options: template.listName != null
            ? _optionLists[template.listName] ?? []
            : [],
        // options: _formVersion.options,
        calculation: template.calculation,
        calculationDependencies: template.calculationDependencies,
        scannedCodeProperties: template.scannedCodeProperties,
        filterDependencies: template.filterDependencies,
        ruleDependencies: template.dependencies,
      ));
    }

    return result;
  }
}
