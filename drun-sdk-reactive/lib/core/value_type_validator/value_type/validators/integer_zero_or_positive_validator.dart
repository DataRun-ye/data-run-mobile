import 'package:d_sdk/core/value_type_validator/value_type/failures/integer_zero_or_positive_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/integer_validator_base.dart';
import 'package:multiple_result/multiple_result.dart';

class IntegerZeroOrPositiveValidator
    extends IntegerValidatorBase<IntegerZeroOrPositiveFailure> {
  const IntegerZeroOrPositiveValidator();

  @override
  IntegerZeroOrPositiveFailure get formatFailure =>
      const IntegerZeroOrPositiveFailure.malformedNumber();

  @override
  IntegerZeroOrPositiveFailure get leadingZeroException =>
      const IntegerZeroOrPositiveFailure.leadingZero();

  @override
  IntegerZeroOrPositiveFailure get overflowFailure =>
      const IntegerZeroOrPositiveFailure.integerOverflow();

  @override
  Result<String, IntegerZeroOrPositiveFailure> validateInteger(String value) {
    final int convertedValue = int.parse(value);
    if (convertedValue < 0) {
      return Error(const IntegerZeroOrPositiveFailure.valueIsNegative());
    } else {
      return Success(value);
    }
  }
}
