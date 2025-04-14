import 'dart:io';

import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/option_set_configuration.data.dart';
import 'package:datarunmobile/core/form/model/ui_event_type.dart';
import 'package:datarunmobile/core/form/ui/event/list_view_ui_events.data.dart';
import 'package:datarunmobile/core/form/ui/event/ui_event_factory.dart';
import 'package:datarunmobile/core/form/ui/intent/form_intent_sealed.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

@immutable
class FieldUiModelImpl extends FieldUiModel {
  FieldUiModelImpl({
    required super.uid,
    required super.path,
    required super.label,
    required super.focused,
    required super.editable,
    super.description,
    super.error,
    super.warning,
    super.programStageSection,
    super.uiEventFactory,
    super.renderingType,
    super.sectionRenderingType,
    super.fieldRendering,
    super.keyboardActionType,
    super.isLoadingData = false,
    super.intentCallback,
    super.listViewUiEventsCallback,
    this.repeatGroup,
    this.rowUid,
    this.value,
    required this.valueType,
    this.optionSet,
    required this.mandatory,
    this.optionSetConfiguration,
    String? displayValue,
  }) : this.displayValue = displayValue ?? value;

  final String? displayValue;
  final OptionSetConfiguration? optionSetConfiguration;

  @override
  final String? repeatGroup;

  @override
  final String? rowUid;

  @override
  final String? value;

  @override
  final ValueType valueType;

  @override
  final String? optionSet;

  @override
  final bool mandatory;

  @override
  void onSave(String? value) {
    onItemClick();
    intentCallback?.call(FormIntent.onSave(uid, value, valueType));
  }

  @override
  void onSaveBoolean(bool boolean) {
    onItemClick();
    final result = value == null || value != boolean.toString()
        ? boolean.toString()
        : null;
    intentCallback?.call(FormIntent.onSave(uid, result, valueType));
  }

  @override
  void onSaveOption(FormOption option) {
    String? nextValue;
    if (option.label.lock.any((k, v) => v == displayValue)) {
      nextValue = null;
    } else {
      nextValue = option.name;
    }
    intentCallback?.call(FormIntent.onSave(uid, nextValue, valueType));
  }

  bool get hasImage {
    return value != null && File(value ?? '').existsSync();
  }

  bool get isAffirmativeChecked => value.toBoolean() == true;

  bool get isNegativeChecked => value.toBoolean() == false;

  void onTextChange(String? value) {
    intentCallback?.call(FormIntent.onTextChange(
        uid, (value ?? '').isEmpty == true ? null : value));
  }

  @override
  FieldUiModel setValue(String? value) => copyWith(value: value);

  @override
  String get formattedLabel => mandatory ? '$label *' : label;

  @override
  FieldUiModel setCallback(
      {IntentCallback? intentCallback,
      ListViewUiEventsCallback? listViewUiEventsCallback}) {
    return copyWith(
        intentCallback: intentCallback,
        listViewUiEventsCallback: listViewUiEventsCallback);
  }

  @override
  void onItemClick() {
    intentCallback?.call(FormIntent.onFocus(uid, value));
  }

  @override
  void onNext() {
    intentCallback?.call(FormIntent.onNext(uid, value));
  }

  @override
  void onDescriptionClick() {
    listViewUiEventsCallback
        ?.call(ListViewUiEvents.showDescriptionLabelDialog(label, description));
  }

  @override
  void onClear() {
    onItemClick();
    intentCallback?.call(FormIntent.clearValue(uid));
  }

  @override
  void invokeUiEvent(UiEventType uiEventType) {
    if (uiEventType != UiEventType.QR_CODE && !focused) {
      onItemClick();
    }

    final ListViewUiEvents? listViewUiEvents =
        uiEventFactory?.generateEvent(value, uiEventType, renderingType, this);

    if (listViewUiEvents != null) {
      listViewUiEventsCallback?.call(listViewUiEvents);
    }
  }

  @override
  void invokeIntent(FormIntent intent) {
    intentCallback?.call(intent);
  }

  @override
  FieldUiModel setIsLoadingData(bool isLoadingData) =>
      copyWith(isLoadingData: isLoadingData);

  @override
  FieldUiModel setFocus() => copyWith(focused: true);

  @override
  FieldUiModel setError(String? error) => copyWith(error: error);

  @override
  FieldUiModel setEditable(bool editable) => copyWith(editable: editable);

  @override
  FieldUiModel setWarning(String warning) => copyWith(warning: warning);

  @override
  FieldUiModel setFieldMandatory() => copyWith(mandatory: true);

  @override
  FieldUiModel setDisplayValue(String? displayName) =>
      copyWith(displayValue: displayName);

  @override
  FieldUiModel setKeyBoardActionDone() =>
      copyWith(keyboardActionType: TextInputAction.done);

  @override
  bool isSectionWithFields() => false;

  FieldUiModel copyWith({
    String? uid,
    String? path,
    String? repeatGroup,
    String? rowUid,
    String? programStageSection,
    String? label,
    String? description,
    String? value,
    ValueType? valueType,
    String? optionSet,
    bool? focused,
    String? error,
    bool? editable,
    String? warning,
    bool? mandatory,
    UiEventFactory? uiEventFactory,
    String? displayValue,
    bool? isLoadingData,
    OptionSetConfiguration? optionSetConfiguration,
    TextInputAction? keyboardActionType,
    IntentCallback? intentCallback,
    ListViewUiEventsCallback? listViewUiEventsCallback,
  }) =>
      FieldUiModelImpl(
        uid: uid ?? this.uid,
        path: path ?? this.path,
        repeatGroup: repeatGroup ?? this.repeatGroup,
        rowUid: rowUid ?? this.rowUid,
        programStageSection: programStageSection ?? this.programStageSection,
        label: label ?? this.label,
        description: description ?? this.description,
        value: value ?? this.value,
        valueType: valueType ?? this.valueType,
        optionSet: optionSet ?? this.optionSet,
        focused: focused ?? this.focused,
        error: error ?? this.error,
        editable: editable ?? this.editable,
        warning: warning ?? this.warning,
        mandatory: mandatory ?? this.mandatory,
        displayValue: displayValue ?? this.displayValue,
        // programStageSection: programStageSection ?? this.programStageSection,
        uiEventFactory: uiEventFactory ?? this.uiEventFactory,
        renderingType: renderingType ?? this.renderingType,
        keyboardActionType: keyboardActionType ?? this.keyboardActionType,
        isLoadingData: isLoadingData ?? this.isLoadingData,
        optionSetConfiguration:
            optionSetConfiguration ?? this.optionSetConfiguration,
        intentCallback: intentCallback ?? this.intentCallback,
        listViewUiEventsCallback:
            listViewUiEventsCallback ?? this.listViewUiEventsCallback,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        value,
        mandatory,
        displayValue,
        optionSet,
        hasImage,
        displayValue,
        hasImage,
        optionSetConfiguration,
        isAffirmativeChecked,
        isNegativeChecked,
      ];
}
