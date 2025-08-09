import 'package:d_sdk/core/exception/exception.dart';

/// UID Failures
sealed class UidFailure extends DException {
  const UidFailure();
}

final class MoreThanElevenCharsException extends UidFailure {
  const MoreThanElevenCharsException();

  @override
  String toString() => 'UID has more than 11 characters.';
}

final class LessThanElevenCharsException extends UidFailure {
  const LessThanElevenCharsException();

  @override
  String toString() => 'UID has less than 11 characters.';
}

final class MalformedUidException extends UidFailure {
  const MalformedUidException();

  @override
  String toString() => 'UID is malformed.';
}
