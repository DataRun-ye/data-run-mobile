part of 'field_ui_model.dart';

@immutable
class RepeatableSectionUiModel extends FieldUiModel {
  RepeatableSectionUiModel({
    required this.uid,
    this.parentSection,
    required this.label,
    this.focused = false,
    this.error,
    this.editable = true,
    this.warning,
    this.description,
    this.uiEventFactory,
    this.displayName,
    this.renderingType,
    this.keyboardActionType,
    this.isOpen = false,
    this.totalFields = 0,
    this.completedFields = 0,
    this.errors = 0,
    this.warnings = 0,
    this.rendering,
    this.selectedField,
    this.isLoadingData = false,
    required this.maxLimit,
    required this.currentInstanceCount,
    this.fieldRendering,
    this.sectionRenderingType,
    this.sectionNumber = 0,
    this.showBottomShadow = false,
    this.intentCallback,
    this.listViewUiEventsCallback,
  });

  final String uid;
  final String? parentSection;
  final String label;
  final String? description;
  final bool focused;
  final String? error;
  final bool editable;
  final String? warning;
  final UiEventFactory? uiEventFactory;
  final String? displayName;
  final UiRenderType? renderingType;
  final TextInputAction? keyboardActionType;
  final bool isOpen;
  final int totalFields;
  final int completedFields;
  final int errors;
  final int warnings;
  final String? rendering;
  final String? selectedField;
  final bool isLoadingData;
  final int maxLimit;
  final int currentInstanceCount;
  final int sectionNumber;
  final bool showBottomShadow;
  final ValueTypeRenderingType? fieldRendering;
  final SectionRenderingType? sectionRenderingType;

  final IntentCallback? intentCallback;
  final ListViewUiEventsCallback? listViewUiEventsCallback;

  ValueType get valueType => ValueType.RepeatableSection;

  bool canAddInstance() => currentInstanceCount < maxLimit;

  bool hasToShowDescriptionIcon(bool isTitleEllipsed) {
    return description != null && description?.isNotEmpty == true ||
        isTitleEllipsed;
  }

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
      // selectedField = sectionToOpen;
      intentCallback?.call(FormIntent.onSection(sectionToOpen));
      return copyWith(selectedField: sectionToOpen);
    }

    return this;
  }

  bool get isSelected => selectedField == uid;

  FieldUiModel setSectionNumber(int sectionNumber) {
    // this.sectionNumber = sectionNumber;
    return copyWith(sectionNumber: sectionNumber);
  }

  int getSectionNumber() {
    return sectionNumber;
  }

  FieldUiModel setShowBottomShadow(bool showBottomShadow) {
    return copyWith(showBottomShadow: showBottomShadow);
  }

  bool get isClosingSection => uid == CLOSING_SECTION_UID;

  // bool showNextButton() {
  //   return showBottomShadow && !isClosingSection;
  // }

  // FieldUiModel setLastSectionHeight(bool lastPositionShouldChangeHeight) {
  //   // this.lastPositionShouldChangeHeight = lastPositionShouldChangeHeight;
  //   return copyWith(
  //       lastPositionShouldChangeHeight: lastPositionShouldChangeHeight);
  // }

  // bool lastPositionShouldChangeHeight() {
  //   return lastPositionShouldChangeHeight;
  // }

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

  RepeatableSectionUiModel copyWith({
    String? uid,
    String? parentSection,
    String? path,
    String? label,
    String? description,
    bool? focused,
    String? error,
    bool? editable,
    String? warning,
    UiEventFactory? uiEventFactory,
    String? displayName,
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
    int? maxLimit,
    int? currentInstanceCount,
    ValueTypeRenderingType? fieldRendering,
    SectionRenderingType? sectionRenderingType,
    int? sectionNumber,
    bool? showBottomShadow,
    IntentCallback? intentCallback,
    ListViewUiEventsCallback? listViewUiEventsCallback,
  }) {
    return RepeatableSectionUiModel(
      uid: uid ?? this.uid,
      parentSection: parentSection ?? this.parentSection,
      label: label ?? this.label,
      description: description ?? this.description,
      focused: focused ?? this.focused,
      error: error ?? this.error,
      editable: editable ?? this.editable,
      warning: warning ?? this.warning,
      uiEventFactory: uiEventFactory ?? this.uiEventFactory,
      displayName: displayName ?? this.displayName,
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
      maxLimit: maxLimit ?? this.maxLimit,
      currentInstanceCount: currentInstanceCount ?? this.currentInstanceCount,
      fieldRendering: fieldRendering ?? this.fieldRendering,
      sectionRenderingType: sectionRenderingType ?? this.sectionRenderingType,
      sectionNumber: sectionNumber ?? this.sectionNumber,
      showBottomShadow: showBottomShadow ?? this.showBottomShadow,
      intentCallback: intentCallback ?? this.intentCallback,
      listViewUiEventsCallback:
          listViewUiEventsCallback ?? this.listViewUiEventsCallback,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        isOpen,
        totalFields,
        completedFields,
        errors,
        warnings,
        selectedField,
        maxLimit,
        currentInstanceCount,
        sectionNumber,
        showBottomShadow
      ];
}
