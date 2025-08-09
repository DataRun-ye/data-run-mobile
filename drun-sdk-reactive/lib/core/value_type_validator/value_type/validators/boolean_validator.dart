import 'package:d_sdk/core/value_type_validator/value_type/failures/boolean_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class BooleanValidator extends ValueTypeValidator<BooleanFailure> {
  const BooleanValidator();

  @override
  Result<String, BooleanFailure> validate(String value) {
    if (value == '0') {
      return const Error(const ZeroIsNotFalseException());
    } else if (value == '1') {
      return const Error(const OneIsNotTrueException());
    } else if (value == 'true' || value == 'false') {
      return Success(value);
    } else {
      return const Error(const BooleanMalformedException());
    }
  }
}
