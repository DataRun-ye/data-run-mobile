// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_mask_failure.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldMaskFailure {
  String get message;
  Object? get cause;

  /// Create a copy of FieldMaskFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldMaskFailureCopyWith<FieldMaskFailure> get copyWith =>
      _$FieldMaskFailureCopyWithImpl<FieldMaskFailure>(
          this as FieldMaskFailure, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldMaskFailure &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));
}

/// @nodoc
abstract mixin class $FieldMaskFailureCopyWith<$Res> {
  factory $FieldMaskFailureCopyWith(
          FieldMaskFailure value, $Res Function(FieldMaskFailure) _then) =
      _$FieldMaskFailureCopyWithImpl;
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class _$FieldMaskFailureCopyWithImpl<$Res>
    implements $FieldMaskFailureCopyWith<$Res> {
  _$FieldMaskFailureCopyWithImpl(this._self, this._then);

  final FieldMaskFailure _self;
  final $Res Function(FieldMaskFailure) _then;

  /// Create a copy of FieldMaskFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// Adds pattern-matching-related methods to [FieldMaskFailure].
extension FieldMaskFailurePatterns on FieldMaskFailure {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WrongPatternException value)? wrongPatternException,
    TResult Function(InvalidPatternException value)? invalidPatternException,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WrongPatternException() when wrongPatternException != null:
        return wrongPatternException(_that);
      case InvalidPatternException() when invalidPatternException != null:
        return invalidPatternException(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WrongPatternException value)
        wrongPatternException,
    required TResult Function(InvalidPatternException value)
        invalidPatternException,
  }) {
    final _that = this;
    switch (_that) {
      case WrongPatternException():
        return wrongPatternException(_that);
      case InvalidPatternException():
        return invalidPatternException(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WrongPatternException value)? wrongPatternException,
    TResult? Function(InvalidPatternException value)? invalidPatternException,
  }) {
    final _that = this;
    switch (_that) {
      case WrongPatternException() when wrongPatternException != null:
        return wrongPatternException(_that);
      case InvalidPatternException() when invalidPatternException != null:
        return invalidPatternException(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Object? cause)? wrongPatternException,
    TResult Function(String message, Object? cause)? invalidPatternException,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WrongPatternException() when wrongPatternException != null:
        return wrongPatternException(_that.message, _that.cause);
      case InvalidPatternException() when invalidPatternException != null:
        return invalidPatternException(_that.message, _that.cause);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, Object? cause)
        wrongPatternException,
    required TResult Function(String message, Object? cause)
        invalidPatternException,
  }) {
    final _that = this;
    switch (_that) {
      case WrongPatternException():
        return wrongPatternException(_that.message, _that.cause);
      case InvalidPatternException():
        return invalidPatternException(_that.message, _that.cause);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, Object? cause)? wrongPatternException,
    TResult? Function(String message, Object? cause)? invalidPatternException,
  }) {
    final _that = this;
    switch (_that) {
      case WrongPatternException() when wrongPatternException != null:
        return wrongPatternException(_that.message, _that.cause);
      case InvalidPatternException() when invalidPatternException != null:
        return invalidPatternException(_that.message, _that.cause);
      case _:
        return null;
    }
  }
}

/// @nodoc

class WrongPatternException extends FieldMaskFailure implements DException {
  const WrongPatternException([this.message = 'Exception', this.cause])
      : super._();

  @override
  @JsonKey()
  final String message;
  @override
  final Object? cause;

  /// Create a copy of FieldMaskFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WrongPatternExceptionCopyWith<WrongPatternException> get copyWith =>
      _$WrongPatternExceptionCopyWithImpl<WrongPatternException>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WrongPatternException &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));
}

/// @nodoc
abstract mixin class $WrongPatternExceptionCopyWith<$Res>
    implements $FieldMaskFailureCopyWith<$Res> {
  factory $WrongPatternExceptionCopyWith(WrongPatternException value,
          $Res Function(WrongPatternException) _then) =
      _$WrongPatternExceptionCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class _$WrongPatternExceptionCopyWithImpl<$Res>
    implements $WrongPatternExceptionCopyWith<$Res> {
  _$WrongPatternExceptionCopyWithImpl(this._self, this._then);

  final WrongPatternException _self;
  final $Res Function(WrongPatternException) _then;

  /// Create a copy of FieldMaskFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(WrongPatternException(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class InvalidPatternException extends FieldMaskFailure implements DException {
  const InvalidPatternException([this.message = 'Exception', this.cause])
      : super._();

  @override
  @JsonKey()
  final String message;
  @override
  final Object? cause;

  /// Create a copy of FieldMaskFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvalidPatternExceptionCopyWith<InvalidPatternException> get copyWith =>
      _$InvalidPatternExceptionCopyWithImpl<InvalidPatternException>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvalidPatternException &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));
}

/// @nodoc
abstract mixin class $InvalidPatternExceptionCopyWith<$Res>
    implements $FieldMaskFailureCopyWith<$Res> {
  factory $InvalidPatternExceptionCopyWith(InvalidPatternException value,
          $Res Function(InvalidPatternException) _then) =
      _$InvalidPatternExceptionCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class _$InvalidPatternExceptionCopyWithImpl<$Res>
    implements $InvalidPatternExceptionCopyWith<$Res> {
  _$InvalidPatternExceptionCopyWithImpl(this._self, this._then);

  final InvalidPatternException _self;
  final $Res Function(InvalidPatternException) _then;

  /// Create a copy of FieldMaskFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(InvalidPatternException(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == cause ? _self.cause : cause,
    ));
  }
}

// dart format on
