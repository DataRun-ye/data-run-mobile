import 'package:d_sdk/core/exception/exception.dart';

/// Failure types for Integer Negative validation
sealed class IntegerNegativeFailure extends DException {
  const IntegerNegativeFailure();

  const factory IntegerNegativeFailure.malformedNumber() = MalformedNumber;

  const factory IntegerNegativeFailure.integerOverflow() = IntegerOverflow;

  const factory IntegerNegativeFailure.leadingZero() = LeadingZero;

  const factory IntegerNegativeFailure.valueIsZero() = ValueIsZero;

  const factory IntegerNegativeFailure.valueIsPositive() = ValueIsPositive;
}

final class MalformedNumber extends IntegerNegativeFailure {
  const MalformedNumber();

  @override
  String toString() => 'The number is malformed.';
}

final class ValueIsZero extends IntegerNegativeFailure {
  const ValueIsZero();

  @override
  String toString() => 'The value is zero.';
}

final class ValueIsPositive extends IntegerNegativeFailure {
  const ValueIsPositive();

  @override
  String toString() => 'The value is positive.';
}

final class IntegerOverflow extends IntegerNegativeFailure {
  const IntegerOverflow();

  @override
  String toString() => 'Integer overflow occurred.';
}

class LeadingZero extends IntegerNegativeFailure {
  const LeadingZero();

  @override
  String toString() => 'Leading zeros are not allowed.';
}
