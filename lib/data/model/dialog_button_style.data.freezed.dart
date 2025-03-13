// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dialog_button_style.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DialogButtonStyle {
  String get text => throw _privateConstructorUsedError;
  IconData? get iconData => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;
  Color get backgroundColor => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String text, IconData? iconData, Color color, Color backgroundColor)
        mainButton,
    required TResult Function(
            String text, Color color, IconData? iconData, Color backgroundColor)
        secondaryButton,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult? Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainButton value) mainButton,
    required TResult Function(SecondaryButton value) secondaryButton,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainButton value)? mainButton,
    TResult? Function(SecondaryButton value)? secondaryButton,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainButton value)? mainButton,
    TResult Function(SecondaryButton value)? secondaryButton,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DialogButtonStyleCopyWith<DialogButtonStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogButtonStyleCopyWith<$Res> {
  factory $DialogButtonStyleCopyWith(
          DialogButtonStyle value, $Res Function(DialogButtonStyle) then) =
      _$DialogButtonStyleCopyWithImpl<$Res, DialogButtonStyle>;
  @useResult
  $Res call(
      {String text, IconData? iconData, Color color, Color backgroundColor});
}

/// @nodoc
class _$DialogButtonStyleCopyWithImpl<$Res, $Val extends DialogButtonStyle>
    implements $DialogButtonStyleCopyWith<$Res> {
  _$DialogButtonStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? iconData = freezed,
    Object? color = null,
    Object? backgroundColor = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      iconData: freezed == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainButtonImplCopyWith<$Res>
    implements $DialogButtonStyleCopyWith<$Res> {
  factory _$$MainButtonImplCopyWith(
          _$MainButtonImpl value, $Res Function(_$MainButtonImpl) then) =
      __$$MainButtonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text, IconData? iconData, Color color, Color backgroundColor});
}

/// @nodoc
class __$$MainButtonImplCopyWithImpl<$Res>
    extends _$DialogButtonStyleCopyWithImpl<$Res, _$MainButtonImpl>
    implements _$$MainButtonImplCopyWith<$Res> {
  __$$MainButtonImplCopyWithImpl(
      _$MainButtonImpl _value, $Res Function(_$MainButtonImpl) _then)
      : super(_value, _then);

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? iconData = freezed,
    Object? color = null,
    Object? backgroundColor = null,
  }) {
    return _then(_$MainButtonImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      iconData: freezed == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$MainButtonImpl implements MainButton {
  const _$MainButtonImpl(
      {required this.text,
      this.iconData,
      this.color = Colors.white,
      this.backgroundColor = Colors.blueAccent});

  @override
  final String text;
  @override
  final IconData? iconData;
  @override
  @JsonKey()
  final Color color;
  @override
  @JsonKey()
  final Color backgroundColor;

  @override
  String toString() {
    return 'DialogButtonStyle.mainButton(text: $text, iconData: $iconData, color: $color, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainButtonImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, text, iconData, color, backgroundColor);

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MainButtonImplCopyWith<_$MainButtonImpl> get copyWith =>
      __$$MainButtonImplCopyWithImpl<_$MainButtonImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String text, IconData? iconData, Color color, Color backgroundColor)
        mainButton,
    required TResult Function(
            String text, Color color, IconData? iconData, Color backgroundColor)
        secondaryButton,
  }) {
    return mainButton(text, iconData, color, backgroundColor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult? Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
  }) {
    return mainButton?.call(text, iconData, color, backgroundColor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
    required TResult orElse(),
  }) {
    if (mainButton != null) {
      return mainButton(text, iconData, color, backgroundColor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainButton value) mainButton,
    required TResult Function(SecondaryButton value) secondaryButton,
  }) {
    return mainButton(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainButton value)? mainButton,
    TResult? Function(SecondaryButton value)? secondaryButton,
  }) {
    return mainButton?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainButton value)? mainButton,
    TResult Function(SecondaryButton value)? secondaryButton,
    required TResult orElse(),
  }) {
    if (mainButton != null) {
      return mainButton(this);
    }
    return orElse();
  }
}

abstract class MainButton implements DialogButtonStyle {
  const factory MainButton(
      {required final String text,
      final IconData? iconData,
      final Color color,
      final Color backgroundColor}) = _$MainButtonImpl;

  @override
  String get text;
  @override
  IconData? get iconData;
  @override
  Color get color;
  @override
  Color get backgroundColor;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MainButtonImplCopyWith<_$MainButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SecondaryButtonImplCopyWith<$Res>
    implements $DialogButtonStyleCopyWith<$Res> {
  factory _$$SecondaryButtonImplCopyWith(_$SecondaryButtonImpl value,
          $Res Function(_$SecondaryButtonImpl) then) =
      __$$SecondaryButtonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text, Color color, IconData? iconData, Color backgroundColor});
}

/// @nodoc
class __$$SecondaryButtonImplCopyWithImpl<$Res>
    extends _$DialogButtonStyleCopyWithImpl<$Res, _$SecondaryButtonImpl>
    implements _$$SecondaryButtonImplCopyWith<$Res> {
  __$$SecondaryButtonImplCopyWithImpl(
      _$SecondaryButtonImpl _value, $Res Function(_$SecondaryButtonImpl) _then)
      : super(_value, _then);

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? color = null,
    Object? iconData = freezed,
    Object? backgroundColor = null,
  }) {
    return _then(_$SecondaryButtonImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      iconData: freezed == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData?,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$SecondaryButtonImpl implements SecondaryButton {
  const _$SecondaryButtonImpl(
      {required this.text,
      this.color = Colors.white,
      this.iconData,
      this.backgroundColor = Colors.grey});

  @override
  final String text;
  @override
  @JsonKey()
  final Color color;
  @override
  final IconData? iconData;
  @override
  @JsonKey()
  final Color backgroundColor;

  @override
  String toString() {
    return 'DialogButtonStyle.secondaryButton(text: $text, color: $color, iconData: $iconData, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecondaryButtonImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, text, color, iconData, backgroundColor);

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecondaryButtonImplCopyWith<_$SecondaryButtonImpl> get copyWith =>
      __$$SecondaryButtonImplCopyWithImpl<_$SecondaryButtonImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String text, IconData? iconData, Color color, Color backgroundColor)
        mainButton,
    required TResult Function(
            String text, Color color, IconData? iconData, Color backgroundColor)
        secondaryButton,
  }) {
    return secondaryButton(text, color, iconData, backgroundColor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult? Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
  }) {
    return secondaryButton?.call(text, color, iconData, backgroundColor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
    required TResult orElse(),
  }) {
    if (secondaryButton != null) {
      return secondaryButton(text, color, iconData, backgroundColor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainButton value) mainButton,
    required TResult Function(SecondaryButton value) secondaryButton,
  }) {
    return secondaryButton(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainButton value)? mainButton,
    TResult? Function(SecondaryButton value)? secondaryButton,
  }) {
    return secondaryButton?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainButton value)? mainButton,
    TResult Function(SecondaryButton value)? secondaryButton,
    required TResult orElse(),
  }) {
    if (secondaryButton != null) {
      return secondaryButton(this);
    }
    return orElse();
  }
}

abstract class SecondaryButton implements DialogButtonStyle {
  const factory SecondaryButton(
      {required final String text,
      final Color color,
      final IconData? iconData,
      final Color backgroundColor}) = _$SecondaryButtonImpl;

  @override
  String get text;
  @override
  Color get color;
  @override
  IconData? get iconData;
  @override
  Color get backgroundColor;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecondaryButtonImplCopyWith<_$SecondaryButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
