// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'option_set_configuration.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OptionSetConfiguration implements DiagnosticableTreeMixin {
  List<DataOption> get options;
  List<String> get optionsToHide;
  List<String> get optionsToShow;

  /// Create a copy of OptionSetConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OptionSetConfigurationCopyWith<OptionSetConfiguration> get copyWith =>
      _$OptionSetConfigurationCopyWithImpl<OptionSetConfiguration>(
          this as OptionSetConfiguration, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'OptionSetConfiguration'))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('optionsToHide', optionsToHide))
      ..add(DiagnosticsProperty('optionsToShow', optionsToShow));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OptionSetConfiguration &&
            const DeepCollectionEquality().equals(other.options, options) &&
            const DeepCollectionEquality()
                .equals(other.optionsToHide, optionsToHide) &&
            const DeepCollectionEquality()
                .equals(other.optionsToShow, optionsToShow));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(options),
      const DeepCollectionEquality().hash(optionsToHide),
      const DeepCollectionEquality().hash(optionsToShow));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OptionSetConfiguration(options: $options, optionsToHide: $optionsToHide, optionsToShow: $optionsToShow)';
  }
}

/// @nodoc
abstract mixin class $OptionSetConfigurationCopyWith<$Res> {
  factory $OptionSetConfigurationCopyWith(OptionSetConfiguration value,
          $Res Function(OptionSetConfiguration) _then) =
      _$OptionSetConfigurationCopyWithImpl;
  @useResult
  $Res call(
      {List<DataOption> options,
      List<String> optionsToHide,
      List<String> optionsToShow});
}

/// @nodoc
class _$OptionSetConfigurationCopyWithImpl<$Res>
    implements $OptionSetConfigurationCopyWith<$Res> {
  _$OptionSetConfigurationCopyWithImpl(this._self, this._then);

  final OptionSetConfiguration _self;
  final $Res Function(OptionSetConfiguration) _then;

  /// Create a copy of OptionSetConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? optionsToHide = null,
    Object? optionsToShow = null,
  }) {
    return _then(_self.copyWith(
      options: null == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DataOption>,
      optionsToHide: null == optionsToHide
          ? _self.optionsToHide
          : optionsToHide // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionsToShow: null == optionsToShow
          ? _self.optionsToShow
          : optionsToShow // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [OptionSetConfiguration].
extension OptionSetConfigurationPatterns on OptionSetConfiguration {
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
    TResult Function(DefaultOptionSet value)? defaultOptionSet,
    TResult Function(BigOptionSet value)? bigOptionSet,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DefaultOptionSet() when defaultOptionSet != null:
        return defaultOptionSet(_that);
      case BigOptionSet() when bigOptionSet != null:
        return bigOptionSet(_that);
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
    required TResult Function(DefaultOptionSet value) defaultOptionSet,
    required TResult Function(BigOptionSet value) bigOptionSet,
  }) {
    final _that = this;
    switch (_that) {
      case DefaultOptionSet():
        return defaultOptionSet(_that);
      case BigOptionSet():
        return bigOptionSet(_that);
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
    TResult? Function(DefaultOptionSet value)? defaultOptionSet,
    TResult? Function(BigOptionSet value)? bigOptionSet,
  }) {
    final _that = this;
    switch (_that) {
      case DefaultOptionSet() when defaultOptionSet != null:
        return defaultOptionSet(_that);
      case BigOptionSet() when bigOptionSet != null:
        return bigOptionSet(_that);
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
    TResult Function(List<DataOption> options, List<String> optionsToHide,
            List<String> optionsToShow)?
        defaultOptionSet,
    TResult Function(List<DataOption> options, List<String> optionsToHide,
            List<String> optionsToShow)?
        bigOptionSet,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DefaultOptionSet() when defaultOptionSet != null:
        return defaultOptionSet(
            _that.options, _that.optionsToHide, _that.optionsToShow);
      case BigOptionSet() when bigOptionSet != null:
        return bigOptionSet(
            _that.options, _that.optionsToHide, _that.optionsToShow);
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
    required TResult Function(List<DataOption> options,
            List<String> optionsToHide, List<String> optionsToShow)
        defaultOptionSet,
    required TResult Function(List<DataOption> options,
            List<String> optionsToHide, List<String> optionsToShow)
        bigOptionSet,
  }) {
    final _that = this;
    switch (_that) {
      case DefaultOptionSet():
        return defaultOptionSet(
            _that.options, _that.optionsToHide, _that.optionsToShow);
      case BigOptionSet():
        return bigOptionSet(
            _that.options, _that.optionsToHide, _that.optionsToShow);
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
    TResult? Function(List<DataOption> options, List<String> optionsToHide,
            List<String> optionsToShow)?
        defaultOptionSet,
    TResult? Function(List<DataOption> options, List<String> optionsToHide,
            List<String> optionsToShow)?
        bigOptionSet,
  }) {
    final _that = this;
    switch (_that) {
      case DefaultOptionSet() when defaultOptionSet != null:
        return defaultOptionSet(
            _that.options, _that.optionsToHide, _that.optionsToShow);
      case BigOptionSet() when bigOptionSet != null:
        return bigOptionSet(
            _that.options, _that.optionsToHide, _that.optionsToShow);
      case _:
        return null;
    }
  }
}

/// @nodoc

class DefaultOptionSet extends OptionSetConfiguration
    with DiagnosticableTreeMixin {
  const DefaultOptionSet(
      {required final List<DataOption> options,
      final List<String> optionsToHide = const <String>[],
      final List<String> optionsToShow = const <String>[]})
      : _options = options,
        _optionsToHide = optionsToHide,
        _optionsToShow = optionsToShow,
        super._();

  final List<DataOption> _options;
  @override
  List<DataOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final List<String> _optionsToHide;
  @override
  @JsonKey()
  List<String> get optionsToHide {
    if (_optionsToHide is EqualUnmodifiableListView) return _optionsToHide;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionsToHide);
  }

  final List<String> _optionsToShow;
  @override
  @JsonKey()
  List<String> get optionsToShow {
    if (_optionsToShow is EqualUnmodifiableListView) return _optionsToShow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionsToShow);
  }

  /// Create a copy of OptionSetConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultOptionSetCopyWith<DefaultOptionSet> get copyWith =>
      _$DefaultOptionSetCopyWithImpl<DefaultOptionSet>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'OptionSetConfiguration.defaultOptionSet'))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('optionsToHide', optionsToHide))
      ..add(DiagnosticsProperty('optionsToShow', optionsToShow));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultOptionSet &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality()
                .equals(other._optionsToHide, _optionsToHide) &&
            const DeepCollectionEquality()
                .equals(other._optionsToShow, _optionsToShow));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_optionsToHide),
      const DeepCollectionEquality().hash(_optionsToShow));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OptionSetConfiguration.defaultOptionSet(options: $options, optionsToHide: $optionsToHide, optionsToShow: $optionsToShow)';
  }
}

/// @nodoc
abstract mixin class $DefaultOptionSetCopyWith<$Res>
    implements $OptionSetConfigurationCopyWith<$Res> {
  factory $DefaultOptionSetCopyWith(
          DefaultOptionSet value, $Res Function(DefaultOptionSet) _then) =
      _$DefaultOptionSetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<DataOption> options,
      List<String> optionsToHide,
      List<String> optionsToShow});
}

/// @nodoc
class _$DefaultOptionSetCopyWithImpl<$Res>
    implements $DefaultOptionSetCopyWith<$Res> {
  _$DefaultOptionSetCopyWithImpl(this._self, this._then);

  final DefaultOptionSet _self;
  final $Res Function(DefaultOptionSet) _then;

  /// Create a copy of OptionSetConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? options = null,
    Object? optionsToHide = null,
    Object? optionsToShow = null,
  }) {
    return _then(DefaultOptionSet(
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DataOption>,
      optionsToHide: null == optionsToHide
          ? _self._optionsToHide
          : optionsToHide // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionsToShow: null == optionsToShow
          ? _self._optionsToShow
          : optionsToShow // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class BigOptionSet extends OptionSetConfiguration with DiagnosticableTreeMixin {
  const BigOptionSet(
      {final List<DataOption> options = const <DataOption>[],
      final List<String> optionsToHide = const <String>[],
      final List<String> optionsToShow = const <String>[]})
      : _options = options,
        _optionsToHide = optionsToHide,
        _optionsToShow = optionsToShow,
        super._();

  final List<DataOption> _options;
  @override
  @JsonKey()
  List<DataOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final List<String> _optionsToHide;
  @override
  @JsonKey()
  List<String> get optionsToHide {
    if (_optionsToHide is EqualUnmodifiableListView) return _optionsToHide;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionsToHide);
  }

  final List<String> _optionsToShow;
  @override
  @JsonKey()
  List<String> get optionsToShow {
    if (_optionsToShow is EqualUnmodifiableListView) return _optionsToShow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionsToShow);
  }

  /// Create a copy of OptionSetConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BigOptionSetCopyWith<BigOptionSet> get copyWith =>
      _$BigOptionSetCopyWithImpl<BigOptionSet>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'OptionSetConfiguration.bigOptionSet'))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('optionsToHide', optionsToHide))
      ..add(DiagnosticsProperty('optionsToShow', optionsToShow));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BigOptionSet &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality()
                .equals(other._optionsToHide, _optionsToHide) &&
            const DeepCollectionEquality()
                .equals(other._optionsToShow, _optionsToShow));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_optionsToHide),
      const DeepCollectionEquality().hash(_optionsToShow));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OptionSetConfiguration.bigOptionSet(options: $options, optionsToHide: $optionsToHide, optionsToShow: $optionsToShow)';
  }
}

/// @nodoc
abstract mixin class $BigOptionSetCopyWith<$Res>
    implements $OptionSetConfigurationCopyWith<$Res> {
  factory $BigOptionSetCopyWith(
          BigOptionSet value, $Res Function(BigOptionSet) _then) =
      _$BigOptionSetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<DataOption> options,
      List<String> optionsToHide,
      List<String> optionsToShow});
}

/// @nodoc
class _$BigOptionSetCopyWithImpl<$Res> implements $BigOptionSetCopyWith<$Res> {
  _$BigOptionSetCopyWithImpl(this._self, this._then);

  final BigOptionSet _self;
  final $Res Function(BigOptionSet) _then;

  /// Create a copy of OptionSetConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? options = null,
    Object? optionsToHide = null,
    Object? optionsToShow = null,
  }) {
    return _then(BigOptionSet(
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DataOption>,
      optionsToHide: null == optionsToHide
          ? _self._optionsToHide
          : optionsToHide // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optionsToShow: null == optionsToShow
          ? _self._optionsToShow
          : optionsToShow // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
