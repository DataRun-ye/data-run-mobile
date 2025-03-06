import 'package:datarun/core/form/model/Ui_render_type.dart';
import 'package:datarun/core/form/model/field_ui_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_view_ui_events.freezed.dart';

@freezed
class ListViewUiEvents with _$ListViewUiEvents {
  const factory ListViewUiEvents.openYearMonthDayAgeCalendar(
      {required String uid,
      required int year,
      required int month,
      required int day}) = OpenYearMonthDayAgeCalendar;

  const factory ListViewUiEvents.openCustomCalendar(
      {required String uid,
      required String label,
      DateTime? date,
      required bool allowFutureDates,
      @Default(false) bool? isDateTime}) = OpenCustomCalendar;

  const factory ListViewUiEvents.openTimePicker(
      {required String uid,
      required String label,
      DateTime? date,
      @Default(false) bool? isDateTime}) = OpenTimePicker;

  const factory ListViewUiEvents.showDescriptionLabelDialog(
      String title, String? message) = ShowDescriptionLabelDialog;

  const factory ListViewUiEvents.requestCurrentLocation({required String uid}) =
      RequestCurrentLocation;

  const factory ListViewUiEvents.requestLocationByMap(
      {required String uid,
      // required FeatureType featureType,
      String? value}) = RequestLocationByMap;

  const factory ListViewUiEvents.scanQRCode({
    required String uid,
    String? optionSet,
    UiRenderType? renderingType,
  }) = ScanQRCode;

  const factory ListViewUiEvents.displayQRCode(
      {required String uid,
      String? optionSet,
      required String value,
      UiRenderType? renderingType,
      required bool editable}) = DisplayQRCode;

  const factory ListViewUiEvents.openOrgUnitDialog(
      {required String uid,
      required String label,
      String? value}) = OpenOrgUnitDialog;

  const factory ListViewUiEvents.addImage(String uid) = AddImage;

  const factory ListViewUiEvents.showImage(
      {required String label, required String value}) = ShowImage;

  const factory ListViewUiEvents.copyToClipboard({String? value}) =
      CopyToClipboard;

  const factory ListViewUiEvents.openOptionSetDialog(
      {required FieldUiModel field}) = OpenOptionSetDialog;

  const ListViewUiEvents._();
}
