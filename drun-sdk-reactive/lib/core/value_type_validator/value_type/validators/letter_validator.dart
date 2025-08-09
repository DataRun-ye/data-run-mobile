import 'package:d_sdk/core/value_type_validator/value_type/failures/letter_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class LetterValidator extends ValueTypeValidator<LetterFailure> {
  const LetterValidator();

  static final letterPattern = RegExp(r'[a-zA-Z]');

  @override
  Result<String, LetterFailure> validate(String value) {
    if (value.isEmpty) {
      return const Error(LetterFailure.emptyStringException());
    } else if (value.length > 1) {
      return const Error(LetterFailure.moreThanOneLetterException());
    } else if (letterPattern.hasMatch(value)) {
      return Success(value);
    } else {
      return const Error(LetterFailure.stringIsNotALetterException());
    }
  }
}
