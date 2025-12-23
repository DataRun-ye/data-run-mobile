import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/full_name_validator.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FieldValidators {
  static String ArReg1 =
      r'^[\u0621-\u064A]{2,}[ ]{1}[\u0621-\u064A]{2,}[ ]{1}[\u0621-\u064A]{2,}[ ]{1}[\u0621-\u064A]{2,}[ ]{0,1}[\u0621-\u064A]{0,}[ ]{0,1}$';

  static List<Validator<dynamic>> getValidators(FieldTemplate element) {
    Set<Validator<dynamic>> validators = Set();

    // if (element.type == ValueType.FullName)
    //   validators.add(Validators.pattern(ArReg1));
    if (element.type == ValueType.FullName)
      validators.add(const ArEnFullNameValidator());

    if (element.mandatory) validators.add(Validators.required);
    if (element.type == ValueType.Email) validators.add(Validators.email);
    if (element.type.isInteger) validators.add(Validators.number());
    if (element.type == ValueType.IntegerZeroOrPositive)
      validators.addAll(
          [Validators.number(allowNegatives: false), Validators.min(0)]);
    if (element.type == ValueType.IntegerNegative)
      validators.addAll([Validators.number(), Validators.max(-1)]);
    if (element.type == ValueType.IntegerPositive)
      validators.add(Validators.min(1));
    if (element.type == ValueType.Percentage)
      validators.addAll([Validators.min(0), Validators.maxLength(100)]);
    return validators.toList();
  }

  static Map<String, String Function(Object error)> getValidationMessages(
      FieldTemplate element) {
    final Map<String, String Function(Object error)> messages = {};
    if (element.mandatory)
      messages['required'] = (error) => 'This field is mandatory.';
    if (element.type == ValueType.Email)
      messages['email'] = (error) => 'Invalid email format.';
    if (element.type.isInteger) {
      messages['number'] = (error) => 'Please enter an integer.';
    }
    if (element.type == ValueType.IntegerZeroOrPositive) {
      messages['number'] = (error) => 'Only zero or positive numbers allowed.';
      messages['min'] = (error) => 'Value cannot be less than 0.';
    }
    if (element.type == ValueType.IntegerNegative) {
      messages['number'] = (error) => 'Please enter an integer.';
      messages['max'] = (error) => 'Value cannot be greater than -1.';
    }
    if (element.type == ValueType.IntegerPositive) {
      messages['min'] = (error) => 'Value must be greater than 0.';
    }
    if (element.type == ValueType.Percentage) {
      messages['min'] = (error) => 'Percentage cannot be negative.';
      messages['maxLength'] = (error) => 'Percentage cannot exceed 100%.';
    }

    return messages;
  }
}

Map<String, ValidationMessageFunction> validationMessages() => {
      // 'pattern': (error) => S.current.fullNameIsRequired,
      'fullName': (error) {
        if (error == 'invalidCharacters') return S.current.pleaseUseLettersOnly;
        if (error == 'tooFewParts')
          return S.current.pleaseEnterAtLeastFourNameParts;
        return S.current.fullNameIsRequired;
      },
      'required': (error) => S.current.thisFieldIsRequired,
      'email': (error) => S.current.pleaseEnterAValidEmailAddress,
      'number': (error) => S.current.enterAValidNumber,
      'min': (error) => S.current.valueMustBeGreaterThanOrEqualToError(error),
      'max': (error) => S.current.valueMustBeLessThanOrEqualToError(error),
      'maxLength': (error) => S.current.maximumAllowedLengthIsError(error),
    };
