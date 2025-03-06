import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/section_rendering_type.dart';
import 'package:datarun/commons/extensions/dynamic_extensions.dart';
import 'package:datarun/core/form/data/display_name_provider.dart';
import 'package:datarun/core/form/model/field_ui_model.dart';
import 'package:datarun/core/form/model/field_ui_model_impl.dart';
import 'package:datarun/core/form/model/option_set_configuration.dart';
import 'package:datarun/core/form/model/section_ui_model_impl.dart';
import 'package:datarun/core/form/ui/event/ui_event_factory_impl.dart';
import 'package:datarun/core/form/ui/factories/hint_provider.dart';
import 'package:datarun/core/form/ui/field_view_model_factory.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';

class FieldViewModelFactoryImpl implements FieldViewModelFactory {
  FieldViewModelFactoryImpl({
    required this.noMandatoryFields,
    // required this.uiStyleProvider,

    /// Replaced by WidgetProvider
    // required this.layoutProvider,
    required this.hintProvider,
    required this.displayNameProvider,
    // required this.uiEventTypesProvider,
    // required this.keyboardActionProvider,
    /*this.legendValueProvider*/
  });

  final bool noMandatoryFields;

  // final UiStyleProvider uiStyleProvider;

  /// Replaced by WidgetProvider
  // final LayoutProvider layoutProvider;
  final HintProvider hintProvider;
  final DisplayNameProvider displayNameProvider;

  // final UiEventTypesProvider uiEventTypesProvider;
  // final KeyboardActionProvider keyboardActionProvider;

  final String _currentSection = '';

  @override
  Future<FieldUiModel> create({
    required String uid,
    required String label,
    // required ValueType valueType,
    required Template template,
    required bool mandatory,
    String? optionSet,
    String? value,
    String? programStageSection,
    required bool allowFutureDates,
    required bool editable,
    SectionRenderingType? renderingType,
    String? description,
    // ValueTypeDeviceRendering? fieldRendering,
    String? fieldMask,
    OptionSetConfiguration? optionSetConfiguration,
    // FeatureType? featureType,
  }) async {
    bool isMandatory = mandatory;
    isNull(template, 'template must be supplied');

    if (noMandatoryFields) isMandatory = false;

    // TODO(NMC): avoid asynchronicity using scopes
    /// see:
    /// https://docs-v2.riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
    ///
    final String? displayName = await displayNameProvider.provideDisplayValue(
        template.type, value, optionSet);

    return FieldUiModelImpl(
      uid: uid,
      path: template.path!,
      label: getItemLocalString(template.label.unlock,
          defaultString: template.name),
      valueType: template.type!,

      /// NMC added
      sectionRenderingType: renderingType,

      /// NMC added
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
          valueType: template.type!,
          allowFutureDates: allowFutureDates,
          optionSet: optionSet),
      displayValue: displayName,
      // renderingType: uiEventTypesProvider.provideUiRenderType(featureType,
      //     fieldRendering?.type.toValueTypeRenderingType, renderingType),
      optionSetConfiguration: optionSetConfiguration,
      // keyboardActionType:
      //     keyboardActionProvider.provideKeyboardAction(valueType),
      // fieldMask: fieldMask,
    );
  }

  @override
  FieldUiModel createSingleSection(String singleSectionName) {
    return SectionUiModelImpl(
        uid: SINGLE_SECTION_UID,
        path: SINGLE_SECTION_UID,
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
  SectionUiModelImpl createSection(
      String sectionUid,
      SectionTemplate template,
      String? sectionName,
      String? description,
      bool isOpen,
      int totalFields,
      int completedFields,
      String? rendering) {
    return SectionUiModelImpl(
        uid: sectionUid,
        path: template.path!,
        label: getItemLocalString(template.label.unlock,
            defaultString: template.name),
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
        path: CLOSING_SECTION_UID,
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
