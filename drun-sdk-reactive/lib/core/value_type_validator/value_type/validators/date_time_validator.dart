import 'package:d_sdk/core/value_type_validator/value_type/failures/date_time_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

class DateTimeValidator extends ValueTypeValidator<DateTimeFailure> {
  const DateTimeValidator();

  static final dateTimePattern = RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$');

  @override
  Result<String, DateTimeFailure> validate(String value) {
    if (!dateTimePattern.hasMatch(value)) {
      return const Error(DateTimeFailure.ParseException());
    }

    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm");

    try {
      final formattedValue = formatter.parse(value);
      return Success(formattedValue.toString());
    } catch (e) {
      return const Error(DateTimeFailure.ParseException());
    }
  }
}
