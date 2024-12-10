import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/choice_filter.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/members/form_element_state.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormElementBuilder {
  static Map<String, FormElementInstance<dynamic>> buildFormElements(
      FormGroup form, FormFlatTemplate formFlatTemplate,
      {dynamic initialFormValue}) {
    final Map<String, FormElementInstance<dynamic>> elements = {};

    for (var template in formFlatTemplate.formTemplate.fields
      ..sort((a, b) => (a.order).compareTo(b.order))) {
      // template.fields.sort((a, b) => (a.order).compareTo(b.order));

      elements[template.name!] = buildFormElement(
          form, formFlatTemplate, template,
          initialFormValue: initialFormValue?[template.name]);
    }

    return elements;
  }

  static FormElementInstance<dynamic> buildFormElement(
      FormGroup form, FormFlatTemplate formFlatTemplate, Template template,
      {dynamic initialFormValue}) {
    if (template.isSection) {
      return buildSectionInstance(
          form, formFlatTemplate, template as SectionTemplate,
          initialFormValue: initialFormValue);
    } else if (template.isRepeat) {
      return buildRepeatInstance(
          form, formFlatTemplate, template as SectionTemplate,
          initialFormValue: initialFormValue);
    } else if (template.type == ValueType.ScannedCode) {
      return buildFieldInstance(
          form, formFlatTemplate, template as FieldTemplate,
          initialFormValue: initialFormValue);
    } else {
      return buildFieldInstance(
          form, formFlatTemplate, template as FieldTemplate,
          initialFormValue: initialFormValue);
    }
  }

  static SectionInstance buildSectionInstance(FormGroup rootFormControl,
      FormFlatTemplate formFlatTemplate, SectionTemplate template,
      {dynamic initialFormValue}) {
    final Map<String, FormElementInstance<dynamic>> elements = {};

    final section = SectionInstance(form: rootFormControl, template: template);

    for (var childTemplate in template.fields) {
      elements[childTemplate.name!] = buildFormElement(
          rootFormControl, formFlatTemplate, childTemplate,
          initialFormValue: initialFormValue?[childTemplate.name]);
    }
    section.addAll(elements);

    return section;
  }

  static RepeatItemInstance buildRepeatItem(FormGroup rootFormControl,
      FormFlatTemplate formFlatTemplate, SectionTemplate template,
      {Map<String, Object?>? initialFormValue, required String parentUid}) {
    final Map<String, FormElementInstance<dynamic>> elements = {};

    final repeatedSection = RepeatItemInstance(
        template: template,
        form: rootFormControl,
        parentUid: parentUid,
        uid: initialFormValue?['repeatUid'] as String?);
    for (var childTemplate
        in template.fields.sort((a, b) => (a.order).compareTo(b.order))) {
      elements[childTemplate.name!] = buildFormElement(
          rootFormControl, formFlatTemplate, childTemplate,
          initialFormValue: initialFormValue?[childTemplate.name]);
    }
    repeatedSection.addAll(elements);
    return repeatedSection;

    // final Map<String, FormElementInstance<dynamic>> elements = {};
    //
    // template.fields.sort((a, b) => (a.order).compareTo(b.order));
    // for (var childTemplate in template.fields) {
    //   elements[childTemplate.name] = buildFormElement(
    //       rootFormControl, childTemplate,
    //       initialFormValue: initialFormValue?[childTemplate.name]);
    // }
    //
    // final repeatedSection = RepeatItemInstance(
    //     template: template, form: rootFormControl, elements: elements);
    // return repeatedSection;
  }

  // static RepeatInstance buildScannedCode(FormGroup rootFormControl,
  //     FormFlatTemplate formFlatTemplate, ScannedCodeTemplate template,
  //     {List<dynamic>? initialFormValue}) {
  //   final List<RepeatItemInstance> elements = initialFormValue
  //       ?.map((value) => buildRepeatItem(
  //       rootFormControl, formFlatTemplate, template,
  //       initialFormValue: value,
  //       parentUid: value['parentUid'] as String))
  //       .toList() ??
  //       [];
  //
  //   final repeatedSection =
  //   RepeatInstance(template: template, form: rootFormControl);
  //
  //   repeatedSection.addAll(elements);
  //   return repeatedSection;
  // }

  static RepeatInstance buildRepeatInstance(FormGroup rootFormControl,
      FormFlatTemplate formFlatTemplate, SectionTemplate template,
      {List<dynamic>? initialFormValue}) {
    final List<RepeatItemInstance> elements = initialFormValue
            ?.map((value) => buildRepeatItem(
                rootFormControl, formFlatTemplate, template,
                initialFormValue: value,
                parentUid: value['parentUid'] as String))
            .toList() ??
        [];

    final repeatedSection =
        RepeatInstance(template: template, form: rootFormControl);

    repeatedSection.addAll(elements);
    return repeatedSection;
  }

  static FieldInstance<dynamic> buildFieldInstance(FormGroup rootFormControl,
      FormFlatTemplate formFlatTemplate, FieldTemplate templateElement,
      {dynamic initialFormValue}) {
    switch (templateElement.type) {
      case ValueType.Text:
      case ValueType.LongText:
      case ValueType.Letter:
      case ValueType.FullName:
      case ValueType.Date:
      case ValueType.Time:
      case ValueType.DateTime:
      case ValueType.OrganisationUnit:
        return FieldInstance<String>(
            form: rootFormControl,
            elementProperties: FieldElementState<String>(
                readOnly: templateElement.readOnly,
                value: initialFormValue,
                mandatory: templateElement.mandatory),
            template: templateElement);
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
        return FieldInstance<int>(
            form: rootFormControl,
            elementProperties: FieldElementState<int>(
                readOnly: templateElement.readOnly,
                value: initialFormValue,
                mandatory: templateElement.mandatory),
            template: templateElement);

      case ValueType.Number:
      case ValueType.UnitInterval:
      case ValueType.Percentage:
      case ValueType.Age:
        return FieldInstance<double>(
          form: rootFormControl,
          elementProperties: FieldElementState<double>(
              readOnly: templateElement.readOnly,
              value: initialFormValue,
              mandatory: templateElement.mandatory),
          template: templateElement,
        );
      case ValueType.Boolean:
      case ValueType.TrueOnly:
      case ValueType.YesNo:
        return FieldInstance<bool>(
          form: rootFormControl,
          elementProperties: FieldElementState<bool>(
              readOnly: templateElement.readOnly,
              value: initialFormValue,
              mandatory: templateElement.mandatory),
          template: templateElement,
        );
      case ValueType.SelectOne:
        return FieldInstance<String>(
          form: rootFormControl,
          choiceFilter: templateElement.choiceFilter != null
              ? ChoiceFilter(
                  expression: templateElement.evalChoiceFilterExpression,
                  options:
                      formFlatTemplate.optionLists[templateElement.listName!] ??
                          [])
              : null,
          elementProperties: FieldElementState<String>(
              readOnly: templateElement.readOnly,
              value: initialFormValue,
              mandatory: templateElement.mandatory,
              visibleOptions:
                  formFlatTemplate.optionLists[templateElement.listName!] ??
                      []),
          template: templateElement,
        );
      case ValueType.SelectMulti:
        return FieldInstance<List<String>>(
            form: rootFormControl,
            choiceFilter: templateElement.choiceFilter != null
                ? ChoiceFilter(
                    expression: templateElement.evalChoiceFilterExpression,
                    options: formFlatTemplate
                            .optionLists[templateElement.listName!] ??
                        [])
                : null,
            elementProperties: FieldElementState<List<String>>(
                readOnly: templateElement.readOnly,
                value: initialFormValue != null
                    ? (initialFormValue is List)
                        ? initialFormValue.cast<String>()
                        : <String>[initialFormValue]
                    : <String>[],
                mandatory: templateElement.mandatory,
                visibleOptions:
                    formFlatTemplate.optionLists[templateElement.listName!] ??
                        []),
            template: templateElement);
      case ValueType.Reference:
        return FieldInstance<String>(
          form: rootFormControl,
          elementProperties: FieldElementState<String>(
              readOnly: true, value: initialFormValue, mandatory: false),
          template: templateElement,
        );
      case ValueType.ScannedCode:
        return FieldInstance<String>(
          form: rootFormControl,
          elementProperties: FieldElementState<String>(
              readOnly: templateElement.readOnly,
              value: initialFormValue,
              mandatory: templateElement.mandatory),
          template: templateElement,
        );
      default:
        throw Exception('Unsupported element type: ${templateElement.type}');
    }
  }
}
