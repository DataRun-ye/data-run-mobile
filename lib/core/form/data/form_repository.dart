import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/data/data_integrity_check_result.data.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/form_command.dart';
import 'package:datarunmobile/core/form/model/store_result.dart';

/// service layer class that manages the complex state and behavior of a
/// dynamic data entry form. It handles data fetching, user input, validation,
/// rule application, and UI state updates.
/// Decouples data access logic (DataEntryRepository, FormValueStore)
/// from the UI/business logic.
abstract class FormRepository {
  // ---- Form Data and Structure: -----
  /// Fetches the initial list of form items from the data source and
  /// prepares them for display.
  Future<List<FieldUiModel>> fetchFormItems();

  /// Composes the final list of form items to be displayed, applying rules,
  /// errors, focus, and section states.
  Future<List<FieldUiModel>> composeList({bool skipProgramRules = false});

  /// Updates the value and display value of a specific field in the itemList.
  Future<void> updateValueOnList(
      String uid, String? value, ValueType? valueType);

  /// Clears the entered values from all fields in the form.
  void removeAllValues();

  //---- Event and State Management:------------------
  /// Marks the current data entry event as complete.
  Future<void> completeEvent();

  /// Activates the current data entry event.
  Future<void> activateEvent();

  /// Sets the focusedItemId based on the received form command (e.g.,
  /// on next, on finish).
  void setFocusedItem(FormCommand action);

  /// Clears the currently focused item.
  void clearFocusItem();

  /// Clears the currently focused item.
  FieldUiModel? currentFocusedItem();

  ///  Updates the openedSectionUid when a section is expanded or collapsed.
  void updateSectionOpened(FormCommand action);

  /// Sets the loading state for a field that is fetching coordinates.
  void setFieldRequestingCoordinates(String uid, bool requestInProcess);

  //

  // ---- Data Integrity and Validation: ----
  // List<RulesUtilsProviderConfigurationError>? getConfigurationErrors();
  /// Performs a comprehensive validation of the form data, checking for
  /// errors, warnings, and missing mandatory fields.
  Future<DataIntegrityCheckResult> runDataIntegrityCheck(bool backPressed);

  /// Checks if the rule calculation loop has exceeded its threshold.
  bool calculationLoopOverLimit();

  /// Returns a list of items that have changed since the backupList
  /// was created.
  Future<List<FieldUiModel>> backupOfChangedItems();

  /// Adds or removes an error from the itemsWithError list based
  /// on the form command.
  void updateErrorList(FormCommand action);

  // --- Saving and Data Persistence: ---
  /// Saves the current form data to the data source.
  Future<StoreResult?> save(String uid, String? value, String? extraData);

  /// Saves a list of strings to the preferences.
  void saveListToPreferences(String uid, List<String> list);

  /// Retrieves a list of strings from the preferences.
  List<String> getListFromPreferences(String uid);

  // ---- Configuration and Helpers: ---
  /// Retrieves the configured date format string.
  String getDateFormatConfiguration();

  /// Returns the calculated form completion percentage.
  /// (Note: The parameter value seems unused in the provided snippet,
  /// it likely relies on the internal completionPercentage property).
  // Currently no need to return Future
  double completedFieldsPercentage(List<FieldUiModel> value);

  /// Fetches and updates the options for a field with an option set,
  /// considering rule effects.
  Future<void> fetchOptions(String uid, String optionSetUid);

//
// Future<void> addRowToRepeatableSection(String sectionUid);
//
// Future<void> removeRowFromRepeatableSection(
//     String sectionUid, String rowItemId);
}
