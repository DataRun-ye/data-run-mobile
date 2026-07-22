import 'package:datarunmobile/core/exception/d_exception.dart';

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
