import 'package:d_sdk/core/value_type_validator/value_type/failures/integer_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/integer_validator_base.dart';
import 'package:multiple_result/multiple_result.dart';

class IntegerValidator extends IntegerValidatorBase<IntegerFailure> {
  const IntegerValidator();

  @override
  IntegerFailure get formatFailure => const IntegerFailure.malformedNumber();

  @override
  IntegerFailure get leadingZeroException => const IntegerFailure.leadingZero();

  @override
  IntegerFailure get overflowFailure => const IntegerFailure.integerOverflow();

  @override
  Result<String, IntegerFailure> validateInteger(String value) {
    int.parse(value);
    return Success(value);
  }
}
