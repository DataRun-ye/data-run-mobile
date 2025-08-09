import 'package:d_sdk/core/exception/exception.dart';

/// Letter Failure
sealed class LetterFailure extends DException {
  const LetterFailure();
  const factory LetterFailure.stringIsNotALetterException() =
      StringIsNotALetterException;
  const factory LetterFailure.moreThanOneLetterException() =
      MoreThanOneLetterException;
  const factory LetterFailure.emptyStringException() = EmptyStringException;
}

final class StringIsNotALetterException extends LetterFailure {
  const StringIsNotALetterException();

  @override
  String toString() => 'The string is not a letter.';
}

final class MoreThanOneLetterException extends LetterFailure {
  const MoreThanOneLetterException();

  @override
  String toString() => 'More than one letter provided.';
}

final class EmptyStringException extends LetterFailure {
  const EmptyStringException();

  @override
  String toString() => 'Empty string provided.';
}
