import 'package:d_sdk/core/form/section_rendering_type.dart';
import 'package:d_sdk/core/form/value_type_rendering_type.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/core/form/model/Ui_render_type.dart';
import 'package:datarunmobile/core/form/model/ui_event_type.dart';
import 'package:datarunmobile/core/form/ui/event/list_view_ui_events.data.dart';
import 'package:datarunmobile/core/form/ui/event/ui_event_factory.dart';
import 'package:datarunmobile/core/form/ui/intent/form_intent_sealed.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef IntentCallback = void Function(FormIntent intent);
typedef ListViewUiEventsCallback = void Function(ListViewUiEvents uiEvent);

abstract class FieldUiModel with EquatableMixin {
  FieldUiModel(
      {required this.uid,
      required this.path,
      required this.label,
      required this.focused,
      this.error,
      required this.editable,
      this.warning,
      this.programStageSection,
      this.description,
      this.uiEventFactory,
      this.renderingType,
      this.sectionRenderingType,
      this.fieldRendering,
      this.keyboardActionType,
      this.isLoadingData = false,
      this.intentCallback,
      this.listViewUiEventsCallback});

  final String uid;
  final String path;
  final String label;

  ValueType? get valueType => ValueType.Section;

  final bool focused;
  final String? error;
  final bool editable;
  final String? warning;

  final String? programStageSection;

  // final String? hint;
  final String? description;

  final UiEventFactory? uiEventFactory;

  final UiRenderType? renderingType;

  /// NMC added provided here instead to providing it
  /// to the FieldViewModelFactoryImpl
  /// from ProgramSection of the item
  final SectionRenderingType? sectionRenderingType;

  /// NMC added provided here instead to providing it
  /// to the FieldViewModelFactoryImpl
  /// from ProgramStageDataElement of the item
  final ValueTypeRenderingType? fieldRendering;

  final TextInputAction? keyboardActionType;

  final bool isLoadingData;
  final IntentCallback? intentCallback;
  final ListViewUiEventsCallback? listViewUiEventsCallback;

  String? get repeatGroup => null;

  String? get rowUid => null;

  // Template? get template;

  String? get value => null;

  String? get optionSet => null;

  bool get mandatory => false;

  String get formattedLabel => label;

  // String? get displayValue;

  // String? get hint;

  // OptionSetConfiguration? get optionSetConfiguration;
  //
  // bool get hasImage;

  // bool get isAffirmativeChecked;
  //
  // bool get isNegativeChecked;

  FieldUiModel setCallback(
      {IntentCallback? intentCallback,
      ListViewUiEventsCallback? listViewUiEventsCallback});

  void onItemClick();

  void onNext();

  // void onTextChange(String? value);

  void onDescriptionClick();

  void onClear();

  void onSave(String? value) {}

  void onSaveBoolean(bool boolean) {}

  void onSaveOption(FormOption option) {}

  void invokeUiEvent(UiEventType uiEventType);

  void invokeIntent(FormIntent intent);

  FieldUiModel setValue(String? value) => this;

  FieldUiModel setIsLoadingData(bool isLoadingData);

  FieldUiModel setFocus();

  FieldUiModel setError(String? error);

  FieldUiModel setEditable(bool editable);

  FieldUiModel setWarning(String warning);

  FieldUiModel setFieldMandatory() => this;

  FieldUiModel setDisplayValue(String? displayValue) => this;

  FieldUiModel setKeyBoardActionDone();

  bool isSection() => valueType?.isSection == true;

  bool isRepeat() => valueType?.isRepeatSection == true;

  bool isSectionWithFields();

  @override
  List<Object?> get props => [
        uid,
        path,
        repeatGroup,
        rowUid,
        programStageSection,
        description,
        // value,
        valueType,
        focused,
        // mandatory,
        error,
        editable,
        warning,
        label,
        formattedLabel,
        keyboardActionType,
        // displayValue,
        // hasImage,
        // optionSetConfiguration,
        // isAffirmativeChecked,
        // isNegativeChecked,
        isLoadingData,
        sectionRenderingType,
        fieldRendering,
        renderingType,
        intentCallback,
        listViewUiEventsCallback,
      ];
}
