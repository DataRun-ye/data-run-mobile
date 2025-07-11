part of 'field_ui_model.dart';

@immutable
class FieldUiModelImpl extends FieldUiModel {
  FieldUiModelImpl({
    required this.uid,
    this.repeatGroup,
    this.rowUid,
    required this.label,
    this.description,
    this.value,
    required this.valueType,
    this.optionSet,
    required this.focused,
    this.error,
    required this.editable,
    this.warning,
    required this.mandatory,
    this.parentSection,
    this.uiEventFactory,
    this.renderingType,
    this.sectionRenderingType,
    this.fieldRendering,
    this.optionSetConfiguration,
    this.keyboardActionType,
    this.isLoadingData = false,
    this.intentCallback,
    this.listViewUiEventsCallback,
    this.options = const [],
    this.optionsList = const [],
    String? displayValue,
  }) : this.displayValue = displayValue ?? value;

  final String uid;
  final String? repeatGroup;
  final String? rowUid;
  final String label;
  final String? description;
  final String? value;
  final ValueType valueType;
  final String? optionSet;
  final bool mandatory;
  final String? error;
  final String? warning;
  final bool focused;
  final bool editable;

  final List<String> options;
  final List<DropdownOption> optionsList;

  final String? parentSection;

  final UiEventFactory? uiEventFactory;

  final String? displayValue;

  final UiRenderType? renderingType;

  /// NMC added provided here instead to providing it
  /// to the FieldViewModelFactoryImpl
  /// from ProgramSection of the item
  final SectionRenderingType? sectionRenderingType;

  /// NMC added provided here instead to providing it
  /// to the FieldViewModelFactoryImpl
  /// from ProgramStageDataElement of the item
  final ValueTypeRenderingType? fieldRendering;

  final OptionSetConfiguration? optionSetConfiguration;
  final TextInputAction? keyboardActionType;

  final bool isLoadingData;

  final IntentCallback? intentCallback;
  final ListViewUiEventsCallback? listViewUiEventsCallback;

  void onSave(String? value) {
    onItemClick();
    intentCallback?.call(FormIntent.onSave(uid, value, valueType));
  }

  void onSaveBoolean(bool boolean) {
    onItemClick();
    final result = value == null || value != boolean.toString()
        ? boolean.toString()
        : null;
    intentCallback?.call(FormIntent.onSave(uid, result, valueType));
  }

  void onSaveOption(DataOption option) {
    String? nextValue;
    if (option.label?.lock.any((k, v) => v == displayValue) == true) {
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
    // intentCallback?.call(FormIntent.onRequestCoordinates(uid));
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
    String? parentSection,
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
    List<String>? options,
    List<DropdownOption>? optionsList,
  }) =>
      FieldUiModelImpl(
        uid: uid ?? this.uid,
        repeatGroup: repeatGroup ?? this.repeatGroup,
        rowUid: rowUid ?? this.rowUid,
        parentSection: parentSection ?? this.parentSection,
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
        options: options ?? this.options,
        optionsList: optionsList ?? this.optionsList,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        value,
        options,
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
