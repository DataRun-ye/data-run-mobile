import 'package:d_sdk/core/value_type_validator/value_type/failures/phone_number_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

/// PhoneNumberValidator: Validates phone numbers using a regex.
class PhoneNumberValidator implements ValueTypeValidator<PhoneNumberFailure> {
  const PhoneNumberValidator();

  // Pattern: "^[0-9+(][0-9+\-() ]{2,18}[0-9]$"

  static final RegExp phonePattern = RegExp(r'^[0-9+(][0-9+\-() ]{2,18}[0-9]$');

  @override
  Result<String, PhoneNumberFailure> validate(String value) {
    if (phonePattern.hasMatch(value)) {
      return Success(value);
    } else {
      return const Error(MalformedPhoneNumberException());
    }
  }
}
