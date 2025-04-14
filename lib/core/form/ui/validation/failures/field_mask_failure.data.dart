import 'package:d_sdk/core/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_mask_failure.data.freezed.dart';

@freezed
sealed class FieldMaskFailure with _$FieldMaskFailure implements DException {
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
