import 'package:d_sdk/core/exception/d_exception.dart';

/// Text Failure
final class FullNameFailure extends DException {
  const FullNameFailure();

  @override
  String toString() => 'Value is not a full name.';
}
