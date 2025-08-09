import 'package:d_sdk/core/exception/exception.dart';

/// Coordinate Failure
sealed class CoordinateFailure extends DException {
  const CoordinateFailure();
}

final class CoordinateMalformedException extends CoordinateFailure {
  const CoordinateMalformedException();

  @override
  String toString() => 'Coordinate is malformed.';
}
