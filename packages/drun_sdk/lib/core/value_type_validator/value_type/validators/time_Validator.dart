import 'package:d_sdk/core/value_type_validator/value_type/failures/time_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

/// TimeValidator: Validates time strings using a specific HH:mm pattern.
class TimeValidator implements ValueTypeValidator<TimeFailure> {
  const TimeValidator();

  // static final RegExp timePattern = RegExp(r'^([01][0-9]|2[0-3]):[0-5][0-9]$');
  static final timePattern = RegExp(r'([01][0-9]|2[0-3]):[0-5][0-9]');

  @override
  Result<String, TimeFailure> validate(String value) {
    if (timePattern.hasMatch(value)) {
      return Success(value);
    } else {
      return const Error(TimeParseException());
    }
  }
}
