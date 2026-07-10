// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dialog_button_style.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DialogButtonStyle {
  String get text;
  IconData? get iconData;
  Color get color;
  Color get backgroundColor;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DialogButtonStyleCopyWith<DialogButtonStyle> get copyWith =>
      _$DialogButtonStyleCopyWithImpl<DialogButtonStyle>(
          this as DialogButtonStyle, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DialogButtonStyle &&
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

  @override
  String toString() {
    return 'DialogButtonStyle(text: $text, iconData: $iconData, color: $color, backgroundColor: $backgroundColor)';
  }
}

/// @nodoc
abstract mixin class $DialogButtonStyleCopyWith<$Res> {
  factory $DialogButtonStyleCopyWith(
          DialogButtonStyle value, $Res Function(DialogButtonStyle) _then) =
      _$DialogButtonStyleCopyWithImpl;
  @useResult
  $Res call(
      {String text, IconData? iconData, Color color, Color backgroundColor});
}

/// @nodoc
class _$DialogButtonStyleCopyWithImpl<$Res>
    implements $DialogButtonStyleCopyWith<$Res> {
  _$DialogButtonStyleCopyWithImpl(this._self, this._then);

  final DialogButtonStyle _self;
  final $Res Function(DialogButtonStyle) _then;

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
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      iconData: freezed == iconData
          ? _self.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData?,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// Adds pattern-matching-related methods to [DialogButtonStyle].
extension DialogButtonStylePatterns on DialogButtonStyle {
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
    TResult Function(MainButton value)? mainButton,
    TResult Function(SecondaryButton value)? secondaryButton,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MainButton() when mainButton != null:
        return mainButton(_that);
      case SecondaryButton() when secondaryButton != null:
        return secondaryButton(_that);
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
    required TResult Function(MainButton value) mainButton,
    required TResult Function(SecondaryButton value) secondaryButton,
  }) {
    final _that = this;
    switch (_that) {
      case MainButton():
        return mainButton(_that);
      case SecondaryButton():
        return secondaryButton(_that);
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
    TResult? Function(MainButton value)? mainButton,
    TResult? Function(SecondaryButton value)? secondaryButton,
  }) {
    final _that = this;
    switch (_that) {
      case MainButton() when mainButton != null:
        return mainButton(_that);
      case SecondaryButton() when secondaryButton != null:
        return secondaryButton(_that);
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
    TResult Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MainButton() when mainButton != null:
        return mainButton(
            _that.text, _that.iconData, _that.color, _that.backgroundColor);
      case SecondaryButton() when secondaryButton != null:
        return secondaryButton(
            _that.text, _that.color, _that.iconData, _that.backgroundColor);
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
    required TResult Function(
            String text, IconData? iconData, Color color, Color backgroundColor)
        mainButton,
    required TResult Function(
            String text, Color color, IconData? iconData, Color backgroundColor)
        secondaryButton,
  }) {
    final _that = this;
    switch (_that) {
      case MainButton():
        return mainButton(
            _that.text, _that.iconData, _that.color, _that.backgroundColor);
      case SecondaryButton():
        return secondaryButton(
            _that.text, _that.color, _that.iconData, _that.backgroundColor);
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
    TResult? Function(String text, IconData? iconData, Color color,
            Color backgroundColor)?
        mainButton,
    TResult? Function(String text, Color color, IconData? iconData,
            Color backgroundColor)?
        secondaryButton,
  }) {
    final _that = this;
    switch (_that) {
      case MainButton() when mainButton != null:
        return mainButton(
            _that.text, _that.iconData, _that.color, _that.backgroundColor);
      case SecondaryButton() when secondaryButton != null:
        return secondaryButton(
            _that.text, _that.color, _that.iconData, _that.backgroundColor);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MainButton implements DialogButtonStyle {
  const MainButton(
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

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MainButtonCopyWith<MainButton> get copyWith =>
      _$MainButtonCopyWithImpl<MainButton>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MainButton &&
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

  @override
  String toString() {
    return 'DialogButtonStyle.mainButton(text: $text, iconData: $iconData, color: $color, backgroundColor: $backgroundColor)';
  }
}

/// @nodoc
abstract mixin class $MainButtonCopyWith<$Res>
    implements $DialogButtonStyleCopyWith<$Res> {
  factory $MainButtonCopyWith(
          MainButton value, $Res Function(MainButton) _then) =
      _$MainButtonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String text, IconData? iconData, Color color, Color backgroundColor});
}

/// @nodoc
class _$MainButtonCopyWithImpl<$Res> implements $MainButtonCopyWith<$Res> {
  _$MainButtonCopyWithImpl(this._self, this._then);

  final MainButton _self;
  final $Res Function(MainButton) _then;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? iconData = freezed,
    Object? color = null,
    Object? backgroundColor = null,
  }) {
    return _then(MainButton(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      iconData: freezed == iconData
          ? _self.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData?,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class SecondaryButton implements DialogButtonStyle {
  const SecondaryButton(
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

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SecondaryButtonCopyWith<SecondaryButton> get copyWith =>
      _$SecondaryButtonCopyWithImpl<SecondaryButton>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SecondaryButton &&
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

  @override
  String toString() {
    return 'DialogButtonStyle.secondaryButton(text: $text, color: $color, iconData: $iconData, backgroundColor: $backgroundColor)';
  }
}

/// @nodoc
abstract mixin class $SecondaryButtonCopyWith<$Res>
    implements $DialogButtonStyleCopyWith<$Res> {
  factory $SecondaryButtonCopyWith(
          SecondaryButton value, $Res Function(SecondaryButton) _then) =
      _$SecondaryButtonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String text, Color color, IconData? iconData, Color backgroundColor});
}

/// @nodoc
class _$SecondaryButtonCopyWithImpl<$Res>
    implements $SecondaryButtonCopyWith<$Res> {
  _$SecondaryButtonCopyWithImpl(this._self, this._then);

  final SecondaryButton _self;
  final $Res Function(SecondaryButton) _then;

  /// Create a copy of DialogButtonStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? color = null,
    Object? iconData = freezed,
    Object? backgroundColor = null,
  }) {
    return _then(SecondaryButton(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      iconData: freezed == iconData
          ? _self.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData?,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

// dart format on
