import 'package:d_sdk/core/value_type_validator/value_type/failures/integer_negative_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/integer_validator_base.dart';
import 'package:multiple_result/multiple_result.dart';

class IntegerNegativeValidator
    extends IntegerValidatorBase<IntegerNegativeFailure> {
  const IntegerNegativeValidator();

  @override
  IntegerNegativeFailure get formatFailure =>
      const IntegerNegativeFailure.malformedNumber();

  @override
  IntegerNegativeFailure get leadingZeroException =>
      const IntegerNegativeFailure.leadingZero();

  @override
  IntegerNegativeFailure get overflowFailure =>
      const IntegerNegativeFailure.integerOverflow();

  @override
  Result<String, IntegerNegativeFailure> validateInteger(String value) {
    final int convertedValue = int.parse(value);
    return switch (convertedValue) {
      == 0 => const Error(IntegerNegativeFailure.valueIsZero()),
      > 0 => const Error(IntegerNegativeFailure.valueIsPositive()),
      _ => Success(value)
    };
  }
}
