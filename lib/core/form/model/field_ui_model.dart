import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/section_rendering_type.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type_rendering_type.dart';
import 'package:datarun/core/form/model/Ui_render_type.dart';
import 'package:datarun/core/form/model/ui_event_type.dart';
import 'package:datarun/core/form/ui/event/list_view_ui_events.dart';
import 'package:datarun/core/form/ui/event/ui_event_factory.dart';
import 'package:datarun/core/form/ui/intent/form_intent_sealed.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef IntentCallback = void Function(FormIntent intent);
typedef ListViewUiEventsCallback = void Function(ListViewUiEvents uiEvent);

abstract class FieldUiModel with EquatableMixin {
  IntentCallback? get intentCallback;

  ListViewUiEventsCallback? get listViewUiEventsCallback;

  String get uid;

  String? get repeatGroup => null;

  String? get rowUid => null;

  String get path;

  // Template? get template;

  String? get value => null;

  ValueType? get valueType;

  String? get optionSet => null;

  bool get focused;

  bool get mandatory => false;

  String? get programStageSection;

  String? get error;

  bool get editable;

  String? get warning;

  String get formattedLabel => label;

  String get label;

  // String? get displayValue;

  // String? get hint;

  String? get description;

  UiEventFactory? get uiEventFactory;

  // OptionSetConfiguration? get optionSetConfiguration;
  //
  // bool get hasImage;

  TextInputAction? get keyboardActionType;

  // bool get isAffirmativeChecked;
  //
  // bool get isNegativeChecked;

  bool get isLoadingData;

  /// NMC added provided here instead to providing it
  /// to the FieldViewModelFactoryImpl
  /// from ProgramSection of the item
  SectionRenderingType? get sectionRenderingType;

  /// NMC added provided here instead to providing it
  /// to the FieldViewModelFactoryImpl
  /// from ProgramStageDataElement of the item
  ValueTypeRenderingType? get fieldRendering;

  UiRenderType? get renderingType;

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
