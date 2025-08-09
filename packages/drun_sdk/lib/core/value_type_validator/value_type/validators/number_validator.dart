import 'package:d_sdk/core/value_type_validator/value_type/failures/number_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/number_validator_base.dart';
import 'package:multiple_result/multiple_result.dart';

class NumberValidator extends NumberValidatorBase<NumberFailure> {
  const NumberValidator();

  static final startsWithDot = RegExp(r'^\.\d*');
  static final scientificNotationPattern =
      RegExp(r'[+-]?(?:0|[1-9]\d*)(?:\.\d*)?(?:[eE][+-]?\d+)');

  @override
  NumberFailure get formatFailure =>
      const NumberFailure.malformedNumberException();

  @override
  NumberFailure get leadingZeroException =>
      const NumberFailure.leadingZeroException();

  @override
  Result<String, NumberFailure> internalValidate(String value) {
    double.parse(value);
    if (scientificNotationPattern.hasMatch(value)) {
      return const Error(NumberFailure.scientificNotationException());
    } else if (startsWithDot.hasMatch(value)) {
      return Error(formatFailure);
    } else {
      return Success(value);
    }
  }
}
