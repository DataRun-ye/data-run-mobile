import 'package:datarunmobile/core/exception/d_exception.dart';

/// Email Failure
sealed class EmailFailure extends DException {
  const EmailFailure();

  const factory EmailFailure.malformedEmail() = MalformedEmail;
}

final class MalformedEmail extends EmailFailure {
  const MalformedEmail();

  @override
  String toString() => 'Email is malformed.';
}
