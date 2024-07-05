// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimeFailure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) parseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? parseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? parseException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParseException value) parseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParseException value)? parseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParseException value)? parseException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeFailureCopyWith<TimeFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeFailureCopyWith<$Res> {
  factory $TimeFailureCopyWith(
          TimeFailure value, $Res Function(TimeFailure) then) =
      _$TimeFailureCopyWithImpl<$Res, TimeFailure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$TimeFailureCopyWithImpl<$Res, $Val extends TimeFailure>
    implements $TimeFailureCopyWith<$Res> {
  _$TimeFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParseExceptionImplCopyWith<$Res>
    implements $TimeFailureCopyWith<$Res> {
  factory _$$ParseExceptionImplCopyWith(_$ParseExceptionImpl value,
          $Res Function(_$ParseExceptionImpl) then) =
      __$$ParseExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ParseExceptionImplCopyWithImpl<$Res>
    extends _$TimeFailureCopyWithImpl<$Res, _$ParseExceptionImpl>
    implements _$$ParseExceptionImplCopyWith<$Res> {
  __$$ParseExceptionImplCopyWithImpl(
      _$ParseExceptionImpl _value, $Res Function(_$ParseExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ParseExceptionImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ParseExceptionImpl implements ParseException {
  const _$ParseExceptionImpl([this.message = 'ValidationException']);

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'TimeFailure.parseException(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParseExceptionImplCopyWith<_$ParseExceptionImpl> get copyWith =>
      __$$ParseExceptionImplCopyWithImpl<_$ParseExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) parseException,
  }) {
    return parseException(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? parseException,
  }) {
    return parseException?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? parseException,
    required TResult orElse(),
  }) {
    if (parseException != null) {
      return parseException(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParseException value) parseException,
  }) {
    return parseException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParseException value)? parseException,
  }) {
    return parseException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParseException value)? parseException,
    required TResult orElse(),
  }) {
    if (parseException != null) {
      return parseException(this);
    }
    return orElse();
  }
}

abstract class ParseException implements TimeFailure, ValidationException {
  const factory ParseException([final String message]) = _$ParseExceptionImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ParseExceptionImplCopyWith<_$ParseExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
