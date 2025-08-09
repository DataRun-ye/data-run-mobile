import 'package:d_sdk/core/exception/exception.dart';

/// Text Failure
sealed class TextFailure extends DException {
  const TextFailure();
  const factory TextFailure.tooLargeTextException() = TooLargeTextException;
}

final class TooLargeTextException extends TextFailure {
  const TooLargeTextException();

  @override
  String toString() => 'Text exceeds maximum allowed characters.';
}
