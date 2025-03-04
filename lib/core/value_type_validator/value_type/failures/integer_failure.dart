import 'package:d2_remote/core/datarun/exception/d_exception.dart';

/// Failure types for Integer Negative validation
sealed class IntegerFailure extends DException {
  const IntegerFailure();

  const factory IntegerFailure.malformedNumber() = MalformedNumber;

  const factory IntegerFailure.integerOverflow() = IntegerOverflow;

  const factory IntegerFailure.leadingZero() = LeadingZero;
}

class MalformedNumber extends IntegerFailure {
  const MalformedNumber();

  @override
  String toString() => 'The number is malformed.';
}

final class IntegerOverflow extends IntegerFailure {
  const IntegerOverflow();

  @override
  String toString() => 'Integer overflow occurred.';
}

class LeadingZero extends IntegerFailure {
  const LeadingZero();

  @override
  String toString() => 'Leading zeros are not allowed.';
}
