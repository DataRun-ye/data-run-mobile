// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_state.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormState {
  List<FieldUiModel> get fields;
  double get completionPercentage;
  bool get isLoading;
  bool get calculationLoop;
  List<ConfigurationError> get configErrors; // fpdart
// required Option<String> focusedFieldId,
  String? get focusedFieldId;

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FormStateCopyWith<FormState> get copyWith =>
      _$FormStateCopyWithImpl<FormState>(this as FormState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FormState &&
            const DeepCollectionEquality().equals(other.fields, fields) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.calculationLoop, calculationLoop) ||
                other.calculationLoop == calculationLoop) &&
            const DeepCollectionEquality()
                .equals(other.configErrors, configErrors) &&
            (identical(other.focusedFieldId, focusedFieldId) ||
                other.focusedFieldId == focusedFieldId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fields),
      completionPercentage,
      isLoading,
      calculationLoop,
      const DeepCollectionEquality().hash(configErrors),
      focusedFieldId);

  @override
  String toString() {
    return 'FormState(fields: $fields, completionPercentage: $completionPercentage, isLoading: $isLoading, calculationLoop: $calculationLoop, configErrors: $configErrors, focusedFieldId: $focusedFieldId)';
  }
}

/// @nodoc
abstract mixin class $FormStateCopyWith<$Res> {
  factory $FormStateCopyWith(FormState value, $Res Function(FormState) _then) =
      _$FormStateCopyWithImpl;
  @useResult
  $Res call(
      {List<FieldUiModel> fields,
      double completionPercentage,
      bool isLoading,
      bool calculationLoop,
      List<ConfigurationError> configErrors,
      String? focusedFieldId});
}

/// @nodoc
class _$FormStateCopyWithImpl<$Res> implements $FormStateCopyWith<$Res> {
  _$FormStateCopyWithImpl(this._self, this._then);

  final FormState _self;
  final $Res Function(FormState) _then;

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fields = null,
    Object? completionPercentage = null,
    Object? isLoading = null,
    Object? calculationLoop = null,
    Object? configErrors = null,
    Object? focusedFieldId = freezed,
  }) {
    return _then(_self.copyWith(
      fields: null == fields
          ? _self.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FieldUiModel>,
      completionPercentage: null == completionPercentage
          ? _self.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      calculationLoop: null == calculationLoop
          ? _self.calculationLoop
          : calculationLoop // ignore: cast_nullable_to_non_nullable
              as bool,
      configErrors: null == configErrors
          ? _self.configErrors
          : configErrors // ignore: cast_nullable_to_non_nullable
              as List<ConfigurationError>,
      focusedFieldId: freezed == focusedFieldId
          ? _self.focusedFieldId
          : focusedFieldId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FormState].
extension FormStatePatterns on FormState {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FormState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FormState() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_FormState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormState():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FormState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormState() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<FieldUiModel> fields,
            double completionPercentage,
            bool isLoading,
            bool calculationLoop,
            List<ConfigurationError> configErrors,
            String? focusedFieldId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FormState() when $default != null:
        return $default(
            _that.fields,
            _that.completionPercentage,
            _that.isLoading,
            _that.calculationLoop,
            _that.configErrors,
            _that.focusedFieldId);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            List<FieldUiModel> fields,
            double completionPercentage,
            bool isLoading,
            bool calculationLoop,
            List<ConfigurationError> configErrors,
            String? focusedFieldId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormState():
        return $default(
            _that.fields,
            _that.completionPercentage,
            _that.isLoading,
            _that.calculationLoop,
            _that.configErrors,
            _that.focusedFieldId);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<FieldUiModel> fields,
            double completionPercentage,
            bool isLoading,
            bool calculationLoop,
            List<ConfigurationError> configErrors,
            String? focusedFieldId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FormState() when $default != null:
        return $default(
            _that.fields,
            _that.completionPercentage,
            _that.isLoading,
            _that.calculationLoop,
            _that.configErrors,
            _that.focusedFieldId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FormState implements FormState {
  const _FormState(
      {required final List<FieldUiModel> fields,
      required this.completionPercentage,
      required this.isLoading,
      required this.calculationLoop,
      required final List<ConfigurationError> configErrors,
      required this.focusedFieldId})
      : _fields = fields,
        _configErrors = configErrors;

  final List<FieldUiModel> _fields;
  @override
  List<FieldUiModel> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  final double completionPercentage;
  @override
  final bool isLoading;
  @override
  final bool calculationLoop;
  final List<ConfigurationError> _configErrors;
  @override
  List<ConfigurationError> get configErrors {
    if (_configErrors is EqualUnmodifiableListView) return _configErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_configErrors);
  }

// fpdart
// required Option<String> focusedFieldId,
  @override
  final String? focusedFieldId;

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FormStateCopyWith<_FormState> get copyWith =>
      __$FormStateCopyWithImpl<_FormState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FormState &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.calculationLoop, calculationLoop) ||
                other.calculationLoop == calculationLoop) &&
            const DeepCollectionEquality()
                .equals(other._configErrors, _configErrors) &&
            (identical(other.focusedFieldId, focusedFieldId) ||
                other.focusedFieldId == focusedFieldId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fields),
      completionPercentage,
      isLoading,
      calculationLoop,
      const DeepCollectionEquality().hash(_configErrors),
      focusedFieldId);

  @override
  String toString() {
    return 'FormState(fields: $fields, completionPercentage: $completionPercentage, isLoading: $isLoading, calculationLoop: $calculationLoop, configErrors: $configErrors, focusedFieldId: $focusedFieldId)';
  }
}

/// @nodoc
abstract mixin class _$FormStateCopyWith<$Res>
    implements $FormStateCopyWith<$Res> {
  factory _$FormStateCopyWith(
          _FormState value, $Res Function(_FormState) _then) =
      __$FormStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<FieldUiModel> fields,
      double completionPercentage,
      bool isLoading,
      bool calculationLoop,
      List<ConfigurationError> configErrors,
      String? focusedFieldId});
}

/// @nodoc
class __$FormStateCopyWithImpl<$Res> implements _$FormStateCopyWith<$Res> {
  __$FormStateCopyWithImpl(this._self, this._then);

  final _FormState _self;
  final $Res Function(_FormState) _then;

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fields = null,
    Object? completionPercentage = null,
    Object? isLoading = null,
    Object? calculationLoop = null,
    Object? configErrors = null,
    Object? focusedFieldId = freezed,
  }) {
    return _then(_FormState(
      fields: null == fields
          ? _self._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FieldUiModel>,
      completionPercentage: null == completionPercentage
          ? _self.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      calculationLoop: null == calculationLoop
          ? _self.calculationLoop
          : calculationLoop // ignore: cast_nullable_to_non_nullable
              as bool,
      configErrors: null == configErrors
          ? _self._configErrors
          : configErrors // ignore: cast_nullable_to_non_nullable
              as List<ConfigurationError>,
      focusedFieldId: freezed == focusedFieldId
          ? _self.focusedFieldId
          : focusedFieldId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
