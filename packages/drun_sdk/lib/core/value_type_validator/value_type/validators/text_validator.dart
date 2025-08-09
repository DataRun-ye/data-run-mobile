import 'package:d_sdk/core/value_type_validator/value_type/failures/text_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

/// TextValidator: Ensures the text does not exceed a maximum character count.
class TextValidator implements ValueTypeValidator<TextFailure> {
  const TextValidator();

  static const int maxChars = 50000;

  @override
  Result<String, TextFailure> validate(String value) {
    if (value.length > maxChars) {
      return const Error(TextFailure.tooLargeTextException());
    } else {
      return Success(value);
    }
  }
}
