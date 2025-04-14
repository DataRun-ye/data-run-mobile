import 'package:d_sdk/core/form/field_template/field_template.dart';
import 'package:d_sdk/core/form/form_traverse_extension.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TemplateFormControlBuilder {
  static AbstractControl<dynamic> createElementControl(Template fieldTemplate,
      {initialValue}) {
    if (fieldTemplate.isSection) {
      return createSectionFormGroup(fieldTemplate as SectionTemplate,
          initialValue: initialValue);
    } else if (fieldTemplate.isRepeat) {
      return createRepeatFormArray(fieldTemplate as SectionTemplate,
          initialValue: initialValue);
    } else {
      return createFieldFormControl(fieldTemplate as FieldTemplate,
          initialValue: initialValue);
    }
  }

  static FormGroup createSectionFormGroup<T>(SectionTemplate fieldTemplate,
      {dynamic initialValue}) {
    final Map<String, AbstractControl<dynamic>> controls = {};
    // fieldTemplate.fields.sort((a, b) => (a.order).compareTo(b.order));

    for (var childTemplate
        in fieldTemplate.fields.sort((a, b) => (a.order).compareTo(b.order))) {
      controls[childTemplate.name!] = createElementControl(childTemplate,
          initialValue: initialValue?[childTemplate.name]);
    }
    return FormGroup(controls);
  }

  static FormArray<Map<String, Object?>> createRepeatFormArray(
      SectionTemplate fieldTemplate,
      {dynamic initialValue}) {
    final formArray = FormArray<Map<String, Object?>>((initialValue ?? [])
        .map<FormGroup>(
            (e) => createSectionFormGroup(fieldTemplate, initialValue: e))
        .toList());

    return formArray;
  }

  static FormControl<dynamic> createFieldFormControl(
      FieldTemplate fieldTemplate,
      {initialValue}) {
    switch (fieldTemplate.type) {
      case ValueType.Text:
      case ValueType.OrganisationUnit:
      case ValueType.Team:
        return FormControl<String>(
          value: initialValue ?? fieldTemplate.defaultValue,
          validators: FieldValidators.getValidators(fieldTemplate),
        );
      case ValueType.Progress:
        return FormControl<String>(
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
        return FormControl<List<String>>(value: initialValue ?? []);
      case ValueType.Reference:
        return FormControl<String>(disabled: true);
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
