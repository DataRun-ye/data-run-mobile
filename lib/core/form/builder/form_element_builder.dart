import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/rule/calculated_Expression.dart';
import 'package:d_sdk/core/form/rule/choice_filter.dart';
import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormElementBuilder {
  static Map<String, FormElementInstance<dynamic>> buildFormElements(
      FormGroup form, FormTemplateRepository formTemplateVersion,
      {dynamic initialFormValue}) {
    final Map<String, FormElementInstance<dynamic>> elements = {};

    for (var template in formTemplateVersion.rootSection.children) {
      elements[template.name!] = buildFormElement(
          form, formTemplateVersion, template,
          initialFormValue: initialFormValue?[template.name]);
    }

    return elements;
  }

  static FormElementInstance<dynamic> buildFormElement(FormGroup form,
      FormTemplateRepository formFlatTemplate, Template template,
      {dynamic initialFormValue}) {
    if (template is SectionTemplate) {
      if (template.repeatable) {
        return buildRepeatInstance(form, formFlatTemplate, template,
            initialFormValue: initialFormValue);
      }
      return buildSectionInstance(form, formFlatTemplate, template,
          initialFormValue: initialFormValue);
    } else {
      return buildFieldInstance(
          form, formFlatTemplate, template as FieldTemplate,
          initialValue: initialFormValue);
    }
  }

  static Section buildSectionInstance(FormGroup rootFormControl,
      FormTemplateRepository formFlatTemplate, SectionTemplate template,
      {dynamic initialFormValue}) {
    final Map<String, FormElementInstance<dynamic>> elements = {};

    final section = Section(form: rootFormControl, template: template);

    for (var childTemplate in template.children) {
      elements[childTemplate.name!] = buildFormElement(
          rootFormControl, formFlatTemplate, childTemplate,
          initialFormValue: initialFormValue?[childTemplate.name]);
    }
    section.addAll(elements);

    return section;
  }

  static RepeatItemInstance buildRepeatItem(FormGroup rootFormControl,
      FormTemplateRepository formFlatTemplate, SectionTemplate template,
      {Map<String, Object?>? initialFormValue}) {
    final Map<String, FormElementInstance<dynamic>> elements = {};

    final repeatedSection = RepeatItemInstance(
        template: template,
        form: rootFormControl,
        // parentUid: parentUid,
        uid: initialFormValue?['repeatUid'] as String?);
    for (var childTemplate in template.children) {
      elements[childTemplate.name!] = buildFormElement(
          rootFormControl, formFlatTemplate, childTemplate,
          initialFormValue: initialFormValue?[childTemplate.name]);
    }
    repeatedSection.addAll(elements);
    return repeatedSection;
  }

  static RepeatSection buildRepeatInstance(FormGroup rootFormControl,
      FormTemplateRepository formFlatTemplate, SectionTemplate template,
      {List<dynamic>? initialFormValue}) {
    final List<RepeatItemInstance> elements = initialFormValue
            ?.map((value) => buildRepeatItem(
                  rootFormControl,
                  formFlatTemplate,
                  template,
                  initialFormValue: value,
                ))
            .toList() ??
        [];

    final repeatedSection =
        RepeatSection(template: template, form: rootFormControl);

    repeatedSection.addAll(elements);
    return repeatedSection;
  }

  static FieldInstance<dynamic> buildFieldInstance(FormGroup rootFormControl,
      FormTemplateRepository formFlatTemplate, FieldTemplate elementTemplate,
      {dynamic initialValue}) {
    final initValue = initialValue ?? elementTemplate.defaultValue;
    switch (elementTemplate.type) {
      case ValueType.Text:
      case ValueType.LongText:
      case ValueType.Letter:
      case ValueType.FullName:
      case ValueType.OrganisationUnit:
      case ValueType.Team:
      case ValueType.Progress:
      case ValueType.Age:
        return FieldInstance<String>(
            form: rootFormControl,
            elementProperties: FieldElementState<String>(
                readOnly: elementTemplate.readOnly,
                value: initValue,
                mandatory: elementTemplate.mandatory),
            template: elementTemplate);
      case ValueType.Date:
      case ValueType.Time:
      case ValueType.DateTime:
        return FieldInstance<String>(
            form: rootFormControl,
            elementProperties: FieldElementState<String>(
                readOnly: elementTemplate.readOnly,
                value: initialValue,
                mandatory: elementTemplate.mandatory),
            template: elementTemplate);

      case ValueType.Calculated:
        return CalculatedFieldInstance<dynamic>(
            form: rootFormControl,
            calculatedExpression: CalculatedExpression(
                expression: elementTemplate.calculationExpression!),
            elementProperties: FieldElementState<dynamic>(
                readOnly: true, value: initialValue, mandatory: false),
            template: elementTemplate);
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
        final initValue = initialValue ??
            (elementTemplate.defaultValue != null
                ? elementTemplate.defaultValue is int
                    ? elementTemplate.defaultValue
                    : int.tryParse(elementTemplate.defaultValue)
                : null);
        return FieldInstance<int>(
            form: rootFormControl,
            elementProperties: FieldElementState<int>(
                readOnly: elementTemplate.readOnly,
                value: initValue,
                mandatory: elementTemplate.mandatory),
            template: elementTemplate);

      case ValueType.Number:
      case ValueType.UnitInterval:
      case ValueType.Percentage:
        final initValue = initialValue ??
            (elementTemplate.defaultValue != null
                ? elementTemplate.defaultValue is int
                    ? elementTemplate.defaultValue
                    : double.tryParse(elementTemplate.defaultValue)
                : null);
        return FieldInstance<double>(
          form: rootFormControl,
          elementProperties: FieldElementState<double>(
              readOnly: elementTemplate.readOnly,
              value: initValue,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      case ValueType.Boolean:
      case ValueType.TrueOnly:
      case ValueType.YesNo:
        return FieldInstance<bool>(
          form: rootFormControl,
          elementProperties: FieldElementState<bool>(
              readOnly: elementTemplate.readOnly,
              value: initialValue ?? elementTemplate.defaultValue,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      case ValueType.SelectOne:
        return FieldInstance<String>(
          form: rootFormControl,
          choiceFilter: elementTemplate.choiceFilter != null
              ? ChoiceFilter(
                  expression: elementTemplate.evalChoiceFilterExpression,
                  options: formFlatTemplate
                          .optionMap[elementTemplate.optionSet!]
                          ?.toList() ??
                      [])
              : null,
          elementProperties: FieldElementState<String>(
              readOnly: elementTemplate.readOnly,
              value: initValue,
              mandatory: elementTemplate.mandatory,
              visibleOptions: formFlatTemplate
                      .optionMap[elementTemplate.optionSet!]
                      ?.toList() ??
                  []),
          template: elementTemplate,
        );
      case ValueType.SelectMulti:
        return FieldInstance<List<String>>(
            form: rootFormControl,
            choiceFilter: elementTemplate.choiceFilter != null
                ? ChoiceFilter(
                    expression: elementTemplate.evalChoiceFilterExpression,
                    options: formFlatTemplate
                            .optionMap[elementTemplate.optionSet!]
                            ?.toList() ??
                        [])
                : null,
            elementProperties: FieldElementState<List<String>>(
                readOnly: elementTemplate.readOnly,
                value: initialValue != null
                    ? (initialValue is List)
                        ? initialValue.cast<String>()
                        : <String>[initialValue]
                    : <String>[],
                mandatory: elementTemplate.mandatory,
                visibleOptions: formFlatTemplate
                        .optionMap[elementTemplate.optionSet!]
                        ?.toList() ??
                    []),
            template: elementTemplate);
      case ValueType.Reference:
        return FieldInstance<String>(
          form: rootFormControl,
          elementProperties: FieldElementState<String>(
              readOnly: elementTemplate.readOnly,
              value: initialValue,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      case ValueType.ScannedCode:
        return FieldInstance<String>(
          form: rootFormControl,
          elementProperties: FieldElementState<String>(
              readOnly: elementTemplate.readOnly,
              value: initialValue,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      default:
        throw Exception('Unsupported element type: ${elementTemplate.type}');
    }
  }
}
