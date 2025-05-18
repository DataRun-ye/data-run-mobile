import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/section_rendering_type.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/option_set_configuration.data.dart';
import 'package:datarunmobile/core/form/model/section_ui_model_impl.dart';

abstract class FieldViewModelFactory {
  FieldViewModelFactory();

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
    required String? description,
    // ValueTypeDeviceRendering? fieldRendering,
    // required ObjectStyle objectStyle = ObjectStyle.builder().build(),
    String? fieldMask,
    OptionSetConfiguration? optionSetConfiguration,
    // FeatureType? featureType,
  });

  // Future<FieldUiModel> createForAttribute(
  //     {required TrackedEntityAttribute trackedEntityAttribute,
  //     ProgramTrackedEntityAttribute? programTrackedEntityAttribute,
  //     String? value,
  //     required bool editable,
  //     OptionSetConfiguration? optionSetConfiguration});

  FieldUiModel createSingleSection(String singleSectionName);

  SectionUiModelImpl createSection(
      String sectionUid,
      SectionTemplate template,
      String? sectionName,
      String? description,
      bool isOpen,
      int totalFields,
      int completedFields,
      String? rendering);

  FieldUiModel createClosingSection();
}
