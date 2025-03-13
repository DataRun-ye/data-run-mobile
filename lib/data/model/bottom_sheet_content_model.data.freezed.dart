// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_sheet_content_model.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DialogContentModel {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  BottomSheetBodyModel get body => throw _privateConstructorUsedError;

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DialogContentModelCopyWith<DialogContentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogContentModelCopyWith<$Res> {
  factory $DialogContentModelCopyWith(
          DialogContentModel value, $Res Function(DialogContentModel) then) =
      _$DialogContentModelCopyWithImpl<$Res, DialogContentModel>;
  @useResult
  $Res call(
      {String title,
      String subtitle,
      IconData icon,
      BottomSheetBodyModel body});

  $BottomSheetBodyModelCopyWith<$Res> get body;
}

/// @nodoc
class _$DialogContentModelCopyWithImpl<$Res, $Val extends DialogContentModel>
    implements $DialogContentModelCopyWith<$Res> {
  _$DialogContentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? icon = null,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as BottomSheetBodyModel,
    ) as $Val);
  }

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BottomSheetBodyModelCopyWith<$Res> get body {
    return $BottomSheetBodyModelCopyWith<$Res>(_value.body, (value) {
      return _then(_value.copyWith(body: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DialogContentModelImplCopyWith<$Res>
    implements $DialogContentModelCopyWith<$Res> {
  factory _$$DialogContentModelImplCopyWith(_$DialogContentModelImpl value,
          $Res Function(_$DialogContentModelImpl) then) =
      __$$DialogContentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String subtitle,
      IconData icon,
      BottomSheetBodyModel body});

  @override
  $BottomSheetBodyModelCopyWith<$Res> get body;
}

/// @nodoc
class __$$DialogContentModelImplCopyWithImpl<$Res>
    extends _$DialogContentModelCopyWithImpl<$Res, _$DialogContentModelImpl>
    implements _$$DialogContentModelImplCopyWith<$Res> {
  __$$DialogContentModelImplCopyWithImpl(_$DialogContentModelImpl _value,
      $Res Function(_$DialogContentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? icon = null,
    Object? body = null,
  }) {
    return _then(_$DialogContentModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as BottomSheetBodyModel,
    ));
  }
}

/// @nodoc

class _$DialogContentModelImpl implements _DialogContentModel {
  const _$DialogContentModelImpl(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.body});

  @override
  final String title;
  @override
  final String subtitle;
  @override
  final IconData icon;
  @override
  final BottomSheetBodyModel body;

  @override
  String toString() {
    return 'DialogContentModel(title: $title, subtitle: $subtitle, icon: $icon, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DialogContentModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, subtitle, icon, body);

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DialogContentModelImplCopyWith<_$DialogContentModelImpl> get copyWith =>
      __$$DialogContentModelImplCopyWithImpl<_$DialogContentModelImpl>(
          this, _$identity);
}

abstract class _DialogContentModel implements DialogContentModel {
  const factory _DialogContentModel(
      {required final String title,
      required final String subtitle,
      required final IconData icon,
      required final BottomSheetBodyModel body}) = _$DialogContentModelImpl;

  @override
  String get title;
  @override
  String get subtitle;
  @override
  IconData get icon;
  @override
  BottomSheetBodyModel get body;

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DialogContentModelImplCopyWith<_$DialogContentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BottomSheetBodyModel {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) messageBody,
    required TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)
        errorsBody,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? messageBody,
    TResult? Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? messageBody,
    TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageBody value) messageBody,
    required TResult Function(ErrorsBody value) errorsBody,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageBody value)? messageBody,
    TResult? Function(ErrorsBody value)? errorsBody,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageBody value)? messageBody,
    TResult Function(ErrorsBody value)? errorsBody,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BottomSheetBodyModelCopyWith<BottomSheetBodyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomSheetBodyModelCopyWith<$Res> {
  factory $BottomSheetBodyModelCopyWith(BottomSheetBodyModel value,
          $Res Function(BottomSheetBodyModel) then) =
      _$BottomSheetBodyModelCopyWithImpl<$Res, BottomSheetBodyModel>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$BottomSheetBodyModelCopyWithImpl<$Res,
        $Val extends BottomSheetBodyModel>
    implements $BottomSheetBodyModelCopyWith<$Res> {
  _$BottomSheetBodyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$MessageBodyImplCopyWith<$Res>
    implements $BottomSheetBodyModelCopyWith<$Res> {
  factory _$$MessageBodyImplCopyWith(
          _$MessageBodyImpl value, $Res Function(_$MessageBodyImpl) then) =
      __$$MessageBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MessageBodyImplCopyWithImpl<$Res>
    extends _$BottomSheetBodyModelCopyWithImpl<$Res, _$MessageBodyImpl>
    implements _$$MessageBodyImplCopyWith<$Res> {
  __$$MessageBodyImplCopyWithImpl(
      _$MessageBodyImpl _value, $Res Function(_$MessageBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MessageBodyImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageBodyImpl implements MessageBody {
  _$MessageBodyImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'BottomSheetBodyModel.messageBody(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageBodyImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageBodyImplCopyWith<_$MessageBodyImpl> get copyWith =>
      __$$MessageBodyImplCopyWithImpl<_$MessageBodyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) messageBody,
    required TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)
        errorsBody,
  }) {
    return messageBody(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? messageBody,
    TResult? Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
  }) {
    return messageBody?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? messageBody,
    TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
    required TResult orElse(),
  }) {
    if (messageBody != null) {
      return messageBody(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageBody value) messageBody,
    required TResult Function(ErrorsBody value) errorsBody,
  }) {
    return messageBody(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageBody value)? messageBody,
    TResult? Function(ErrorsBody value)? errorsBody,
  }) {
    return messageBody?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageBody value)? messageBody,
    TResult Function(ErrorsBody value)? errorsBody,
    required TResult orElse(),
  }) {
    if (messageBody != null) {
      return messageBody(this);
    }
    return orElse();
  }
}

abstract class MessageBody implements BottomSheetBodyModel {
  factory MessageBody({required final String message}) = _$MessageBodyImpl;

  @override
  String get message;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageBodyImplCopyWith<_$MessageBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorsBodyImplCopyWith<$Res>
    implements $BottomSheetBodyModelCopyWith<$Res> {
  factory _$$ErrorsBodyImplCopyWith(
          _$ErrorsBodyImpl value, $Res Function(_$ErrorsBodyImpl) then) =
      __$$ErrorsBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, Map<String, List<FieldWithIssue>> fieldsWithIssues});
}

/// @nodoc
class __$$ErrorsBodyImplCopyWithImpl<$Res>
    extends _$BottomSheetBodyModelCopyWithImpl<$Res, _$ErrorsBodyImpl>
    implements _$$ErrorsBodyImplCopyWith<$Res> {
  __$$ErrorsBodyImplCopyWithImpl(
      _$ErrorsBodyImpl _value, $Res Function(_$ErrorsBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fieldsWithIssues = null,
  }) {
    return _then(_$ErrorsBodyImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      fieldsWithIssues: null == fieldsWithIssues
          ? _value._fieldsWithIssues
          : fieldsWithIssues // ignore: cast_nullable_to_non_nullable
              as Map<String, List<FieldWithIssue>>,
    ));
  }
}

/// @nodoc

class _$ErrorsBodyImpl implements ErrorsBody {
  _$ErrorsBodyImpl(
      {required this.message,
      required final Map<String, List<FieldWithIssue>> fieldsWithIssues})
      : _fieldsWithIssues = fieldsWithIssues;

  @override
  final String message;
  final Map<String, List<FieldWithIssue>> _fieldsWithIssues;
  @override
  Map<String, List<FieldWithIssue>> get fieldsWithIssues {
    if (_fieldsWithIssues is EqualUnmodifiableMapView) return _fieldsWithIssues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldsWithIssues);
  }

  @override
  String toString() {
    return 'BottomSheetBodyModel.errorsBody(message: $message, fieldsWithIssues: $fieldsWithIssues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorsBodyImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._fieldsWithIssues, _fieldsWithIssues));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(_fieldsWithIssues));

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorsBodyImplCopyWith<_$ErrorsBodyImpl> get copyWith =>
      __$$ErrorsBodyImplCopyWithImpl<_$ErrorsBodyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) messageBody,
    required TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)
        errorsBody,
  }) {
    return errorsBody(message, fieldsWithIssues);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? messageBody,
    TResult? Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
  }) {
    return errorsBody?.call(message, fieldsWithIssues);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? messageBody,
    TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
    required TResult orElse(),
  }) {
    if (errorsBody != null) {
      return errorsBody(message, fieldsWithIssues);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageBody value) messageBody,
    required TResult Function(ErrorsBody value) errorsBody,
  }) {
    return errorsBody(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageBody value)? messageBody,
    TResult? Function(ErrorsBody value)? errorsBody,
  }) {
    return errorsBody?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageBody value)? messageBody,
    TResult Function(ErrorsBody value)? errorsBody,
    required TResult orElse(),
  }) {
    if (errorsBody != null) {
      return errorsBody(this);
    }
    return orElse();
  }
}

abstract class ErrorsBody implements BottomSheetBodyModel {
  factory ErrorsBody(
          {required final String message,
          required final Map<String, List<FieldWithIssue>> fieldsWithIssues}) =
      _$ErrorsBodyImpl;

  @override
  String get message;
  Map<String, List<FieldWithIssue>> get fieldsWithIssues;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorsBodyImplCopyWith<_$ErrorsBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FieldWithIssue {
  String? get repeatGroupUid => throw _privateConstructorUsedError;
  String? get rowUid => throw _privateConstructorUsedError;
  String? get parent => throw _privateConstructorUsedError;
  String get fieldPath =>
      throw _privateConstructorUsedError; // path to the leaf field with an error
  String get fieldUid =>
      throw _privateConstructorUsedError; // path to the leaf field with an error
  String get fieldName =>
      throw _privateConstructorUsedError; // name of the leaf field
  IssueType get issueType => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldWithIssueCopyWith<FieldWithIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldWithIssueCopyWith<$Res> {
  factory $FieldWithIssueCopyWith(
          FieldWithIssue value, $Res Function(FieldWithIssue) then) =
      _$FieldWithIssueCopyWithImpl<$Res, FieldWithIssue>;
  @useResult
  $Res call(
      {String? repeatGroupUid,
      String? rowUid,
      String? parent,
      String fieldPath,
      String fieldUid,
      String fieldName,
      IssueType issueType,
      String message});
}

/// @nodoc
class _$FieldWithIssueCopyWithImpl<$Res, $Val extends FieldWithIssue>
    implements $FieldWithIssueCopyWith<$Res> {
  _$FieldWithIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repeatGroupUid = freezed,
    Object? rowUid = freezed,
    Object? parent = freezed,
    Object? fieldPath = null,
    Object? fieldUid = null,
    Object? fieldName = null,
    Object? issueType = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      repeatGroupUid: freezed == repeatGroupUid
          ? _value.repeatGroupUid
          : repeatGroupUid // ignore: cast_nullable_to_non_nullable
              as String?,
      rowUid: freezed == rowUid
          ? _value.rowUid
          : rowUid // ignore: cast_nullable_to_non_nullable
              as String?,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldPath: null == fieldPath
          ? _value.fieldPath
          : fieldPath // ignore: cast_nullable_to_non_nullable
              as String,
      fieldUid: null == fieldUid
          ? _value.fieldUid
          : fieldUid // ignore: cast_nullable_to_non_nullable
              as String,
      fieldName: null == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      issueType: null == issueType
          ? _value.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as IssueType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldWithIssueImplCopyWith<$Res>
    implements $FieldWithIssueCopyWith<$Res> {
  factory _$$FieldWithIssueImplCopyWith(_$FieldWithIssueImpl value,
          $Res Function(_$FieldWithIssueImpl) then) =
      __$$FieldWithIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? repeatGroupUid,
      String? rowUid,
      String? parent,
      String fieldPath,
      String fieldUid,
      String fieldName,
      IssueType issueType,
      String message});
}

/// @nodoc
class __$$FieldWithIssueImplCopyWithImpl<$Res>
    extends _$FieldWithIssueCopyWithImpl<$Res, _$FieldWithIssueImpl>
    implements _$$FieldWithIssueImplCopyWith<$Res> {
  __$$FieldWithIssueImplCopyWithImpl(
      _$FieldWithIssueImpl _value, $Res Function(_$FieldWithIssueImpl) _then)
      : super(_value, _then);

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repeatGroupUid = freezed,
    Object? rowUid = freezed,
    Object? parent = freezed,
    Object? fieldPath = null,
    Object? fieldUid = null,
    Object? fieldName = null,
    Object? issueType = null,
    Object? message = null,
  }) {
    return _then(_$FieldWithIssueImpl(
      repeatGroupUid: freezed == repeatGroupUid
          ? _value.repeatGroupUid
          : repeatGroupUid // ignore: cast_nullable_to_non_nullable
              as String?,
      rowUid: freezed == rowUid
          ? _value.rowUid
          : rowUid // ignore: cast_nullable_to_non_nullable
              as String?,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldPath: null == fieldPath
          ? _value.fieldPath
          : fieldPath // ignore: cast_nullable_to_non_nullable
              as String,
      fieldUid: null == fieldUid
          ? _value.fieldUid
          : fieldUid // ignore: cast_nullable_to_non_nullable
              as String,
      fieldName: null == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      issueType: null == issueType
          ? _value.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as IssueType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FieldWithIssueImpl implements _FieldWithIssue {
  const _$FieldWithIssueImpl(
      {this.repeatGroupUid,
      this.rowUid,
      this.parent,
      required this.fieldPath,
      required this.fieldUid,
      required this.fieldName,
      this.issueType = IssueType.Error,
      this.message = 'Error'});

  @override
  final String? repeatGroupUid;
  @override
  final String? rowUid;
  @override
  final String? parent;
  @override
  final String fieldPath;
// path to the leaf field with an error
  @override
  final String fieldUid;
// path to the leaf field with an error
  @override
  final String fieldName;
// name of the leaf field
  @override
  @JsonKey()
  final IssueType issueType;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'FieldWithIssue(repeatGroupUid: $repeatGroupUid, rowUid: $rowUid, parent: $parent, fieldPath: $fieldPath, fieldUid: $fieldUid, fieldName: $fieldName, issueType: $issueType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldWithIssueImpl &&
            (identical(other.repeatGroupUid, repeatGroupUid) ||
                other.repeatGroupUid == repeatGroupUid) &&
            (identical(other.rowUid, rowUid) || other.rowUid == rowUid) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            (identical(other.fieldPath, fieldPath) ||
                other.fieldPath == fieldPath) &&
            (identical(other.fieldUid, fieldUid) ||
                other.fieldUid == fieldUid) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.issueType, issueType) ||
                other.issueType == issueType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, repeatGroupUid, rowUid, parent,
      fieldPath, fieldUid, fieldName, issueType, message);

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldWithIssueImplCopyWith<_$FieldWithIssueImpl> get copyWith =>
      __$$FieldWithIssueImplCopyWithImpl<_$FieldWithIssueImpl>(
          this, _$identity);
}

abstract class _FieldWithIssue implements FieldWithIssue {
  const factory _FieldWithIssue(
      {final String? repeatGroupUid,
      final String? rowUid,
      final String? parent,
      required final String fieldPath,
      required final String fieldUid,
      required final String fieldName,
      final IssueType issueType,
      final String message}) = _$FieldWithIssueImpl;

  @override
  String? get repeatGroupUid;
  @override
  String? get rowUid;
  @override
  String? get parent;
  @override
  String get fieldPath; // path to the leaf field with an error
  @override
  String get fieldUid; // path to the leaf field with an error
  @override
  String get fieldName; // name of the leaf field
  @override
  IssueType get issueType;
  @override
  String get message;

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldWithIssueImplCopyWith<_$FieldWithIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
