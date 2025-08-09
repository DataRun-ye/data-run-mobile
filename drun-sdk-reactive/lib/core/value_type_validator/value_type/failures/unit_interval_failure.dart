import 'package:d_sdk/core/exception/exception.dart';

/// UnitInterval Failures
sealed class UnitIntervalFailure extends DException {
  const UnitIntervalFailure();

  const factory UnitIntervalFailure.scientificNotationExceptionUnitInterval() =
      ScientificNotationExceptionUnitInterval;

  const factory UnitIntervalFailure.unitIntervalNumberFormatException() =
      UnitIntervalNumberFormatException;

  const factory UnitIntervalFailure.greaterThanOneException() =
      GreaterThanOneException;

  const factory UnitIntervalFailure.smallerThanZeroException() =
      SmallerThanZeroException;
}

final class ScientificNotationExceptionUnitInterval
    extends UnitIntervalFailure {
  const ScientificNotationExceptionUnitInterval();

  @override
  String toString() => 'Scientific notation is not allowed in unit interval.';
}

final class UnitIntervalNumberFormatException extends UnitIntervalFailure {
  const UnitIntervalNumberFormatException();

  @override
  String toString() => 'Invalid number format for unit interval.';
}

final class GreaterThanOneException extends UnitIntervalFailure {
  const GreaterThanOneException();

  @override
  String toString() => 'Unit interval value is greater than 1.';
}

final class SmallerThanZeroException extends UnitIntervalFailure {
  const SmallerThanZeroException();

  @override
  String toString() => 'Unit interval value is smaller than 0.';
}
