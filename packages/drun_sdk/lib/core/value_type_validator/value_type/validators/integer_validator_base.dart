import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/number_validator_base.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IntegerValidatorBase<T extends DException>
    extends NumberValidatorBase<T> {
  const IntegerValidatorBase();

  static int intMaxValue = 2147483647;
  static int intMinValue = -2147483648;

  @override
  Result<String, T> internalValidate(String value) {
    try {
      final int convertedValue = int.parse(value);
      if (convertedValue > intMaxValue || convertedValue < intMinValue) {
        return Error(overflowFailure);
      }
      return validateInteger(value);
    } on FormatException {
      // Failure
      return Error(formatFailure);
    }
  }

  Result<String, T> validateInteger(String value);

  T get overflowFailure;
}
