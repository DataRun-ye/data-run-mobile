import 'package:d_sdk/core/value_type_validator/value_type/failures/percentage_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class PercentageValidator extends ValueTypeValidator<PercentageFailure> {
  const PercentageValidator();

  static const int ONE_HUNDRED_PERCENT = 100;
  static const int ZERO_PERCENT = 0;

  @override
  Result<String, PercentageFailure> validate(String value) {
    try {
      int convertedValue = int.parse(value);
      if (convertedValue > ONE_HUNDRED_PERCENT) {
        // Failure
        return const Error(ValueGreaterThan100());
      } else if (convertedValue < ZERO_PERCENT) {
        // Failure
        return const Error(ValueIsNegative());
      } else {
        // Success
        return Success(value);
      }
    } on FormatException {
      // Failure
      return const Error(PercentageNumberFormatException());
    }
  }
}
