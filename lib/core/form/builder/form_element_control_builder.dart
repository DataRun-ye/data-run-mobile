import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormElementControlBuilder {
  static Map<String, AbstractControl<dynamic>> formDataControls(
      FormFlatTemplate formFlatTemplate, initialValue) {
    final Map<String, AbstractControl<dynamic>> controls = {};

    for (var element in formFlatTemplate.formTemplate.treeFields) {
      controls[element.name!] = createElementControl(formFlatTemplate, element,
          initialValue: initialValue?[element.name]);
    }

    return controls;
  }

  static AbstractControl<dynamic> createElementControl(
      FormFlatTemplate formFlatTemplate, Template fieldTemplate,
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
      FormFlatTemplate formFlatTemplate, SectionTemplate fieldTemplate,
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
      FormFlatTemplate formFlatTemplate, SectionTemplate fieldTemplate,
      {dynamic initialValue}) {
    final formArray = FormArray<Map<String, Object?>>((initialValue ?? [])
        .map<FormGroup>((e) => createSectionFormGroup(
            formFlatTemplate, fieldTemplate,
            initialValue: e))
        .toList());

    return formArray;
  }

  static AbstractControl<dynamic> createFieldFormControl(
      formFlatTemplate, FieldTemplate fieldTemplate,
      {initialValue}) {
    switch (fieldTemplate.type) {
      case ValueType.Text:
      case ValueType.OrganisationUnit:
      case ValueType.Team:
      case ValueType.Progress:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Calculated:
        return FormControl<dynamic>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.LongText:
      case ValueType.Letter:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.FullName:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Email:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Boolean:
      case ValueType.TrueOnly:
      case ValueType.YesNo:
        return FormControl<bool>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Date:
      case ValueType.DateTime:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Integer:
      case ValueType.IntegerPositive:
      case ValueType.IntegerNegative:
      case ValueType.IntegerZeroOrPositive:
        return FormControl<int>(
          value: initialValue ?? int.tryParse(fieldTemplate.defaultValue ?? ''),
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Number:
      case ValueType.Age:
      case ValueType.Percentage:
        return FormControl<double>(
          value:
              initialValue ?? double.tryParse(fieldTemplate.defaultValue ?? ''),
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.SelectOne:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.SelectMulti:
        return FormControl<List<String>>(
            value: initialValue != null
                ? (initialValue is List)
                    ? initialValue.cast<String>()
                    : <String>[initialValue]
                : <String>[]);
      case ValueType.Reference:
        return FormControl<String>(
            value: initialValue ??
                fieldTemplate.defaultValue /*, disabled: true*/);
      case ValueType.ScannedCode:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      default:
        throw UnsupportedError(
            'Template: ${fieldTemplate.name}, unsupported element type: ${fieldTemplate.type}');
    }
  }
}
