import 'package:d_sdk/core/exception/exception.dart';

abstract class NumberFailure extends DException {
  const NumberFailure([super.message]);

  const factory NumberFailure.malformedNumberException() =
      MalformedNumberException;

  const factory NumberFailure.leadingZeroException() = LeadingZeroException;

  const factory NumberFailure.scientificNotationException() =
      ScientificNotationException;
}

class MalformedNumberException extends NumberFailure {
  const MalformedNumberException([super.message]);

  @override
  String toString() => 'The number is malformed.';
}

class LeadingZeroException extends NumberFailure {
  const LeadingZeroException();

  @override
  String toString() => 'Leading zeros are not allowed.';
}

final class ScientificNotationException extends NumberFailure {
  const ScientificNotationException();

  @override
  String toString() => 'Scientific notation is not allowed.';
}
