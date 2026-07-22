import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
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

    if (element.mandatory) validators.add(const RequiredFieldValidator());
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
}

class RequiredFieldValidator extends RequiredValidator {
  const RequiredFieldValidator();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final value = control.value;
    if (value is Iterable && value.isEmpty) {
      return <String, dynamic>{ValidationMessage.required: true};
    }

    return super.validate(control);
  }
}

class RuleErrorsValidator extends Validator<dynamic> {
  RuleErrorsValidator(this._errors);

  final Map<String, dynamic> Function() _errors;

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final errors = _errors();
    return errors.isEmpty ? null : Map<String, dynamic>.of(errors);
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
