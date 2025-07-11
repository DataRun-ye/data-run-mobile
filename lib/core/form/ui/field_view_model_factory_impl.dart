import 'package:d_sdk/core/form/section_rendering_type.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/data/display_name_provider.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/option_set_configuration.data.dart';
import 'package:datarunmobile/core/form/ui/event/ui_event_factory_impl.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/core/form/ui/field_view_model_factory.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

// @Injectable(as: FieldViewModelFactory)
class FieldViewModelFactoryImpl implements FieldViewModelFactory {
  FieldViewModelFactoryImpl({
    @factoryParam bool? noMandatoryFields,
    // required this.uiStyleProvider,

    // required this.layoutProvider,
    required this.hintProvider,
    required this.displayNameProvider,
    // required this.uiEventTypesProvider,
    // required this.keyboardActionProvider,
    /*this.legendValueProvider*/
  }) : this.noMandatoryFields = noMandatoryFields ?? false;

  final bool noMandatoryFields;

  // final UiStyleProvider uiStyleProvider;

  /// Replaced by WidgetProvider
  // final LayoutProvider layoutProvider;
  final HintProvider hintProvider;
  final DisplayNameProvider displayNameProvider;

  // final UiEventTypesProvider uiEventTypesProvider;

  final String _currentSection = '';

  @override
  Future<FieldUiModel> create(
      {required String uid,
      required String label,
      required ValueType valueType,
      // required Template template,
      required bool mandatory,
      String? optionSet,
      String? value,
      String? parentSection,
      required bool allowFutureDates,
      required bool editable,
      SectionRenderingType? renderingType,
      String? description,
      // ValueTypeDeviceRendering? fieldRendering,
      // required ObjectStyle objectStyle = ObjectStyle.builder().build(),
      String? fieldMask,
      OptionSetConfiguration? optionSetConfiguration}) async {
    bool isMandatory = mandatory;
    if (noMandatoryFields) isMandatory = false;

    final String? displayName = await displayNameProvider.provideDisplayValue(
        valueType, value, optionSet);

    return FieldUiModelImpl(
      uid: uid,
      label: label,
      valueType: valueType,

      /// NMC added
      sectionRenderingType: renderingType,

      value: value,
      focused: false,
      error: null,
      editable: editable,
      warning: null,
      mandatory: isMandatory,
      // programStageSection: programStageSection,
      // style: uiStyleProvider.provideStyle(valueType),
      // hint: hintProvider.provideDateHint(valueType),
      description: description,
      // allowFutureDates: allowFutureDates,
      uiEventFactory: UiEventFactoryImpl(
          uid: uid,
          label: label,
          description: description,
          valueType: valueType,
          allowFutureDates: allowFutureDates,
          optionSet: optionSet),
      displayValue: displayName,
      // renderingType: uiEventTypesProvider.provideUiRenderType(featureType,
      //     fieldRendering?.type.toValueTypeRenderingType, renderingType),
      optionSetConfiguration: optionSetConfiguration,
      keyboardActionType:
          KeyboardActionProvider.provideKeyboardAction(valueType),
      // fieldMask: fieldMask,
    );
  }

  @override
  FieldUiModel createSingleSection(String singleSectionName) {
    return SectionUiModelImpl(
        uid: SINGLE_SECTION_UID,
        label: SINGLE_SECTION_UID,
        focused: false,
        error: null,
        editable: false,
        warning: null,
        description: null,
        uiEventFactory: null,
        renderingType: null,
        keyboardActionType: null,
        isOpen: true,
        totalFields: 0,
        completedFields: 0,
        errors: 0,
        warnings: 0,
        rendering: SectionRenderingType.LISTING.name,
        selectedField: _currentSection);
  }

  @override
  SectionUiModelImpl createSection({
    required String sectionUid,
    required String label,
    String? parentSection,
    String? description,
    bool isOpen = false,
    required int totalFields,
    required int completedFields,
    String? rendering,
  }) {
    return SectionUiModelImpl(
        uid: sectionUid,
        label: label,
        focused: false,
        error: null,
        editable: false,
        warning: null,
        // mandatory: false,
        // label: sectionName ?? '',
        // programStageSection: sectionUid,
        // style: null,
        // hint: null,
        description: description,
        // valueType: null,
        // legend: null,
        // optionSet: null,
        // allowFutureDates: false,
        uiEventFactory: null,
        // displayName: null,
        renderingType: null,
        keyboardActionType: null,
        // fieldMask: null,
        isOpen: isOpen,
        totalFields: totalFields,
        completedFields: completedFields,
        errors: 0,
        warnings: 0,
        rendering: rendering,
        selectedField: _currentSection);
  }

  @override
  FieldUiModel createClosingSection() {
    return SectionUiModelImpl(
        uid: CLOSING_SECTION_UID,
        label: CLOSING_SECTION_UID,
        focused: false,
        editable: false,
        error: null,
        warning: null,
        description: null,
        uiEventFactory: null,
        renderingType: null,
        keyboardActionType: null,
        isOpen: false,
        totalFields: 0,
        completedFields: 0,
        errors: 0,
        warnings: 0,
        rendering: SectionRenderingType.LISTING.name,
        selectedField: _currentSection);
  }

// @override
// Future<FieldUiModel> createForAttribute(
//     {required TrackedEntityAttribute trackedEntityAttribute,
//       ProgramTrackedEntityAttribute? programTrackedEntityAttribute,
//       String? value,
//       required bool editable,
//       OptionSetConfiguration? optionSetConfiguration}) async {
//   isNull(trackedEntityAttribute.valueType, 'type must be supplied');
//
//   return create(
//     uid: trackedEntityAttribute.uid!,
//     // label: trackedEntityAttribute.displayFormName() ?? '',
//     label: trackedEntityAttribute.formName ?? '',
//     valueType: trackedEntityAttribute.valueType.toValueType!,
//     mandatory: programTrackedEntityAttribute?.mandatory ?? false,
//     // optionSet: trackedEntityAttribute.optionSet?.uid(),
//     optionSet: trackedEntityAttribute.optionSet,
//     value: value,
//     programStageSection: null,
//     allowFutureDates: programTrackedEntityAttribute?.allowFutureDate ?? true,
//     editable: editable,
//     renderingType: SectionRenderingType.LISTING,
//     // description: programTrackedEntityAttribute?.displayDescription()?? trackedEntityAttribute.displayDescription(),
//     description: programTrackedEntityAttribute?.description ??
//         trackedEntityAttribute.description,
//     // fieldRendering: programTrackedEntityAttribute?.renderType()?.mobile(),
//     // objectStyle: trackedEntityAttribute.style() ? : ObjectStyle.builder()
//     //     .build(),
//     fieldMask: trackedEntityAttribute.fieldMask,
//     optionSetConfiguration: optionSetConfiguration,
//     featureType:
//     trackedEntityAttribute.valueType.toValueType == ValueType.COORDINATE
//         ? FeatureType.POINT
//         : null,
//   );
// }
}

class KeyboardActionProvider {
  static TextInputAction provideKeyboardAction(ValueType valueType) =>
      switch (valueType) {
        ValueType.LongText => TextInputAction.newline,
        _ => TextInputAction.next
      };
}
