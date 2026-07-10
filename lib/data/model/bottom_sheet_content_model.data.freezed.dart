// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_sheet_content_model.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DialogContentModel {
  String get title;
  String get subtitle;
  IconData get icon;
  BottomSheetBodyModel get body;

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DialogContentModelCopyWith<DialogContentModel> get copyWith =>
      _$DialogContentModelCopyWithImpl<DialogContentModel>(
          this as DialogContentModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DialogContentModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, subtitle, icon, body);

  @override
  String toString() {
    return 'DialogContentModel(title: $title, subtitle: $subtitle, icon: $icon, body: $body)';
  }
}

/// @nodoc
abstract mixin class $DialogContentModelCopyWith<$Res> {
  factory $DialogContentModelCopyWith(
          DialogContentModel value, $Res Function(DialogContentModel) _then) =
      _$DialogContentModelCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      String subtitle,
      IconData icon,
      BottomSheetBodyModel body});

  $BottomSheetBodyModelCopyWith<$Res> get body;
}

/// @nodoc
class _$DialogContentModelCopyWithImpl<$Res>
    implements $DialogContentModelCopyWith<$Res> {
  _$DialogContentModelCopyWithImpl(this._self, this._then);

  final DialogContentModel _self;
  final $Res Function(DialogContentModel) _then;

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
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as BottomSheetBodyModel,
    ));
  }

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BottomSheetBodyModelCopyWith<$Res> get body {
    return $BottomSheetBodyModelCopyWith<$Res>(_self.body, (value) {
      return _then(_self.copyWith(body: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DialogContentModel].
extension DialogContentModelPatterns on DialogContentModel {
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
    TResult Function(_DialogContentModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DialogContentModel() when $default != null:
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
    TResult Function(_DialogContentModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DialogContentModel():
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
    TResult? Function(_DialogContentModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DialogContentModel() when $default != null:
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
    TResult Function(String title, String subtitle, IconData icon,
            BottomSheetBodyModel body)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DialogContentModel() when $default != null:
        return $default(_that.title, _that.subtitle, _that.icon, _that.body);
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
    TResult Function(String title, String subtitle, IconData icon,
            BottomSheetBodyModel body)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DialogContentModel():
        return $default(_that.title, _that.subtitle, _that.icon, _that.body);
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
    TResult? Function(String title, String subtitle, IconData icon,
            BottomSheetBodyModel body)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DialogContentModel() when $default != null:
        return $default(_that.title, _that.subtitle, _that.icon, _that.body);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DialogContentModel implements DialogContentModel {
  const _DialogContentModel(
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

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DialogContentModelCopyWith<_DialogContentModel> get copyWith =>
      __$DialogContentModelCopyWithImpl<_DialogContentModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DialogContentModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, subtitle, icon, body);

  @override
  String toString() {
    return 'DialogContentModel(title: $title, subtitle: $subtitle, icon: $icon, body: $body)';
  }
}

/// @nodoc
abstract mixin class _$DialogContentModelCopyWith<$Res>
    implements $DialogContentModelCopyWith<$Res> {
  factory _$DialogContentModelCopyWith(
          _DialogContentModel value, $Res Function(_DialogContentModel) _then) =
      __$DialogContentModelCopyWithImpl;
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
class __$DialogContentModelCopyWithImpl<$Res>
    implements _$DialogContentModelCopyWith<$Res> {
  __$DialogContentModelCopyWithImpl(this._self, this._then);

  final _DialogContentModel _self;
  final $Res Function(_DialogContentModel) _then;

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? icon = null,
    Object? body = null,
  }) {
    return _then(_DialogContentModel(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as BottomSheetBodyModel,
    ));
  }

  /// Create a copy of DialogContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BottomSheetBodyModelCopyWith<$Res> get body {
    return $BottomSheetBodyModelCopyWith<$Res>(_self.body, (value) {
      return _then(_self.copyWith(body: value));
    });
  }
}

/// @nodoc
mixin _$BottomSheetBodyModel {
  String get message;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BottomSheetBodyModelCopyWith<BottomSheetBodyModel> get copyWith =>
      _$BottomSheetBodyModelCopyWithImpl<BottomSheetBodyModel>(
          this as BottomSheetBodyModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BottomSheetBodyModel &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'BottomSheetBodyModel(message: $message)';
  }
}

/// @nodoc
abstract mixin class $BottomSheetBodyModelCopyWith<$Res> {
  factory $BottomSheetBodyModelCopyWith(BottomSheetBodyModel value,
          $Res Function(BottomSheetBodyModel) _then) =
      _$BottomSheetBodyModelCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$BottomSheetBodyModelCopyWithImpl<$Res>
    implements $BottomSheetBodyModelCopyWith<$Res> {
  _$BottomSheetBodyModelCopyWithImpl(this._self, this._then);

  final BottomSheetBodyModel _self;
  final $Res Function(BottomSheetBodyModel) _then;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BottomSheetBodyModel].
extension BottomSheetBodyModelPatterns on BottomSheetBodyModel {
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
    TResult Function(MessageBody value)? messageBody,
    TResult Function(ErrorsBody value)? errorsBody,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MessageBody() when messageBody != null:
        return messageBody(_that);
      case ErrorsBody() when errorsBody != null:
        return errorsBody(_that);
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
    required TResult Function(MessageBody value) messageBody,
    required TResult Function(ErrorsBody value) errorsBody,
  }) {
    final _that = this;
    switch (_that) {
      case MessageBody():
        return messageBody(_that);
      case ErrorsBody():
        return errorsBody(_that);
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
    TResult? Function(MessageBody value)? messageBody,
    TResult? Function(ErrorsBody value)? errorsBody,
  }) {
    final _that = this;
    switch (_that) {
      case MessageBody() when messageBody != null:
        return messageBody(_that);
      case ErrorsBody() when errorsBody != null:
        return errorsBody(_that);
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
    TResult Function(String message)? messageBody,
    TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MessageBody() when messageBody != null:
        return messageBody(_that.message);
      case ErrorsBody() when errorsBody != null:
        return errorsBody(_that.message, _that.fieldsWithIssues);
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
    required TResult Function(String message) messageBody,
    required TResult Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)
        errorsBody,
  }) {
    final _that = this;
    switch (_that) {
      case MessageBody():
        return messageBody(_that.message);
      case ErrorsBody():
        return errorsBody(_that.message, _that.fieldsWithIssues);
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
    TResult? Function(String message)? messageBody,
    TResult? Function(
            String message, Map<String, List<FieldWithIssue>> fieldsWithIssues)?
        errorsBody,
  }) {
    final _that = this;
    switch (_that) {
      case MessageBody() when messageBody != null:
        return messageBody(_that.message);
      case ErrorsBody() when errorsBody != null:
        return errorsBody(_that.message, _that.fieldsWithIssues);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MessageBody implements BottomSheetBodyModel {
  MessageBody({required this.message});

  @override
  final String message;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageBodyCopyWith<MessageBody> get copyWith =>
      _$MessageBodyCopyWithImpl<MessageBody>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageBody &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'BottomSheetBodyModel.messageBody(message: $message)';
  }
}

/// @nodoc
abstract mixin class $MessageBodyCopyWith<$Res>
    implements $BottomSheetBodyModelCopyWith<$Res> {
  factory $MessageBodyCopyWith(
          MessageBody value, $Res Function(MessageBody) _then) =
      _$MessageBodyCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$MessageBodyCopyWithImpl<$Res> implements $MessageBodyCopyWith<$Res> {
  _$MessageBodyCopyWithImpl(this._self, this._then);

  final MessageBody _self;
  final $Res Function(MessageBody) _then;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(MessageBody(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ErrorsBody implements BottomSheetBodyModel {
  ErrorsBody(
      {required this.message,
      required final Map<String, List<FieldWithIssue>> fieldsWithIssues})
      : _fieldsWithIssues = fieldsWithIssues;

  @override
  final String message;
  final Map<String, List<FieldWithIssue>> _fieldsWithIssues;
  Map<String, List<FieldWithIssue>> get fieldsWithIssues {
    if (_fieldsWithIssues is EqualUnmodifiableMapView) return _fieldsWithIssues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldsWithIssues);
  }

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorsBodyCopyWith<ErrorsBody> get copyWith =>
      _$ErrorsBodyCopyWithImpl<ErrorsBody>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorsBody &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._fieldsWithIssues, _fieldsWithIssues));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(_fieldsWithIssues));

  @override
  String toString() {
    return 'BottomSheetBodyModel.errorsBody(message: $message, fieldsWithIssues: $fieldsWithIssues)';
  }
}

/// @nodoc
abstract mixin class $ErrorsBodyCopyWith<$Res>
    implements $BottomSheetBodyModelCopyWith<$Res> {
  factory $ErrorsBodyCopyWith(
          ErrorsBody value, $Res Function(ErrorsBody) _then) =
      _$ErrorsBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String message, Map<String, List<FieldWithIssue>> fieldsWithIssues});
}

/// @nodoc
class _$ErrorsBodyCopyWithImpl<$Res> implements $ErrorsBodyCopyWith<$Res> {
  _$ErrorsBodyCopyWithImpl(this._self, this._then);

  final ErrorsBody _self;
  final $Res Function(ErrorsBody) _then;

  /// Create a copy of BottomSheetBodyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? fieldsWithIssues = null,
  }) {
    return _then(ErrorsBody(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      fieldsWithIssues: null == fieldsWithIssues
          ? _self._fieldsWithIssues
          : fieldsWithIssues // ignore: cast_nullable_to_non_nullable
              as Map<String, List<FieldWithIssue>>,
    ));
  }
}

/// @nodoc
mixin _$FieldWithIssue {
  String? get repeatGroupUid;
  String? get rowUid;
  String? get parent;
  String? get fieldPath; // path to the leaf field with an error
  String get fieldUid; // path to the leaf field with an error
  String get fieldName; // name of the leaf field
  IssueType get issueType;
  String get message;

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldWithIssueCopyWith<FieldWithIssue> get copyWith =>
      _$FieldWithIssueCopyWithImpl<FieldWithIssue>(
          this as FieldWithIssue, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldWithIssue &&
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

  @override
  String toString() {
    return 'FieldWithIssue(repeatGroupUid: $repeatGroupUid, rowUid: $rowUid, parent: $parent, fieldPath: $fieldPath, fieldUid: $fieldUid, fieldName: $fieldName, issueType: $issueType, message: $message)';
  }
}

/// @nodoc
abstract mixin class $FieldWithIssueCopyWith<$Res> {
  factory $FieldWithIssueCopyWith(
          FieldWithIssue value, $Res Function(FieldWithIssue) _then) =
      _$FieldWithIssueCopyWithImpl;
  @useResult
  $Res call(
      {String? repeatGroupUid,
      String? rowUid,
      String? parent,
      String? fieldPath,
      String fieldUid,
      String fieldName,
      IssueType issueType,
      String message});
}

/// @nodoc
class _$FieldWithIssueCopyWithImpl<$Res>
    implements $FieldWithIssueCopyWith<$Res> {
  _$FieldWithIssueCopyWithImpl(this._self, this._then);

  final FieldWithIssue _self;
  final $Res Function(FieldWithIssue) _then;

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repeatGroupUid = freezed,
    Object? rowUid = freezed,
    Object? parent = freezed,
    Object? fieldPath = freezed,
    Object? fieldUid = null,
    Object? fieldName = null,
    Object? issueType = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      repeatGroupUid: freezed == repeatGroupUid
          ? _self.repeatGroupUid
          : repeatGroupUid // ignore: cast_nullable_to_non_nullable
              as String?,
      rowUid: freezed == rowUid
          ? _self.rowUid
          : rowUid // ignore: cast_nullable_to_non_nullable
              as String?,
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldPath: freezed == fieldPath
          ? _self.fieldPath
          : fieldPath // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldUid: null == fieldUid
          ? _self.fieldUid
          : fieldUid // ignore: cast_nullable_to_non_nullable
              as String,
      fieldName: null == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      issueType: null == issueType
          ? _self.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as IssueType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [FieldWithIssue].
extension FieldWithIssuePatterns on FieldWithIssue {
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
    TResult Function(_FieldWithIssue value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldWithIssue() when $default != null:
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
    TResult Function(_FieldWithIssue value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldWithIssue():
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
    TResult? Function(_FieldWithIssue value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldWithIssue() when $default != null:
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
            String? repeatGroupUid,
            String? rowUid,
            String? parent,
            String? fieldPath,
            String fieldUid,
            String fieldName,
            IssueType issueType,
            String message)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldWithIssue() when $default != null:
        return $default(
            _that.repeatGroupUid,
            _that.rowUid,
            _that.parent,
            _that.fieldPath,
            _that.fieldUid,
            _that.fieldName,
            _that.issueType,
            _that.message);
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
            String? repeatGroupUid,
            String? rowUid,
            String? parent,
            String? fieldPath,
            String fieldUid,
            String fieldName,
            IssueType issueType,
            String message)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldWithIssue():
        return $default(
            _that.repeatGroupUid,
            _that.rowUid,
            _that.parent,
            _that.fieldPath,
            _that.fieldUid,
            _that.fieldName,
            _that.issueType,
            _that.message);
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
            String? repeatGroupUid,
            String? rowUid,
            String? parent,
            String? fieldPath,
            String fieldUid,
            String fieldName,
            IssueType issueType,
            String message)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldWithIssue() when $default != null:
        return $default(
            _that.repeatGroupUid,
            _that.rowUid,
            _that.parent,
            _that.fieldPath,
            _that.fieldUid,
            _that.fieldName,
            _that.issueType,
            _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FieldWithIssue implements FieldWithIssue {
  const _FieldWithIssue(
      {this.repeatGroupUid,
      this.rowUid,
      this.parent,
      this.fieldPath,
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
  final String? fieldPath;
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

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldWithIssueCopyWith<_FieldWithIssue> get copyWith =>
      __$FieldWithIssueCopyWithImpl<_FieldWithIssue>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldWithIssue &&
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

  @override
  String toString() {
    return 'FieldWithIssue(repeatGroupUid: $repeatGroupUid, rowUid: $rowUid, parent: $parent, fieldPath: $fieldPath, fieldUid: $fieldUid, fieldName: $fieldName, issueType: $issueType, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$FieldWithIssueCopyWith<$Res>
    implements $FieldWithIssueCopyWith<$Res> {
  factory _$FieldWithIssueCopyWith(
          _FieldWithIssue value, $Res Function(_FieldWithIssue) _then) =
      __$FieldWithIssueCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? repeatGroupUid,
      String? rowUid,
      String? parent,
      String? fieldPath,
      String fieldUid,
      String fieldName,
      IssueType issueType,
      String message});
}

/// @nodoc
class __$FieldWithIssueCopyWithImpl<$Res>
    implements _$FieldWithIssueCopyWith<$Res> {
  __$FieldWithIssueCopyWithImpl(this._self, this._then);

  final _FieldWithIssue _self;
  final $Res Function(_FieldWithIssue) _then;

  /// Create a copy of FieldWithIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? repeatGroupUid = freezed,
    Object? rowUid = freezed,
    Object? parent = freezed,
    Object? fieldPath = freezed,
    Object? fieldUid = null,
    Object? fieldName = null,
    Object? issueType = null,
    Object? message = null,
  }) {
    return _then(_FieldWithIssue(
      repeatGroupUid: freezed == repeatGroupUid
          ? _self.repeatGroupUid
          : repeatGroupUid // ignore: cast_nullable_to_non_nullable
              as String?,
      rowUid: freezed == rowUid
          ? _self.rowUid
          : rowUid // ignore: cast_nullable_to_non_nullable
              as String?,
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldPath: freezed == fieldPath
          ? _self.fieldPath
          : fieldPath // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldUid: null == fieldUid
          ? _self.fieldUid
          : fieldUid // ignore: cast_nullable_to_non_nullable
              as String,
      fieldName: null == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      issueType: null == issueType
          ? _self.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as IssueType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
