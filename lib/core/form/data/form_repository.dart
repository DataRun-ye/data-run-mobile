import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/core/form/data/data_integrity_check_result.data.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/row_action.dart';
import 'package:datarunmobile/core/form/model/store_result.dart';

abstract class FormRepository {
  Future<List<FieldUiModel>> fetchFormItems();

  Future<List<FieldUiModel>> composeList({bool skipProgramRules = false});

  // List<RulesUtilsProviderConfigurationError>? getConfigurationErrors();
  Future<DataIntegrityCheckResult> runDataIntegrityCheck(bool backPressed);

  // Currently no need to return Future
  double completedFieldsPercentage(List<FieldUiModel> value);

  bool calculationLoopOverLimit();

  List<FieldUiModel> backupOfChangedItems();

  void updateErrorList(RowAction action);

  Future<StoreResult?> save(String uid, String? value, String? extraData);

  Future<void> updateValueOnList(
      String uid, String? value, ValueType? valueType);

  FieldUiModel? currentFocusedItem();

  void setFocusedItem(RowAction action);

  void updateSectionOpened(RowAction action);

  void removeAllValues();

  void setFieldRequestingCoordinates(String uid, bool requestInProcess);

  void clearFocusItem();

  Future<void> fetchOptions(String uid, String optionSetUid);

  String getDateFormatConfiguration();

  List<String> getListFromPreferences(String uid);

  void saveListToPreferences(String uid, List<String> list);

  Future<void> completeEvent();

  Future<void> activateEvent();
//
// Future<void> addRowToRepeatableSection(String sectionUid);
//
// Future<void> removeRowFromRepeatableSection(
//     String sectionUid, String rowItemId);
}
