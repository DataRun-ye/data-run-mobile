import 'package:d_sdk/core/exception/exception.dart';

sealed class UrlFailure extends DException {
  const UrlFailure();
}

final class MalformedUrlException extends UrlFailure {
  const MalformedUrlException();

  @override
  String toString() => 'The URL format is invalid.';
}
