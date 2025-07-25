import 'dart:async';

import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';

/// Provides access to the raw form structure and data.
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

  Pair<String, List<DataOption>> options({
    required String optionSetUid,
    List<String> optionsToHide,
    List<String> optionGroupsToHide,
    List<String> optionGroupsToShow,
  });

  String? dateFormatConfiguration();

  ValidationStrategy? validationStrategy();
}
