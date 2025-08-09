import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class NumberValidatorBase<T extends DException>
    extends ValueTypeValidator<T> {
  const NumberValidatorBase();

  static final hasLeadingZeroRegex = RegExp(r'^[+-]?(0+[0-9]).*$');

  @override
  Result<String, T> validate(String value) {
    try {
      if (hasLeadingZeroRegex.hasMatch(value)) {
        return Error(leadingZeroException);
      } else {
        return internalValidate(value);
      }
    } on FormatException {
      return Error(formatFailure);
    }
  }

  T get leadingZeroException;

  T get formatFailure;

  Result<String, T> internalValidate(String value);
}
