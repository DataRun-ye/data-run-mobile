part of 'field_ui_model.dart';

const String SINGLE_SECTION_UID = 'SINGLE_SECTION_UID';
const String CLOSING_SECTION_UID = 'closing_section';

@immutable
class SectionUiModelImpl extends FieldUiModel {
  SectionUiModelImpl(
      {required this.uid,
      required this.label,
      required this.focused,
      this.error,
      required this.editable,
      this.warning,
      this.parentSection,
      // this.style,
      // this.hint,
      this.description,
      this.uiEventFactory,
      this.renderingType,
      this.keyboardActionType,
      this.isOpen = false,
      this.totalFields = 0,
      this.completedFields = 0,
      this.errors = 0,
      this.warnings = 0,
      this.rendering,
      this.sectionRenderingType,
      this.fieldRendering,

      /// NMCP can't define a default value
      /// here we have to provide initial value Rx<String?>(null)
      /// whenever we create an object of SectionUiModelImpl
      //   /*@Default(Rx<String?>(null))*/ required Rx<String?> selectedField,
      /*@Default(Rx<String?>(null))*/ this.selectedField,
      this.isLoadingData = false,
      this.optionSetConfiguration,
      this.sectionNumber = 0,
      this.showBottomShadow = false,
      this.lastPositionShouldChangeHeight = false,
      this.intentCallback,
      this.listViewUiEventsCallback});

  final String uid;
  final String label;

  ValueType? get valueType => ValueType.Section;

  final bool focused;
  final String? error;
  final bool editable;
  final String? warning;

  final String? parentSection;

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

  // final String? fieldMask;
  final bool isOpen;
  final int totalFields;
  final int completedFields;
  final int errors;
  final int warnings;
  final String? rendering;

  final String? selectedField;
  final bool isLoadingData;
  final OptionSetConfiguration? optionSetConfiguration;
  final int sectionNumber;
  final bool showBottomShadow;
  final bool lastPositionShouldChangeHeight;

  final IntentCallback? intentCallback;
  final ListViewUiEventsCallback? listViewUiEventsCallback;

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
    String? label,
    bool? focused,
    String? error,
    bool? editable,
    String? warning,
    String? parentSection,
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
      label: label ?? this.label,
      focused: focused ?? this.focused,
      error: error ?? this.error,
      editable: editable ?? this.editable,
      warning: warning ?? this.warning,
      parentSection: parentSection ?? this.parentSection,
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
