import 'package:d_sdk/core/exception/exception.dart';

/// TrueOnly Failure
sealed class TrueOnlyFailure extends DException {
  const TrueOnlyFailure();
}

final class OneIsNotTrueException extends TrueOnlyFailure {
  const OneIsNotTrueException();

  @override
  String toString() => '1 is not considered true.';
}

final class FalseIsNotAValidValueException extends TrueOnlyFailure {
  const FalseIsNotAValidValueException();

  @override
  String toString() => 'False is not a valid value.';
}

final class BooleanMalformedException extends TrueOnlyFailure {
  const BooleanMalformedException();

  @override
  String toString() => 'Boolean value is malformed.';
}
