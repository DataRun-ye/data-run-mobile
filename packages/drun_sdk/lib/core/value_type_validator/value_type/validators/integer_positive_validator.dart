import 'package:d_sdk/core/value_type_validator/value_type/failures/integer_positive_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/integer_validator_base.dart';
import 'package:multiple_result/multiple_result.dart';

class IntegerPositiveValidator
    extends IntegerValidatorBase<IntegerPositiveFailure> {
  const IntegerPositiveValidator();

  @override
  IntegerPositiveFailure get formatFailure =>
      const IntegerPositiveFailure.malformedNumber();

  @override
  IntegerPositiveFailure get leadingZeroException =>
      const IntegerPositiveFailure.leadingZero();

  @override
  IntegerPositiveFailure get overflowFailure =>
      const IntegerPositiveFailure.integerOverflow();

  @override
  Result<String, IntegerPositiveFailure> validateInteger(String value) {
    final int convertedValue = int.parse(value);
    return switch (convertedValue) {
      == 0 => const Error(IntegerPositiveFailure.valueIsZero()),
      < 0 => const Error(IntegerPositiveFailure.valueIsNegative()),
      _ => Success(value)
    };
  }
}
