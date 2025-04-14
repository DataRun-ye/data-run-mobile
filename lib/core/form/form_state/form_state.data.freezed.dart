// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  DataIntegrityCheckResult? get integrityResult;
  List<ConfigurationError> get configErrors;

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
            (identical(other.integrityResult, integrityResult) ||
                other.integrityResult == integrityResult) &&
            const DeepCollectionEquality()
                .equals(other.configErrors, configErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fields),
      completionPercentage,
      isLoading,
      calculationLoop,
      integrityResult,
      const DeepCollectionEquality().hash(configErrors));

  @override
  String toString() {
    return 'FormState(fields: $fields, completionPercentage: $completionPercentage, isLoading: $isLoading, calculationLoop: $calculationLoop, integrityResult: $integrityResult, configErrors: $configErrors)';
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
      DataIntegrityCheckResult? integrityResult,
      List<ConfigurationError> configErrors});
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
    Object? integrityResult = freezed,
    Object? configErrors = null,
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
      integrityResult: freezed == integrityResult
          ? _self.integrityResult
          : integrityResult // ignore: cast_nullable_to_non_nullable
              as DataIntegrityCheckResult?,
      configErrors: null == configErrors
          ? _self.configErrors
          : configErrors // ignore: cast_nullable_to_non_nullable
              as List<ConfigurationError>,
    ));
  }
}

/// @nodoc

class _FormState implements FormState {
  const _FormState(
      {required final List<FieldUiModel> fields,
      required this.completionPercentage,
      required this.isLoading,
      required this.calculationLoop,
      required this.integrityResult,
      required final List<ConfigurationError> configErrors})
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
  @override
  final DataIntegrityCheckResult? integrityResult;
  final List<ConfigurationError> _configErrors;
  @override
  List<ConfigurationError> get configErrors {
    if (_configErrors is EqualUnmodifiableListView) return _configErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_configErrors);
  }

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
            (identical(other.integrityResult, integrityResult) ||
                other.integrityResult == integrityResult) &&
            const DeepCollectionEquality()
                .equals(other._configErrors, _configErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fields),
      completionPercentage,
      isLoading,
      calculationLoop,
      integrityResult,
      const DeepCollectionEquality().hash(_configErrors));

  @override
  String toString() {
    return 'FormState(fields: $fields, completionPercentage: $completionPercentage, isLoading: $isLoading, calculationLoop: $calculationLoop, integrityResult: $integrityResult, configErrors: $configErrors)';
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
      DataIntegrityCheckResult? integrityResult,
      List<ConfigurationError> configErrors});
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
    Object? integrityResult = freezed,
    Object? configErrors = null,
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
      integrityResult: freezed == integrityResult
          ? _self.integrityResult
          : integrityResult // ignore: cast_nullable_to_non_nullable
              as DataIntegrityCheckResult?,
      configErrors: null == configErrors
          ? _self._configErrors
          : configErrors // ignore: cast_nullable_to_non_nullable
              as List<ConfigurationError>,
    ));
  }
}

// dart format on
