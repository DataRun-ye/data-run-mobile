// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_state.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FormState {
  List<FieldUiModel> get fields => throw _privateConstructorUsedError;
  double get completionPercentage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get calculationLoop => throw _privateConstructorUsedError;
  List<ConfigurationError> get configErrors =>
      throw _privateConstructorUsedError; // fpdart
// required Option<String> focusedFieldId,
  String? get focusedFieldId => throw _privateConstructorUsedError;

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormStateCopyWith<FormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormStateCopyWith<$Res> {
  factory $FormStateCopyWith(FormState value, $Res Function(FormState) then) =
      _$FormStateCopyWithImpl<$Res, FormState>;
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
class _$FormStateCopyWithImpl<$Res, $Val extends FormState>
    implements $FormStateCopyWith<$Res> {
  _$FormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FieldUiModel>,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      calculationLoop: null == calculationLoop
          ? _value.calculationLoop
          : calculationLoop // ignore: cast_nullable_to_non_nullable
              as bool,
      configErrors: null == configErrors
          ? _value.configErrors
          : configErrors // ignore: cast_nullable_to_non_nullable
              as List<ConfigurationError>,
      focusedFieldId: freezed == focusedFieldId
          ? _value.focusedFieldId
          : focusedFieldId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormStateImplCopyWith<$Res>
    implements $FormStateCopyWith<$Res> {
  factory _$$FormStateImplCopyWith(
          _$FormStateImpl value, $Res Function(_$FormStateImpl) then) =
      __$$FormStateImplCopyWithImpl<$Res>;
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
class __$$FormStateImplCopyWithImpl<$Res>
    extends _$FormStateCopyWithImpl<$Res, _$FormStateImpl>
    implements _$$FormStateImplCopyWith<$Res> {
  __$$FormStateImplCopyWithImpl(
      _$FormStateImpl _value, $Res Function(_$FormStateImpl) _then)
      : super(_value, _then);

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
    return _then(_$FormStateImpl(
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FieldUiModel>,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      calculationLoop: null == calculationLoop
          ? _value.calculationLoop
          : calculationLoop // ignore: cast_nullable_to_non_nullable
              as bool,
      configErrors: null == configErrors
          ? _value._configErrors
          : configErrors // ignore: cast_nullable_to_non_nullable
              as List<ConfigurationError>,
      focusedFieldId: freezed == focusedFieldId
          ? _value.focusedFieldId
          : focusedFieldId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FormStateImpl implements _FormState {
  const _$FormStateImpl(
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

  @override
  String toString() {
    return 'FormState(fields: $fields, completionPercentage: $completionPercentage, isLoading: $isLoading, calculationLoop: $calculationLoop, configErrors: $configErrors, focusedFieldId: $focusedFieldId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormStateImpl &&
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

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormStateImplCopyWith<_$FormStateImpl> get copyWith =>
      __$$FormStateImplCopyWithImpl<_$FormStateImpl>(this, _$identity);
}

abstract class _FormState implements FormState {
  const factory _FormState(
      {required final List<FieldUiModel> fields,
      required final double completionPercentage,
      required final bool isLoading,
      required final bool calculationLoop,
      required final List<ConfigurationError> configErrors,
      required final String? focusedFieldId}) = _$FormStateImpl;

  @override
  List<FieldUiModel> get fields;
  @override
  double get completionPercentage;
  @override
  bool get isLoading;
  @override
  bool get calculationLoop;
  @override
  List<ConfigurationError> get configErrors; // fpdart
// required Option<String> focusedFieldId,
  @override
  String? get focusedFieldId;

  /// Create a copy of FormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormStateImplCopyWith<_$FormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
