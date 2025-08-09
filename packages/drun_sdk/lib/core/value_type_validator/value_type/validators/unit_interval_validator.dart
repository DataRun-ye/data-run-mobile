import 'package:d_sdk/core/value_type_validator/value_type/failures/unit_interval_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/number_validator.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class UnitIntervalValidator extends ValueTypeValidator<UnitIntervalFailure> {
  const UnitIntervalValidator();

  @override
  Result<String, UnitIntervalFailure> validate(String value) {
    double convertedValue = double.parse(value);

    if (NumberValidator.scientificNotationPattern.hasMatch(value)) {
      return const Error(
          UnitIntervalFailure.scientificNotationExceptionUnitInterval());
    } else if (convertedValue > 1) {
      return const Error(UnitIntervalFailure.greaterThanOneException());
    } else if (convertedValue < 0) {
      return const Error(UnitIntervalFailure.smallerThanZeroException());
    } else {
      return Result.success(value);
    }
  }
}
