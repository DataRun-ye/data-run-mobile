import 'package:d2_remote/core/datarun/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_mask_failure.freezed.dart';

@freezed
class FieldMaskFailure with _$FieldMaskFailure implements DException {
  @Implements<DException>()
  const factory FieldMaskFailure.wrongPatternException(
      [@Default('Exception') String message,
      Object? cause]) = WrongPatternException;

  @Implements<DException>()
  const factory FieldMaskFailure.invalidPatternException(
      [@Default('Exception') String message,
      Object? cause]) = InvalidPatternException;

  const FieldMaskFailure._();
}
