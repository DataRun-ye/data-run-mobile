import 'package:d_sdk/core/value_type_validator/value_type/failures/true_only_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

/// TrueOnlyValidator: Only accepts the string "true" as valid.
class TrueOnlyValidator implements ValueTypeValidator<TrueOnlyFailure> {
  const TrueOnlyValidator();

  @override
  Result<String, TrueOnlyFailure> validate(String value) {
    if (value == 'false') {
      return const Error(FalseIsNotAValidValueException());
    } else if (value == '1') {
      return const Error(OneIsNotTrueException());
    } else if (value == 'true') {
      return Success(value);
    } else {
      return const Error(BooleanMalformedException());
    }
  }
}
