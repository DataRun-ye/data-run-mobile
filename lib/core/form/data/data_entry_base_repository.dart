import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/section_rendering_type.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/core/form/data/data_entry_repository.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/ui/field_view_model_factory.dart';

/// Encapsulate interacting with a FormTemplate's submission data,
/// and their templates, transforming, binding ...
/// interact with submission Form Elements values individually based on
/// the submission encapsulated properties, updating
///
abstract class DataEntryBaseRepository implements DataEntryRepository {
  DataEntryBaseRepository(this.fieldFactory);

  // D2Remote d2;
  final FieldViewModelFactory fieldFactory;

  FormTemplateVersion get formTemplateVersion;

  @override
  FieldUiModel updateSection(
      SectionUiModelImpl sectionToUpdate,
      bool isSectionOpen,
      int totalFields,
      int fieldsWithValue,
      int errorCount,
      int warningCount) {
    return sectionToUpdate.copyWith(
        isOpen: isSectionOpen,
        totalFields: totalFields,
        completedFields: fieldsWithValue,
        errors: errorCount,
        warnings: warningCount);
  }

  @override
  Future<FieldUiModel> updateField(
      FieldUiModel fieldUiModel,
      String? warningMessage,
      List<String> optionsToHide,
      List<String> optionGroupsToHide,
      List<String> optionGroupsToShow) async {
    // options to hide and show are not calculated again, they change based on
    // the rule then keep getting filtered whenever field is updates, hidden show
    // stays hidden...etc,
    final List<String> optionsInGroupsToHide =
        await _optionsFromGroups(optionGroupsToHide);
    final List<String> optionsInGroupsToShow =
        await _optionsFromGroups(optionGroupsToShow);
    if (fieldUiModel.optionSet != null) {
      // fieldUiModel.optionSetConfiguration?.updateOptionsToHideAndShow(
      //     optionsToHide: [...optionsToHide, ...optionsInGroupsToHide],
      //     optionsToShow: optionsInGroupsToShow);
    }

    return warningMessage != null
        ? fieldUiModel.setError(warningMessage)
        : fieldUiModel;
  }

  Future<List<String>> _optionsFromGroups(List<String> optionGroupUids) async {
    throw UnimplementedError();
    // if (optionGroupUids.isEmpty) return [];
    // final List<String> optionsFromGroups = [];
    // final List<OptionGroup> optionGroups =
    //     await D2Remote.optionModule.optionGroup.byIds(optionGroupUids).get();
    // for (final OptionGroup optionGroup in optionGroups) {
    //   for (final OptionGroupOption option in optionGroup.options! /*?? []*/) {
    //     if (option.id != null && !optionsFromGroups.contains(option.id)) {
    //       // optionsFromGroups.add(option.id!.split('_').last);
    //       optionsFromGroups.add(option.option);
    //     }
    //   }
    // }
    // return optionsFromGroups;
  }

  /// transform Section Entity to [SectionUiModelImpl] for the UI
  FieldUiModel transformSection(
      {required String sectionUid,
      required SectionTemplate template,
      String? sectionName,
      String? sectionDescription,
      bool isOpen = false,
      int totalFields = 0,
      int completedFields = 0}) {
    return fieldFactory.createSection(
        sectionUid: sectionUid,
        label: getItemLocalString(template.label.unlockView,
            defaultString: template.name),
        description: template.description,
        isOpen: isOpen,
        totalFields: totalFields,
        completedFields: completedFields,
        rendering: SectionRenderingType.LISTING.name);
  }

  @override
  String? dateFormatConfiguration() {
    return null;
    // return conf.dateFormatConfiguration()
  }

  @override
  ValidationStrategy? validationStrategy() {
    return null;
  }
}
