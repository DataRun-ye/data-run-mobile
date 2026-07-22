import 'package:datarunmobile/core/exception/d_exception.dart';

/// DateTime Failure
sealed class DateTimeFailure extends DException {
  const DateTimeFailure();

  const factory DateTimeFailure.ParseException() = DateTimeParseException;
}

final class DateTimeParseException extends DateTimeFailure {
  const DateTimeParseException();

  @override
  String toString() => 'Failed to parse date and time.';
}
