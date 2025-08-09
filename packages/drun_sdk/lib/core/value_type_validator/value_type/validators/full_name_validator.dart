import 'package:d_sdk/core/value_type_validator/value_type/failures/pattern_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/validators.dart';
import 'package:multiple_result/multiple_result.dart';

class FullNameValidator extends ValueTypeValidator<FullNameFailure> {
  const FullNameValidator();

  static final RegExp emailRegex = RegExp(
      r'^[\u0621-\u064A]{2,}[ ]{1}[\u0621-\u064A]{2,}[ ]{1}[\u0621-\u064A]{2,}[ ]{1}[\u0621-\u064A]{2,}[ ]{0,1}[\u0621-\u064A]{0,}[ ]{0,1}$');

  Result<String, FullNameFailure> validate(String value) {
    if (emailRegex.hasMatch(value)) {
      return Success(value);
    } else {
      return const Error(FullNameFailure());
    }
  }
}
