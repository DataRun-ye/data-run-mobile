import 'package:d_sdk/core/exception/exception.dart';

/// Failure types for Integer Negative validation
///
/// Failure types for Integer Negative validation
sealed class IntegerPositiveFailure extends DException {
  const IntegerPositiveFailure();

  const factory IntegerPositiveFailure.malformedNumber() = MalformedNumber;

  const factory IntegerPositiveFailure.integerOverflow() = IntegerOverflow;

  const factory IntegerPositiveFailure.leadingZero() = LeadingZero;

  const factory IntegerPositiveFailure.valueIsZero() = ValueIsZero;

  const factory IntegerPositiveFailure.valueIsNegative() = ValueIsNegative;
}

final class MalformedNumber extends IntegerPositiveFailure {
  const MalformedNumber();

  @override
  String toString() => 'The number is malformed.';
}

final class ValueIsZero extends IntegerPositiveFailure {
  const ValueIsZero();

  @override
  String toString() => 'The value is zero.';
}

final class ValueIsNegative extends IntegerPositiveFailure {
  const ValueIsNegative();

  @override
  String toString() => 'The value is negative.';
}

final class IntegerOverflow extends IntegerPositiveFailure {
  const IntegerOverflow();

  @override
  String toString() => 'Integer overflow occurred.';
}

final class LeadingZero extends IntegerPositiveFailure {
  const LeadingZero();

  @override
  String toString() => 'Leading zeros are not allowed.';
}
