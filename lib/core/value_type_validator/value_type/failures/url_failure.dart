import 'package:datarunmobile/core/exception/d_exception.dart';

sealed class UrlFailure extends DException {
  const UrlFailure();
}

final class MalformedUrlException extends UrlFailure {
  const MalformedUrlException();

  @override
  String toString() => 'The URL format is invalid.';
}
