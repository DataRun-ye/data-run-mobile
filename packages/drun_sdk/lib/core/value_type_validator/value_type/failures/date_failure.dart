import 'package:d_sdk/core/exception/d_exception.dart';

/// Failure type for Date validation
sealed class DateFailure extends DException {
  const DateFailure();
}

final class DateParseException extends DateFailure {
  const DateParseException();

  @override
  String toString() => 'Date parsing failed.';
}
