import 'package:d_sdk/core/exception/exception.dart';

/// Percentage Failures
sealed class PercentageFailure extends DException {
  const PercentageFailure();
}

final class PercentageNumberFormatException extends PercentageFailure {
  const PercentageNumberFormatException();

  @override
  String toString() => 'Invalid number format for percentage.';
}

final class ValueGreaterThan100 extends PercentageFailure {
  const ValueGreaterThan100();

  @override
  String toString() => 'Percentage value is greater than 100.';
}

final class ValueIsNegative extends PercentageFailure {
  const ValueIsNegative();

  @override
  String toString() => 'Percentage value is negative.';
}
