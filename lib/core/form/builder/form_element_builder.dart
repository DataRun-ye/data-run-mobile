import 'package:datarunmobile/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/form/rule/calculated_Expression.dart';
import 'package:datarunmobile/core/form/rule/choice_filter.dart';
import 'package:datarunmobile/core/form/rule/rule_parse_extension.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
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
        return buildRepeatSection(form, formFlatTemplate, template,
            initialFormValue: initialFormValue);
      }
      return buildSectionInstance(form, formFlatTemplate, template,
          initialFormValue: initialFormValue);
    } else {
      return buildFieldInstance(
        form,
        formFlatTemplate,
        template as FieldTemplate,
        initialFormValue: initialFormValue,
      );
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
        uid: RepeatMetadataNormalizer.readRepeatRowId(initialFormValue));
    for (var childTemplate in template.children) {
      elements[childTemplate.name!] = buildFormElement(
          rootFormControl, formFlatTemplate, childTemplate,
          initialFormValue: initialFormValue?[childTemplate.name]);
    }
    repeatedSection.addAll(elements);
    return repeatedSection;
  }

  static RepeatSection buildRepeatSection(FormGroup rootFormControl,
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
      {dynamic initialFormValue}) {
    final retainedValue = FormElementControlBuilder.initialFieldValue(
      elementTemplate,
      initialFormValue,
    );
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
            initialValue: retainedValue,
            elementProperties: FieldElementState<String>(
                readOnly: elementTemplate.readOnly,
                mandatory: elementTemplate.mandatory),
            template: elementTemplate);
      case ValueType.Date:
      case ValueType.Time:
      case ValueType.DateTime:
        return FieldInstance<String>(
            form: rootFormControl,
            initialValue: retainedValue,
            elementProperties: FieldElementState<String>(
                readOnly: elementTemplate.readOnly,
                mandatory: elementTemplate.mandatory),
            template: elementTemplate);

      case ValueType.Calculated:
        return CalculatedFieldInstance<dynamic>(
            form: rootFormControl,
            initialValue: retainedValue,
            calculatedExpression: CalculatedExpression(
                expression: elementTemplate.calculationExpression!),
            elementProperties:
                FieldElementState<dynamic>(readOnly: true, mandatory: false),
            template: elementTemplate);
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
        return FieldInstance<int>(
            form: rootFormControl,
            initialValue: retainedValue,
            elementProperties: FieldElementState<int>(
                readOnly: elementTemplate.readOnly,
                mandatory: elementTemplate.mandatory),
            template: elementTemplate);

      case ValueType.Number:
      case ValueType.UnitInterval:
      case ValueType.Percentage:
        return FieldInstance<double>(
          form: rootFormControl,
          initialValue: retainedValue,
          elementProperties: FieldElementState<double>(
              readOnly: elementTemplate.readOnly,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      case ValueType.Boolean:
      case ValueType.TrueOnly:
      case ValueType.YesNo:
        return FieldInstance<bool>(
          form: rootFormControl,
          initialValue: retainedValue,
          elementProperties: FieldElementState<bool>(
              readOnly: elementTemplate.readOnly,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      case ValueType.SelectOne:
        return FieldInstance<String>(
          form: rootFormControl,
          initialValue: retainedValue,
          choiceFilter: elementTemplate.choiceFilter != null
              ? ChoiceFilter(
                  expression: elementTemplate.choiceFilter,
                  options: formFlatTemplate
                          .optionMap[elementTemplate.optionSet!]
                          ?.toList() ??
                      [])
              : null,
          elementProperties: FieldElementState<String>(
              readOnly: elementTemplate.readOnly,
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
            initialValue: retainedValue,
            choiceFilter: elementTemplate.choiceFilter != null
                ? ChoiceFilter(
                    expression: elementTemplate.choiceFilter,
                    options: formFlatTemplate
                            .optionMap[elementTemplate.optionSet!]
                            ?.toList() ??
                        [])
                : null,
            elementProperties: FieldElementState<List<String>>(
                readOnly: elementTemplate.readOnly,
                mandatory: elementTemplate.mandatory,
                visibleOptions: formFlatTemplate
                        .optionMap[elementTemplate.optionSet!]
                        ?.toList() ??
                    []),
            template: elementTemplate);
      case ValueType.Reference:
        return FieldInstance<String>(
          form: rootFormControl,
          initialValue: retainedValue,
          elementProperties: FieldElementState<String>(
              readOnly: elementTemplate.readOnly,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      case ValueType.ScannedCode:
        return FieldInstance<String>(
          form: rootFormControl,
          initialValue: retainedValue,
          elementProperties: FieldElementState<String>(
              readOnly: elementTemplate.readOnly,
              mandatory: elementTemplate.mandatory),
          template: elementTemplate,
        );
      default:
        throw Exception('Unsupported element type: ${elementTemplate.type}');
    }
  }
}
