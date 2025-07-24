import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormElementControlBuilder {
  static Map<String, AbstractControl<dynamic>> formDataControls(
      FormTemplateRepository formFlatTemplate, initialValue) {
    final Map<String, AbstractControl<dynamic>> controls = {};

    for (var element in formFlatTemplate.rootSection.children) {
      controls[element.name!] = createElementControl(formFlatTemplate, element,
          initialValue: initialValue?[element.name]);
    }

    return controls;
  }

  static AbstractControl<dynamic> createElementControl(
      FormTemplateRepository formFlatTemplate, Template fieldTemplate,
      {initialValue}) {
    if (fieldTemplate is SectionTemplate) {
      if (fieldTemplate.repeatable) {
        return createRepeatFormArray(formFlatTemplate, fieldTemplate,
            initialValue: initialValue);
      }
      return createSectionFormGroup(formFlatTemplate, fieldTemplate,
          initialValue: initialValue);
    } else {
      return createFieldFormControl(
          formFlatTemplate, fieldTemplate as FieldTemplate,
          initialValue: initialValue);
    }
  }

  static FormGroup createSectionFormGroup<T>(
      FormTemplateRepository formFlatTemplate, SectionTemplate fieldTemplate,
      {dynamic initialValue}) {
    final Map<String, AbstractControl<dynamic>> controls = {};

    for (var childTemplate in fieldTemplate.children) {
      controls[childTemplate.name!] = createElementControl(
          formFlatTemplate, childTemplate,
          initialValue: initialValue?[childTemplate.name]);
    }
    return FormGroup(controls);
  }

  static FormArray<Map<String, Object?>> createRepeatFormArray(
      FormTemplateRepository formFlatTemplate, SectionTemplate fieldTemplate,
      {dynamic initialValue}) {
    final formArray = FormArray<Map<String, Object?>>((initialValue ?? [])
        .map<FormGroup>((e) => createSectionFormGroup(
            formFlatTemplate, fieldTemplate,
            initialValue: e))
        .toList());

    return formArray;
  }

  static AbstractControl<dynamic> createFieldFormControl(
      FormTemplateRepository formFlatTemplate, FieldTemplate elementTemplate,
      {initialValue}) {
    final initValue = initialValue ?? elementTemplate.defaultValue;
    final validators = FieldValidators.getValidators(elementTemplate);
    switch (elementTemplate.type) {
      case ValueType.Text:
      case ValueType.OrganisationUnit:
      case ValueType.Team:
      case ValueType.Age:
      case ValueType.Progress:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
      case ValueType.Calculated:
        return FormControl<dynamic>(
          value: initValue,
          validators: validators,
        );
      case ValueType.LongText:
      case ValueType.Letter:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
      case ValueType.FullName:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
      case ValueType.Email:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
      case ValueType.Boolean:
      case ValueType.TrueOnly:
      case ValueType.YesNo:
        return FormControl<bool>(
          value: initValue,
          validators: validators,
        );
      case ValueType.Date:
      case ValueType.DateTime:
      case ValueType.Time:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
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
        return FormControl<int>(
          value: initValue,
          validators: validators,
        );
      case ValueType.Number:
      case ValueType.Percentage:
        final initValue = initialValue ??
            (elementTemplate.defaultValue != null
                ? elementTemplate.defaultValue is int
                    ? elementTemplate.defaultValue
                    : double.tryParse(elementTemplate.defaultValue)
                : null);
        return FormControl<double>(
          value: initValue,
          validators: validators,
        );
      case ValueType.SelectOne:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
      case ValueType.SelectMulti:
        final value = initialValue != null
            ? (initialValue is List)
                ? initialValue.cast<String>()
                : <String>[initialValue]
            : <String>[];
        final multiValidator = <Validator<dynamic>>[];
        return FormControl<List<String>>(
            value: initialValue != null
                ? (initialValue is List)
                    ? initialValue.cast<String>()
                    : <String>[initialValue]
                : <String>[],
            validators: multiValidator
              ..addIf(value.isEmpty && elementTemplate.mandatory,
                  Validators.required));
      case ValueType.Reference:
        return FormControl<String>(value: initValue, validators: validators);
      case ValueType.ScannedCode:
        return FormControl<String>(
          value: initValue,
          validators: validators,
        );
      default:
        throw UnsupportedError(
            'Template: ${elementTemplate.name}, unsupported element type: ${elementTemplate.type}');
    }
  }
}
