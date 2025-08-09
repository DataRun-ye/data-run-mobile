import 'package:d_sdk/core/exception/exception.dart';

/// Failure types for Integer Negative validation
sealed class IntegerZeroOrPositiveFailure extends DException {
  const IntegerZeroOrPositiveFailure();

  const factory IntegerZeroOrPositiveFailure.malformedNumber() =
      MalformedNumber;

  const factory IntegerZeroOrPositiveFailure.integerOverflow() =
      IntegerOverflow;

  const factory IntegerZeroOrPositiveFailure.leadingZero() = LeadingZero;

  const factory IntegerZeroOrPositiveFailure.valueIsNegative() =
      ValueIsNegative;
}

final class ValueIsNegative extends IntegerZeroOrPositiveFailure {
  const ValueIsNegative();

  @override
  String toString() => 'The value is negative.';
}

final class MalformedNumber extends IntegerZeroOrPositiveFailure {
  const MalformedNumber();

  @override
  String toString() => 'The number is malformed.';
}

final class IntegerOverflow extends IntegerZeroOrPositiveFailure {
  const IntegerOverflow();

  @override
  String toString() => 'Integer overflow occurred.';
}

final class LeadingZero extends IntegerZeroOrPositiveFailure {
  const LeadingZero();

  @override
  String toString() => 'Leading zeros are not allowed.';
}
