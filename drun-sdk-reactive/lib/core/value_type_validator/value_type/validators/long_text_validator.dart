import 'package:d_sdk/core/value_type_validator/value_type/failures/long_text_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class LongTextValidator extends ValueTypeValidator<LongTextFailure> {
  const LongTextValidator();

  @override
  Result<String, LongTextFailure> validate(String value) {
    return Success(value);
  }
}
