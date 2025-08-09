import 'package:d_sdk/core/value_type_validator/value_type/failures/date_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

/// DateValidator: validates a date string using the "yyyy-MM-dd" format.
class DateValidator implements ValueTypeValidator<DateFailure> {
  const DateValidator();

  static DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Result<String, DateFailure> validate(String value) {
    try {
      final date = formatter.parse(value);
      // Returns the date string in a normalized format.
      return Success(formatter.format(date));
    } on FormatException {
      return const Error(DateParseException());
    }
  }
}
