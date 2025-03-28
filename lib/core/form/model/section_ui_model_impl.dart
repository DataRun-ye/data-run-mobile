import 'package:datarunmobile/core/form/model/Ui_render_type.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/option_set_configuration.data.dart';
import 'package:datarunmobile/core/form/model/ui_event_type.dart';
import 'package:datarunmobile/core/form/ui/event/list_view_ui_events.data.dart';
import 'package:datarunmobile/core/form/ui/event/ui_event_factory.dart';
import 'package:datarunmobile/core/form/ui/intent/form_intent_sealed.dart';
import 'package:flutter/material.dart';

const String SINGLE_SECTION_UID = 'SINGLE_SECTION_UID';
const String CLOSING_SECTION_UID = 'closing_section';

@immutable
class SectionUiModelImpl extends FieldUiModel {
  SectionUiModelImpl({
    required super.uid,
    required super.path,
    required super.label,
    required super.focused,
    required super.editable,
    super.error,
    super.warning,
    super.programStageSection,
    super.description,
    super.uiEventFactory,
    super.renderingType,
    super.keyboardActionType,
    super.sectionRenderingType,
    super.fieldRendering,
    super.isLoadingData = false,
    super.intentCallback,
    super.listViewUiEventsCallback,
    // super.style,
    // super.hint,
    this.isOpen = false,
    this.totalFields = 0,
    this.completedFields = 0,
    this.errors = 0,
    this.warnings = 0,
    this.rendering,

    /// NMCP can't define a default value
    /// here we have to provide initial value Rx<String?>(null)
    /// whenever we create an object of SectionUiModelImpl
    //   /*@Default(Rx<String?>(null))*/ required Rx<String?> selectedField,
    /*@Default(Rx<String?>(null))*/ this.selectedField,
    this.optionSetConfiguration,
    this.sectionNumber = 0,
    this.showBottomShadow = false,
    this.lastPositionShouldChangeHeight = false,
  });

  final bool isOpen;
  final int totalFields;
  final int completedFields;
  final int errors;
  final int warnings;
  final String? rendering;

  final String? selectedField;
  final OptionSetConfiguration? optionSetConfiguration;
  final int sectionNumber;
  final bool showBottomShadow;
  final bool lastPositionShouldChangeHeight;

  bool hasToShowDescriptionIcon(bool isTitleEllipsed) {
    return description != null && description?.isNotEmpty == true ||
        isTitleEllipsed;
  }

  bool get isClosingSection => uid == CLOSING_SECTION_UID;

  bool get hasErrorAndWarnings => errors > 0 && warnings > 0;

  bool get hasNotAnyErrorOrWarning => errors == 0 && warnings == 0;

  bool get hasOnlyErrors => errors > 0 && warnings == 0;

  String get getFormattedSectionFieldsInfo => '$completedFields/$totalFields';

  bool get areAllFieldsCompleted => completedFields == totalFields;

  FieldUiModel setSelected() {
    onItemClick();
    if (selectedField != null) {
      String sectionToOpen = uid;
      if (selectedField == uid) {
        sectionToOpen = '';
      }
      intentCallback?.call(FormIntent.onSection(sectionToOpen));
      return copyWith(selectedField: sectionToOpen);
    }

    return this;
  }

  bool get isSelected => selectedField == uid;

  FieldUiModel setSectionNumber(int sectionNumber) {
    return copyWith(sectionNumber: sectionNumber);
  }

  int getSectionNumber() {
    return sectionNumber;
  }

  FieldUiModel setShowBottomShadow(bool showBottomShadow) {
    return copyWith(showBottomShadow: showBottomShadow);
  }

  bool showNextButton() {
    return showBottomShadow && !isClosingSection;
  }

  FieldUiModel setLastSectionHeight(bool lastPositionShouldChangeHeight) {
    return copyWith(
        lastPositionShouldChangeHeight: lastPositionShouldChangeHeight);
  }

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
    intentCallback?.call(FormIntent.onFocus(uid, null));
  }

  @override
  void onNext() {}

  @override
  void onDescriptionClick() {
    listViewUiEventsCallback
        ?.call(ListViewUiEvents.showDescriptionLabelDialog(label, description));
  }

  @override
  void onClear() {}

  @override
  void invokeUiEvent(UiEventType uiEventType) {
    onItemClick();
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
  FieldUiModel setKeyBoardActionDone() =>
      copyWith(keyboardActionType: TextInputAction.done);

  @override
  bool isSectionWithFields() => totalFields > 0;

  SectionUiModelImpl copyWith({
    String? uid,
    String? path,
    String? label,
    bool? focused,
    String? error,
    bool? editable,
    String? warning,
    String? programStageSection,
    UiEventFactory? uiEventFactory,
    UiRenderType? renderingType,
    TextInputAction? keyboardActionType,
    bool? isOpen,
    int? totalFields,
    int? completedFields,
    int? errors,
    int? warnings,
    String? rendering,
    String? selectedField,
    bool? isLoadingData,
    OptionSetConfiguration? optionSetConfiguration,
    int? sectionNumber,
    bool? showBottomShadow,
    bool? lastPositionShouldChangeHeight,
    IntentCallback? intentCallback,
    ListViewUiEventsCallback? listViewUiEventsCallback,
  }) {
    return SectionUiModelImpl(
      uid: uid ?? this.uid,
      path: path ?? this.path,
      label: label ?? this.label,
      focused: focused ?? this.focused,
      error: error ?? this.error,
      editable: editable ?? this.editable,
      warning: warning ?? this.warning,
      programStageSection: programStageSection ?? this.programStageSection,
      // style: style ?? this.style,
      // hint: hint ?? this.hint,
      description: description ?? this.description,

      uiEventFactory: uiEventFactory ?? this.uiEventFactory,
      renderingType: renderingType ?? this.renderingType,
      keyboardActionType: keyboardActionType ?? this.keyboardActionType,
      isOpen: isOpen ?? this.isOpen,
      totalFields: totalFields ?? this.totalFields,
      completedFields: completedFields ?? this.completedFields,
      errors: errors ?? this.errors,
      warnings: warnings ?? this.warnings,
      rendering: rendering ?? this.rendering,
      selectedField: selectedField ?? this.selectedField,
      isLoadingData: isLoadingData ?? this.isLoadingData,
      optionSetConfiguration:
          optionSetConfiguration ?? this.optionSetConfiguration,
      sectionNumber: sectionNumber ?? this.sectionNumber,
      showBottomShadow: showBottomShadow ?? this.showBottomShadow,
      lastPositionShouldChangeHeight:
          lastPositionShouldChangeHeight ?? this.lastPositionShouldChangeHeight,
      intentCallback: intentCallback ?? this.intentCallback,
      listViewUiEventsCallback:
          listViewUiEventsCallback ?? this.listViewUiEventsCallback,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        showBottomShadow,
        lastPositionShouldChangeHeight,
        isOpen,
        totalFields,
        completedFields,
        errors,
        warnings,
        sectionNumber,
        selectedField
      ];
}
