// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_view_ui_events.data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListViewUiEvents implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'ListViewUiEvents'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ListViewUiEvents);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents()';
  }
}

/// @nodoc
class $ListViewUiEventsCopyWith<$Res> {
  $ListViewUiEventsCopyWith(
      ListViewUiEvents _, $Res Function(ListViewUiEvents) __);
}

/// @nodoc

class OpenYearMonthDayAgeCalendar
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const OpenYearMonthDayAgeCalendar(
      {required this.uid,
      required this.year,
      required this.month,
      required this.day});

  final String uid;
  final int year;
  final int month;
  final int day;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OpenYearMonthDayAgeCalendarCopyWith<OpenYearMonthDayAgeCalendar>
      get copyWith => _$OpenYearMonthDayAgeCalendarCopyWithImpl<
          OpenYearMonthDayAgeCalendar>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'ListViewUiEvents.openYearMonthDayAgeCalendar'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('day', day));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OpenYearMonthDayAgeCalendar &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, year, month, day);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.openYearMonthDayAgeCalendar(uid: $uid, year: $year, month: $month, day: $day)';
  }
}

/// @nodoc
abstract mixin class $OpenYearMonthDayAgeCalendarCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $OpenYearMonthDayAgeCalendarCopyWith(
          OpenYearMonthDayAgeCalendar value,
          $Res Function(OpenYearMonthDayAgeCalendar) _then) =
      _$OpenYearMonthDayAgeCalendarCopyWithImpl;
  @useResult
  $Res call({String uid, int year, int month, int day});
}

/// @nodoc
class _$OpenYearMonthDayAgeCalendarCopyWithImpl<$Res>
    implements $OpenYearMonthDayAgeCalendarCopyWith<$Res> {
  _$OpenYearMonthDayAgeCalendarCopyWithImpl(this._self, this._then);

  final OpenYearMonthDayAgeCalendar _self;
  final $Res Function(OpenYearMonthDayAgeCalendar) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? year = null,
    Object? month = null,
    Object? day = null,
  }) {
    return _then(OpenYearMonthDayAgeCalendar(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class OpenCustomCalendar
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const OpenCustomCalendar(
      {required this.uid,
      required this.label,
      this.date,
      required this.allowFutureDates,
      this.isDateTime = false});

  final String uid;
  final String label;
  final DateTime? date;
  final bool allowFutureDates;
  @JsonKey()
  final bool? isDateTime;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OpenCustomCalendarCopyWith<OpenCustomCalendar> get copyWith =>
      _$OpenCustomCalendarCopyWithImpl<OpenCustomCalendar>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.openCustomCalendar'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('allowFutureDates', allowFutureDates))
      ..add(DiagnosticsProperty('isDateTime', isDateTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OpenCustomCalendar &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.allowFutureDates, allowFutureDates) ||
                other.allowFutureDates == allowFutureDates) &&
            (identical(other.isDateTime, isDateTime) ||
                other.isDateTime == isDateTime));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, label, date, allowFutureDates, isDateTime);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.openCustomCalendar(uid: $uid, label: $label, date: $date, allowFutureDates: $allowFutureDates, isDateTime: $isDateTime)';
  }
}

/// @nodoc
abstract mixin class $OpenCustomCalendarCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $OpenCustomCalendarCopyWith(
          OpenCustomCalendar value, $Res Function(OpenCustomCalendar) _then) =
      _$OpenCustomCalendarCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String label,
      DateTime? date,
      bool allowFutureDates,
      bool? isDateTime});
}

/// @nodoc
class _$OpenCustomCalendarCopyWithImpl<$Res>
    implements $OpenCustomCalendarCopyWith<$Res> {
  _$OpenCustomCalendarCopyWithImpl(this._self, this._then);

  final OpenCustomCalendar _self;
  final $Res Function(OpenCustomCalendar) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? label = null,
    Object? date = freezed,
    Object? allowFutureDates = null,
    Object? isDateTime = freezed,
  }) {
    return _then(OpenCustomCalendar(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      allowFutureDates: null == allowFutureDates
          ? _self.allowFutureDates
          : allowFutureDates // ignore: cast_nullable_to_non_nullable
              as bool,
      isDateTime: freezed == isDateTime
          ? _self.isDateTime
          : isDateTime // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class OpenTimePicker with DiagnosticableTreeMixin implements ListViewUiEvents {
  const OpenTimePicker(
      {required this.uid,
      required this.label,
      this.date,
      this.isDateTime = false});

  final String uid;
  final String label;
  final DateTime? date;
  @JsonKey()
  final bool? isDateTime;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OpenTimePickerCopyWith<OpenTimePicker> get copyWith =>
      _$OpenTimePickerCopyWithImpl<OpenTimePicker>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.openTimePicker'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('isDateTime', isDateTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OpenTimePicker &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isDateTime, isDateTime) ||
                other.isDateTime == isDateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, label, date, isDateTime);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.openTimePicker(uid: $uid, label: $label, date: $date, isDateTime: $isDateTime)';
  }
}

/// @nodoc
abstract mixin class $OpenTimePickerCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $OpenTimePickerCopyWith(
          OpenTimePicker value, $Res Function(OpenTimePicker) _then) =
      _$OpenTimePickerCopyWithImpl;
  @useResult
  $Res call({String uid, String label, DateTime? date, bool? isDateTime});
}

/// @nodoc
class _$OpenTimePickerCopyWithImpl<$Res>
    implements $OpenTimePickerCopyWith<$Res> {
  _$OpenTimePickerCopyWithImpl(this._self, this._then);

  final OpenTimePicker _self;
  final $Res Function(OpenTimePicker) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? label = null,
    Object? date = freezed,
    Object? isDateTime = freezed,
  }) {
    return _then(OpenTimePicker(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDateTime: freezed == isDateTime
          ? _self.isDateTime
          : isDateTime // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class ShowDescriptionLabelDialog
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const ShowDescriptionLabelDialog(this.title, this.message);

  final String title;
  final String? message;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShowDescriptionLabelDialogCopyWith<ShowDescriptionLabelDialog>
      get copyWith =>
          _$ShowDescriptionLabelDialogCopyWithImpl<ShowDescriptionLabelDialog>(
              this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'ListViewUiEvents.showDescriptionLabelDialog'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShowDescriptionLabelDialog &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.showDescriptionLabelDialog(title: $title, message: $message)';
  }
}

/// @nodoc
abstract mixin class $ShowDescriptionLabelDialogCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $ShowDescriptionLabelDialogCopyWith(ShowDescriptionLabelDialog value,
          $Res Function(ShowDescriptionLabelDialog) _then) =
      _$ShowDescriptionLabelDialogCopyWithImpl;
  @useResult
  $Res call({String title, String? message});
}

/// @nodoc
class _$ShowDescriptionLabelDialogCopyWithImpl<$Res>
    implements $ShowDescriptionLabelDialogCopyWith<$Res> {
  _$ShowDescriptionLabelDialogCopyWithImpl(this._self, this._then);

  final ShowDescriptionLabelDialog _self;
  final $Res Function(ShowDescriptionLabelDialog) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? message = freezed,
  }) {
    return _then(ShowDescriptionLabelDialog(
      null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class RequestCurrentLocation
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const RequestCurrentLocation({required this.uid});

  final String uid;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestCurrentLocationCopyWith<RequestCurrentLocation> get copyWith =>
      _$RequestCurrentLocationCopyWithImpl<RequestCurrentLocation>(
          this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty(
          'type', 'ListViewUiEvents.requestCurrentLocation'))
      ..add(DiagnosticsProperty('uid', uid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestCurrentLocation &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.requestCurrentLocation(uid: $uid)';
  }
}

/// @nodoc
abstract mixin class $RequestCurrentLocationCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $RequestCurrentLocationCopyWith(RequestCurrentLocation value,
          $Res Function(RequestCurrentLocation) _then) =
      _$RequestCurrentLocationCopyWithImpl;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class _$RequestCurrentLocationCopyWithImpl<$Res>
    implements $RequestCurrentLocationCopyWith<$Res> {
  _$RequestCurrentLocationCopyWithImpl(this._self, this._then);

  final RequestCurrentLocation _self;
  final $Res Function(RequestCurrentLocation) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
  }) {
    return _then(RequestCurrentLocation(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class RequestLocationByMap
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const RequestLocationByMap({required this.uid, this.value});

  final String uid;
// required FeatureType featureType,
  final String? value;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestLocationByMapCopyWith<RequestLocationByMap> get copyWith =>
      _$RequestLocationByMapCopyWithImpl<RequestLocationByMap>(
          this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(
          DiagnosticsProperty('type', 'ListViewUiEvents.requestLocationByMap'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestLocationByMap &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.requestLocationByMap(uid: $uid, value: $value)';
  }
}

/// @nodoc
abstract mixin class $RequestLocationByMapCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $RequestLocationByMapCopyWith(RequestLocationByMap value,
          $Res Function(RequestLocationByMap) _then) =
      _$RequestLocationByMapCopyWithImpl;
  @useResult
  $Res call({String uid, String? value});
}

/// @nodoc
class _$RequestLocationByMapCopyWithImpl<$Res>
    implements $RequestLocationByMapCopyWith<$Res> {
  _$RequestLocationByMapCopyWithImpl(this._self, this._then);

  final RequestLocationByMap _self;
  final $Res Function(RequestLocationByMap) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? value = freezed,
  }) {
    return _then(RequestLocationByMap(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class ScanQRCode with DiagnosticableTreeMixin implements ListViewUiEvents {
  const ScanQRCode({required this.uid, this.optionSet, this.renderingType});

  final String uid;
  final String? optionSet;
  final UiRenderType? renderingType;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScanQRCodeCopyWith<ScanQRCode> get copyWith =>
      _$ScanQRCodeCopyWithImpl<ScanQRCode>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.scanQRCode'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('optionSet', optionSet))
      ..add(DiagnosticsProperty('renderingType', renderingType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScanQRCode &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.optionSet, optionSet) ||
                other.optionSet == optionSet) &&
            (identical(other.renderingType, renderingType) ||
                other.renderingType == renderingType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, optionSet, renderingType);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.scanQRCode(uid: $uid, optionSet: $optionSet, renderingType: $renderingType)';
  }
}

/// @nodoc
abstract mixin class $ScanQRCodeCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $ScanQRCodeCopyWith(
          ScanQRCode value, $Res Function(ScanQRCode) _then) =
      _$ScanQRCodeCopyWithImpl;
  @useResult
  $Res call({String uid, String? optionSet, UiRenderType? renderingType});
}

/// @nodoc
class _$ScanQRCodeCopyWithImpl<$Res> implements $ScanQRCodeCopyWith<$Res> {
  _$ScanQRCodeCopyWithImpl(this._self, this._then);

  final ScanQRCode _self;
  final $Res Function(ScanQRCode) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? optionSet = freezed,
    Object? renderingType = freezed,
  }) {
    return _then(ScanQRCode(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      optionSet: freezed == optionSet
          ? _self.optionSet
          : optionSet // ignore: cast_nullable_to_non_nullable
              as String?,
      renderingType: freezed == renderingType
          ? _self.renderingType
          : renderingType // ignore: cast_nullable_to_non_nullable
              as UiRenderType?,
    ));
  }
}

/// @nodoc

class DisplayQRCode with DiagnosticableTreeMixin implements ListViewUiEvents {
  const DisplayQRCode(
      {required this.uid,
      this.optionSet,
      required this.value,
      this.renderingType,
      required this.editable});

  final String uid;
  final String? optionSet;
  final String value;
  final UiRenderType? renderingType;
  final bool editable;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DisplayQRCodeCopyWith<DisplayQRCode> get copyWith =>
      _$DisplayQRCodeCopyWithImpl<DisplayQRCode>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.displayQRCode'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('optionSet', optionSet))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('renderingType', renderingType))
      ..add(DiagnosticsProperty('editable', editable));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisplayQRCode &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.optionSet, optionSet) ||
                other.optionSet == optionSet) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.renderingType, renderingType) ||
                other.renderingType == renderingType) &&
            (identical(other.editable, editable) ||
                other.editable == editable));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, optionSet, value, renderingType, editable);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.displayQRCode(uid: $uid, optionSet: $optionSet, value: $value, renderingType: $renderingType, editable: $editable)';
  }
}

/// @nodoc
abstract mixin class $DisplayQRCodeCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $DisplayQRCodeCopyWith(
          DisplayQRCode value, $Res Function(DisplayQRCode) _then) =
      _$DisplayQRCodeCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String? optionSet,
      String value,
      UiRenderType? renderingType,
      bool editable});
}

/// @nodoc
class _$DisplayQRCodeCopyWithImpl<$Res>
    implements $DisplayQRCodeCopyWith<$Res> {
  _$DisplayQRCodeCopyWithImpl(this._self, this._then);

  final DisplayQRCode _self;
  final $Res Function(DisplayQRCode) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? optionSet = freezed,
    Object? value = null,
    Object? renderingType = freezed,
    Object? editable = null,
  }) {
    return _then(DisplayQRCode(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      optionSet: freezed == optionSet
          ? _self.optionSet
          : optionSet // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      renderingType: freezed == renderingType
          ? _self.renderingType
          : renderingType // ignore: cast_nullable_to_non_nullable
              as UiRenderType?,
      editable: null == editable
          ? _self.editable
          : editable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class OpenOrgUnitDialog
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const OpenOrgUnitDialog({required this.uid, required this.label, this.value});

  final String uid;
  final String label;
  final String? value;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OpenOrgUnitDialogCopyWith<OpenOrgUnitDialog> get copyWith =>
      _$OpenOrgUnitDialogCopyWithImpl<OpenOrgUnitDialog>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.openOrgUnitDialog'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OpenOrgUnitDialog &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, label, value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.openOrgUnitDialog(uid: $uid, label: $label, value: $value)';
  }
}

/// @nodoc
abstract mixin class $OpenOrgUnitDialogCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $OpenOrgUnitDialogCopyWith(
          OpenOrgUnitDialog value, $Res Function(OpenOrgUnitDialog) _then) =
      _$OpenOrgUnitDialogCopyWithImpl;
  @useResult
  $Res call({String uid, String label, String? value});
}

/// @nodoc
class _$OpenOrgUnitDialogCopyWithImpl<$Res>
    implements $OpenOrgUnitDialogCopyWith<$Res> {
  _$OpenOrgUnitDialogCopyWithImpl(this._self, this._then);

  final OpenOrgUnitDialog _self;
  final $Res Function(OpenOrgUnitDialog) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? label = null,
    Object? value = freezed,
  }) {
    return _then(OpenOrgUnitDialog(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class AddImage with DiagnosticableTreeMixin implements ListViewUiEvents {
  const AddImage(this.uid);

  final String uid;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddImageCopyWith<AddImage> get copyWith =>
      _$AddImageCopyWithImpl<AddImage>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.addImage'))
      ..add(DiagnosticsProperty('uid', uid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddImage &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.addImage(uid: $uid)';
  }
}

/// @nodoc
abstract mixin class $AddImageCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $AddImageCopyWith(AddImage value, $Res Function(AddImage) _then) =
      _$AddImageCopyWithImpl;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class _$AddImageCopyWithImpl<$Res> implements $AddImageCopyWith<$Res> {
  _$AddImageCopyWithImpl(this._self, this._then);

  final AddImage _self;
  final $Res Function(AddImage) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
  }) {
    return _then(AddImage(
      null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ShowImage with DiagnosticableTreeMixin implements ListViewUiEvents {
  const ShowImage({required this.label, required this.value});

  final String label;
  final String value;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShowImageCopyWith<ShowImage> get copyWith =>
      _$ShowImageCopyWithImpl<ShowImage>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.showImage'))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShowImage &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.showImage(label: $label, value: $value)';
  }
}

/// @nodoc
abstract mixin class $ShowImageCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $ShowImageCopyWith(ShowImage value, $Res Function(ShowImage) _then) =
      _$ShowImageCopyWithImpl;
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class _$ShowImageCopyWithImpl<$Res> implements $ShowImageCopyWith<$Res> {
  _$ShowImageCopyWithImpl(this._self, this._then);

  final ShowImage _self;
  final $Res Function(ShowImage) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(ShowImage(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class CopyToClipboard with DiagnosticableTreeMixin implements ListViewUiEvents {
  const CopyToClipboard({this.value});

  final String? value;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CopyToClipboardCopyWith<CopyToClipboard> get copyWith =>
      _$CopyToClipboardCopyWithImpl<CopyToClipboard>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.copyToClipboard'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CopyToClipboard &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.copyToClipboard(value: $value)';
  }
}

/// @nodoc
abstract mixin class $CopyToClipboardCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $CopyToClipboardCopyWith(
          CopyToClipboard value, $Res Function(CopyToClipboard) _then) =
      _$CopyToClipboardCopyWithImpl;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class _$CopyToClipboardCopyWithImpl<$Res>
    implements $CopyToClipboardCopyWith<$Res> {
  _$CopyToClipboardCopyWithImpl(this._self, this._then);

  final CopyToClipboard _self;
  final $Res Function(CopyToClipboard) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(CopyToClipboard(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class OpenOptionSetDialog
    with DiagnosticableTreeMixin
    implements ListViewUiEvents {
  const OpenOptionSetDialog({required this.field});

  final FieldUiModel field;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OpenOptionSetDialogCopyWith<OpenOptionSetDialog> get copyWith =>
      _$OpenOptionSetDialogCopyWithImpl<OpenOptionSetDialog>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ListViewUiEvents.openOptionSetDialog'))
      ..add(DiagnosticsProperty('field', field));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OpenOptionSetDialog &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListViewUiEvents.openOptionSetDialog(field: $field)';
  }
}

/// @nodoc
abstract mixin class $OpenOptionSetDialogCopyWith<$Res>
    implements $ListViewUiEventsCopyWith<$Res> {
  factory $OpenOptionSetDialogCopyWith(
          OpenOptionSetDialog value, $Res Function(OpenOptionSetDialog) _then) =
      _$OpenOptionSetDialogCopyWithImpl;
  @useResult
  $Res call({FieldUiModel field});
}

/// @nodoc
class _$OpenOptionSetDialogCopyWithImpl<$Res>
    implements $OpenOptionSetDialogCopyWith<$Res> {
  _$OpenOptionSetDialogCopyWithImpl(this._self, this._then);

  final OpenOptionSetDialog _self;
  final $Res Function(OpenOptionSetDialog) _then;

  /// Create a copy of ListViewUiEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
  }) {
    return _then(OpenOptionSetDialog(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as FieldUiModel,
    ));
  }
}

// dart format on
