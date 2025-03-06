import 'dart:async';

import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/validation_strategy.dart';
import 'package:datarun/commons/helpers/collections.dart';
import 'package:datarun/core/form/model/field_ui_model.dart';
import 'package:datarun/core/form/model/section_ui_model_impl.dart';

abstract class DataEntryRepository {
  bool? get disableCollapsableSections => null;

  String? firstSectionToOpen() => null;

  Future<List<FieldUiModel>> list();

  Future<List<String>> sectionUids();

  FieldUiModel updateSection(
      SectionUiModelImpl sectionToUpdate,
      bool isSectionOpen,
      int totalFields,
      int fieldsWithValue,
      int errorCount,
      int warningCount);

  Future<FieldUiModel> updateField(
      FieldUiModel fieldUiModel,
      String? warningMessage,
      List<String> optionsToHide,
      List<String> optionGroupsToHide,
      List<String> optionGroupsToShow);

  bool isEvent();

  List<FieldUiModel> getSpecificDataEntryItems(String uid);

  Pair<String, List<FormOption>> options({
    required String optionSetUid,
    List<String> optionsToHide,
    List<String> optionGroupsToHide,
    List<String> optionGroupsToShow,
  });

  String? dateFormatConfiguration();

  ValidationStrategy? validationStrategy();
}
