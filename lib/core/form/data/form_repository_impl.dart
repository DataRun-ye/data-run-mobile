import 'dart:convert';

import 'package:d2_remote/modules/datarun/form/shared/validation_strategy.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/list_extensions.dart';
import 'package:datarunmobile/core/form/data/data_entry_repository.dart';
import 'package:datarunmobile/core/form/data/data_integrity_check_result.data.dart';
import 'package:datarunmobile/core/form/data/display_name_provider.dart';
import 'package:datarunmobile/core/form/data/form_repository.dart';
import 'package:datarunmobile/core/form/data/form_value_store.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_effect.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_utils_provider_result.dart'
    as rule_utils;
import 'package:datarunmobile/core/form/evaluation_engine/rules/rules_utils_provider.dart';
import 'package:datarunmobile/core/form/model/action_type.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/row_action.dart';
import 'package:datarunmobile/core/form/model/section_ui_model_impl.dart';
import 'package:datarunmobile/core/form/model/store_result.dart';
import 'package:datarunmobile/core/form/ui/validation/field_error_message_provider.dart';
import 'package:datarunmobile/data/model/bottom_sheet_content_model.data.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int loopThreshold = 5;

class FormRepositoryImpl with EquatableMixin implements FormRepository {
  FormRepositoryImpl(
    this.formValueStore,
    this.fieldErrorMessageProvider,
    this.displayNameProvider,
    this.dataEntryRepository,
    // this.ruleEngineRepository,
    this.rulesUtilsProvider,
    // this.legendValueProvider,
    this.useCompose,
    this.sharedPreferences,
  ) : disableCollapsableSections =
            dataEntryRepository.disableCollapsableSections;

  final FormValueStore formValueStore;
  final FieldErrorMessageProvider fieldErrorMessageProvider;
  final DisplayNameProvider displayNameProvider;
  final DataEntryRepository dataEntryRepository;

  // final RuleEngineHelper? ruleEngineRepository;
  final RulesUtilsProvider rulesUtilsProvider;

  // final LegendValueProvider legendValueProvider;
  final bool useCompose;
  final SharedPreferences sharedPreferences;

  double completionPercentage = 0.0;
  List<RowAction> itemsWithError = [];
  Map<String, String> mandatoryItemsWithoutValue = {};
  String? openedSectionUid;
  List<FieldUiModel> itemList = [];
  String? focusedItemId;
  List<RuleEffect> ruleEffects = [];
  rule_utils.RuleUtilsProviderResult? ruleEffectsResult;
  bool runDataIntegrity = false;
  int calculationLoop = 0;
  List<FieldUiModel> backupList = [];
  List<FieldUiModel> fieldsWithOptionEffects = [];

  final bool? disableCollapsableSections;

  // Helper: returns a new list with the element at [index] replaced by [elem].
  List<T> updated<T>(List<T> list, int index, T elem) {
    final newList = List<T>.from(list);
    newList[index] = elem;
    return newList;
  }

  @override
  Future<List<FieldUiModel>> fetchFormItems() async {
    // Assume dataEntryRepository.list() returns a Future<List<FieldUiModel>>.
    itemList = await dataEntryRepository.list() ?? [];
    openedSectionUid = getInitialOpenedSection();
    backupList = List.from(itemList);
    return composeList();
  }

  String? getInitialOpenedSection() {
    if (disableCollapsableSections == true) {
      return null;
    }

    return dataEntryRepository.firstSectionToOpen();
  }

  @override
  Future<List<FieldUiModel>> composeList(
      {bool skipProgramRules = false}) async {
    calculationLoop = 0;
    var list = applyRuleEffects(itemList, skipProgramRules: skipProgramRules);
    list = await mergeListWithErrorFields(list, itemsWithError);
    _calculateCompletionPercentage(list);
    list = await setOpenedSection(list);
    list = _setFocusedItem(list);
    list = setLastItem(list);
    return list;
  }

  @override
  Future<void> completeEvent() async {
    await formValueStore.completeEvent();
    sharedPreferences.setString(
      'Preference.PREF_COMPLETED_EVENT',
      formValueStore.recordUid,
    );
  }

  @override
  Future<void> activateEvent() {
    return formValueStore.activateEvent();
  }

  // @override
  // Stream<PagingData<Period>> fetchPeriods() {
  //   return dataEntryRepository.fetchPeriods();
  // }

  bool usesKeyboard(ValueType? valueType) {
    if (valueType == null) return false;
    return valueType.isText || valueType.isNumeric || valueType.isInteger;
  }

  FieldUiModel getLastSectionItem(List<FieldUiModel> list) {
    if (list.every((item) => item is SectionUiModelImpl)) {
      return list.last;
    } else {
      return list.lastWhere((item) => item.valueType != null);
    }
  }

  List<FieldUiModel> setLastItem(List<FieldUiModel> list) {
    if (list.isEmpty) return list;
    if (list.every((item) => item is SectionUiModelImpl)) {
      final lastItem = getLastSectionItem(list);
      if (usesKeyboard(lastItem.valueType) &&
          lastItem.valueType != ValueType.LongText) {
        final index = list.indexOf(lastItem);
        return updated(list, index, lastItem.setKeyBoardActionDone());
      }
    }
    return list;
  }

  List<FieldUiModel> _setFocusedItem(List<FieldUiModel> list) {
    if (focusedItemId != null) {
      final index = list.indexWhere((item) => item.uid == focusedItemId);
      if (index != -1) {
        final updatedItem = list[index].setFocus();
        return updated(list, index, updatedItem);
      }
    }
    return list;
  }

  Future<List<FieldUiModel>> setOpenedSection(List<FieldUiModel> list) async {
    final updatedList = await Future.wait(list.map((field) async {
      if (field.isSection()) {
        return updateSection(field, list);
      } else {
        return await updateField(field);
      }
    }).toList());

    return updatedList.where((field) {
      if (field is SectionUiModelImpl) {
        return field.isSectionWithFields();
      } else {
        return useCompose ||
            (disableCollapsableSections == true) ||
            field.programStageSection == openedSectionUid;
      }
    }).toList();
  }

  FieldUiModel updateSection(
      FieldUiModel sectionFieldUiModel, List<FieldUiModel> fields) {
    int total = 0;
    int values = 0;
    // isOpen is true if this section matches the openedSectionUid and sections are collapsible.
    bool? isOpen = (sectionFieldUiModel.uid == openedSectionUid) &&
            (disableCollapsableSections != true)
        ? true
        : null;
    for (var field in fields) {
      if (field.programStageSection == sectionFieldUiModel.uid &&
          field.valueType != null) {
        total++;
        if (field.value != null && field.value!.isNotEmpty) {
          values++;
        }
      }
    }

    int warningCount = ruleEffectsResult
            ?.warningMap()
            ?.entries
            .where((entry) => fields.any((field) =>
                field.uid == entry.key &&
                field.programStageSection == sectionFieldUiModel.uid))
            .length ??
        0;

    int mandatoryCount = 0;
    if (runDataIntegrity) {
      mandatoryCount = mandatoryItemsWithoutValue.values
          .where((value) => value == sectionFieldUiModel.uid)
          .length;
    }

    int errorCount = ruleEffectsResult
            ?.errorMap()
            ?.entries
            .where((entry) => fields.any((field) =>
                field.uid == entry.key &&
                field.programStageSection == sectionFieldUiModel.uid))
            .length ??
        0;

    int errorFields = fields
        .where((field) =>
            field.programStageSection == sectionFieldUiModel.uid &&
            field.error != null)
        .length;

    return dataEntryRepository.updateSection(
      sectionFieldUiModel as SectionUiModelImpl,
      isOpen ?? true,
      total,
      values,
      errorCount + mandatoryCount + errorFields,
      warningCount,
    );
  }

  Future<FieldUiModel> updateField(FieldUiModel fieldUiModel) {
    bool needsMandatoryWarning = hasMandatoryWarnings(fieldUiModel);
    if (needsMandatoryWarning) {
      mandatoryItemsWithoutValue[fieldUiModel.label] =
          fieldUiModel.programStageSection ?? '';
    }
    final warning = (needsMandatoryWarning && runDataIntegrity)
        ? fieldErrorMessageProvider.mandatoryWarning()
        : null;
    return dataEntryRepository.updateField(
      fieldUiModel,
      warning,
      ruleEffectsResult?.optionsToHide[fieldUiModel.uid] ?? [],
      ruleEffectsResult?.optionGroupsToHide[fieldUiModel.uid] ?? [],
      ruleEffectsResult?.optionGroupsToShow[fieldUiModel.uid] ?? [],
    );
  }

  bool hasMandatoryWarnings(FieldUiModel fieldUiModel) {
    return fieldUiModel.mandatory &&
        (fieldUiModel.value == null || fieldUiModel.value!.isEmpty);
  }

  String? getNextItem(String currentItemUid) {
    final pos = itemList.indexWhere((item) => item.uid == currentItemUid);
    if (pos != -1 && pos < itemList.length - 1) {
      return itemList[pos + 1].uid;
    }
    return null;
  }

  void _calculateCompletionPercentage(List<FieldUiModel> list) {
    //   const List<ValueType> unsupportedValueTypes = [
    //     ValueType.FileResource,
    //     ValueType.TrackerAssociate,
    //     ValueType.Username
    //   ];
    //
    //   final Iterable<FieldUiModel> fields = list.where((FieldUiModel it) =>
    //       it.valueType != null && !unsupportedValueTypes.contains(it.valueType));
    //
    //   final int totalFields = fields.length;
    //   final int fieldsWithValue =
    //       fields.where((FieldUiModel it) => it.value != null).length;
    //   if (totalFields == 0) {
    //     _completionPercentage = 0;
    //   } else {
    //     _completionPercentage =
    //         fieldsWithValue.toDouble() / totalFields.toDouble();
    //   }
    // }
    //
    // Future<IList<FieldUiModel>> _setOpenedSection(
    //     IList<FieldUiModel> list) async {
    //   final List<FieldUiModel> fields = [];
    //   for (final FieldUiModel field in list) {
    //     if (field is SectionUiModelImpl) {
    //       fields.add(_updateSection(field, list));
    //     } else {
    //       final FieldUiModel item = await _updateField(field);
    //       fields.add(item);
    //     }
    //   }
    //
    //   return fields
    //       .where((FieldUiModel field) =>
    //           field.isSectionWithFields() ||
    //           field.programStageSection == _openedSectionUid)
    //       .toIList();
  }

  @override
  Future<void> updateValueOnList(
      String uid, String? value, ValueType? valueType) async {
    final updatedEnrollmentDataList =
        dataEntryRepository.getSpecificDataEntryItems(uid);
    if (updatedEnrollmentDataList.isNotEmpty) {
      updateEnrollmentDate(updatedEnrollmentDataList);
    }
    final index = itemList.indexWhere((item) => item.uid == uid);
    if (index != -1) {
      final item = itemList[index];
      final updatedItem = item.setValue(value).setDisplayValue(
            await displayNameProvider.provideDisplayValue(
                valueType, value, item.optionSet),
          );
      itemList = updated(itemList, index, updatedItem);
    }
  }

  void updateEnrollmentDate(List<FieldUiModel> fieldUiModelList) {
    // for (var element in fieldUiModelList) {
    //   final index = itemList.indexWhere(
    //       (item) => item.uid == EnrollmentRepository.ENROLLMENT_DATE_UID);
    //   if (index != -1) {
    //     final item = itemList[index];
    //     final updatedItem = item.setSelectableDates(element.selectableDates);
    //     itemList = updated(itemList, index, updatedItem);
    //   }
    // }
  }

  @override
  void removeAllValues() {
    itemList = itemList
        .map(
            (fieldUiModel) => fieldUiModel.setValue(null).setDisplayValue(null))
        .toList();
  }

  @override
  void setFieldRequestingCoordinates(String uid, bool requestInProcess) {
    final index = itemList.indexWhere((item) => item.uid == uid);
    if (index != -1) {
      final item = itemList[index];
      final updatedItem = item.setIsLoadingData(requestInProcess);
      itemList = updated(itemList, index, updatedItem);
    }
  }

  // @override
  // void setFieldAddingImage(String uid, bool requestInProcess) {
  //   final index = itemList.indexWhere((item) => item.uid == uid);
  //   if (index != -1) {
  //     final item = itemList[index];
  //     final updatedItem = item.setIsLoadingData(requestInProcess);
  //     itemList = updated(itemList, index, updatedItem);
  //   }
  // }

  Future<List<FieldUiModel>> mergeListWithErrorFields(
      List<FieldUiModel> list, List<RowAction> fieldsWithError) async {
    mandatoryItemsWithoutValue.clear();
    final List<Future<FieldUiModel>> items = list.map((item) async {
      if (hasMandatoryWarnings(item)) {
        mandatoryItemsWithoutValue[item.label] = item.programStageSection ?? '';
      }
      RowAction? action =
          fieldsWithError.firstOrNullWhere((a) => a.uid == item.uid);
      if (action != null) {
        final error = action.error != null
            ? fieldErrorMessageProvider.getFriendlyErrorMessage(action.error!)
            : '';
        return item.setValue(action.value).setError(error).setDisplayValue(
              await displayNameProvider.provideDisplayValue(
                  action.valueType, action.value, item.optionSet),
            );
      } else {
        return item;
      }
    }).toList();

    return Future.wait(items);
  }

  @override
  void updateErrorList(RowAction action) {
    if (action.error != null) {
      if (!itemsWithError.any((a) => a.uid == action.uid)) {
        itemsWithError.add(action);
      }
    } else {
      itemsWithError.removeWhere((a) => a.uid == action.uid);
    }
  }

  @override
  Future<StoreResult> save(String uid, String? value, String? extraData) async {
    final result = await formValueStore.save(uid, value, extraData);
    // if (result.contextDataChanged) {
    //   ruleEngineRepository?.refreshContext();
    // }
    return result;
  }

  // @override
  // StoreResult storeFile(String id, String? filePath) {
  //   return formValueStore.storeFile(id, filePath);
  // }

  // @override
  // bool areSectionCollapsable() {
  //   return disableCollapsableSections ?? false;
  // }

  // @override
  // bool hasLegendSet(String dataElementUid) {
  //   return legendValueProvider.hasLegendSet(dataElementUid);
  // }

  @override
  void setFocusedItem(RowAction action) {
    switch (action.actionType) {
      case ActionType.ON_NEXT:
        focusedItemId = getNextItem(action.uid);
        break;
      case ActionType.ON_FINISH:
        focusedItemId = null;
        break;
      default:
        focusedItemId = action.uid;
    }
  }

  @override
  Future<void> fetchOptions(String uid, String optionSetUid) async {
    // // Assume dataEntryRepository.options() returns an object with searchEmitter and optionFlow.
    // final optionsResult = dataEntryRepository.options(
    //   optionSetUid: optionSetUid,
    //   optionsToHide: ruleEffectsResult?.optionsToHide[uid] ?? [],
    //   optionGroupsToHide: ruleEffectsResult?.optionGroupsToHide[uid] ?? [],
    //   optionGroupsToShow: ruleEffectsResult?.optionGroupsToShow[uid] ?? [],
    // );
    // final newConf = OptionSetConfiguration(
    //   searchEmitter: optionsResult.searchEmitter,
    //   onSearch: (String query) {
    //     optionsResult.searchEmitter.value = query;
    //   },
    //   optionFlow: optionsResult.optionFlow,
    // );
    // final index = itemList.indexWhere((item) => item.uid == uid);
    // if (index != -1) {
    //   final item = itemList[index] as FieldUiModelImpl;
    //   // item.optionSetConfiguration = newConf;
    //   itemList = updated(
    //       itemList, index, item.copyWith(optionSetConfiguration: newConf));
    // }
  }

  @override
  void clearFocusItem() {
    focusedItemId = null;
  }

  @override
  FieldUiModel? currentFocusedItem() {
    return itemList.firstOrNullWhere((item) => item.uid == focusedItemId);
  }

  @override
  void updateSectionOpened(RowAction action) {
    if (disableCollapsableSections != true) {
      openedSectionUid = action.uid;
    }
  }

  @override
  String getDateFormatConfiguration() {
    return dataEntryRepository.dateFormatConfiguration() ?? 'ddMMyyyy';
  }

  @override
  List<String> getListFromPreferences(String uid) {
    final json = sharedPreferences.getString(uid) ?? '[]';
    final List<dynamic> list = jsonDecode(json);
    return list.cast<String>();
  }

  @override
  void saveListToPreferences(String uid, List<String> list) {
    final jsonStr = jsonEncode(list);
    sharedPreferences.setString(uid, jsonStr);
  }

  // ---------------------------
  // Data Integrity & Validation
  // ---------------------------

  @override
  Future<DataIntegrityCheckResult> runDataIntegrityCheck(
      bool backPressed) async {
    runDataIntegrity = true;
    final itemsWithErrors = getFieldsWithError();
    final isEvent = dataEntryRepository.isEvent();
    final itemsWithWarning =
        (ruleEffectsResult?.fieldsWithWarnings ?? []).map((warningField) {
      final field = itemList
          .firstOrNullWhere((item) => item.uid == warningField.fieldUid);
      return FieldWithIssue(
        fieldUid: warningField.fieldUid,
        // fieldPath: warningField.fieldUid,
        // parent: warningField.fieldUid,
        fieldName: field?.label ?? '',
        issueType: IssueType.Warning,
        message: warningField.errorMessage,
        fieldPath: field?.path ?? '',
      );
    }).toList();

    if (isEvent) {
      return getEventResult(itemsWithErrors, itemsWithWarning, backPressed);
    } else {
      return getEnrollmentResult(
          itemsWithErrors, itemsWithWarning, backPressed);
    }
  }

  DataIntegrityCheckResult getEnrollmentResult(
      List<FieldWithIssue> itemsWithErrors,
      List<FieldWithIssue> itemsWithWarning,
      bool allowDiscard) {
    if (itemsWithErrors.isNotEmpty ||
        (ruleEffectsResult?.canComplete == false)) {
      return FieldsWithErrorResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        fieldUidErrorList: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: allowDiscard,
        eventResultDetails: const EventResultDetails(),
      );
    } else if (mandatoryItemsWithoutValue.isNotEmpty) {
      return MissingMandatoryResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        errorFields: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: allowDiscard,
        eventResultDetails: const EventResultDetails(),
      );
    } else if (itemsWithWarning.isNotEmpty) {
      return FieldsWithWarningResult(
        fieldUidWarningList: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        eventResultDetails: const EventResultDetails(),
      );
    } else if (backupOfChangedItems().isNotEmpty && allowDiscard) {
      return const DataIntegrityCheckResult.notSavedResult();
    } else {
      return SuccessfulResult(
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        eventResultDetails: const EventResultDetails(),
      );
    }
  }

  Future<DataIntegrityCheckResult> getEventResult(
      List<FieldWithIssue> itemsWithErrors,
      List<FieldWithIssue> itemsWithWarning,
      bool backPressed) async {
    final eventStatus = await formValueStore.eventStateIsFinal();
    final validationStrategy = dataEntryRepository.validationStrategy();
    if (itemsWithErrors.isEmpty &&
        itemsWithWarning.isEmpty &&
        mandatoryItemsWithoutValue.isEmpty) {
      return getSuccessfulResult();
    } else if (itemsWithErrors.isNotEmpty) {
      return getFieldWithErrorResult(eventStatus, itemsWithErrors,
          itemsWithWarning, validationStrategy, backPressed);
    } else if (mandatoryItemsWithoutValue.isNotEmpty) {
      return getMissingMandatoryResult(eventStatus, itemsWithErrors,
          itemsWithWarning, validationStrategy, backPressed);
    } else {
      return getFieldWithWarningResult(
          eventStatus, itemsWithWarning, validationStrategy);
    }
  }

  Future<FieldsWithWarningResult> getFieldWithWarningResult(
      bool? eventStatusIsFinal,
      List<FieldWithIssue> itemsWithWarning,
      ValidationStrategy? validationStrategy) async {
    if (!(eventStatusIsFinal ?? false)) {
      return FieldsWithWarningResult(
        fieldUidWarningList: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: validationStrategy,
        ),
      );
    } else if (eventStatusIsFinal == true) {
      return FieldsWithWarningResult(
        fieldUidWarningList: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? false,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: null,
        ),
      );
    } else {
      return FieldsWithWarningResult(
        fieldUidWarningList: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? false,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: validationStrategy,
        ),
      );
    }
  }

  Future<DataIntegrityCheckResult> getMissingMandatoryResult(
      bool? eventStatusIsFinal,
      List<FieldWithIssue> itemsWithErrors,
      List<FieldWithIssue> itemsWithWarning,
      ValidationStrategy? validationStrategy,
      bool backPressed) async {
    if ((eventStatusIsFinal ?? false)) {
      return MissingMandatoryResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        errorFields: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: backPressed,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: validationStrategy,
        ),
      );
    } else if (eventStatusIsFinal == true) {
      return MissingMandatoryResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        errorFields: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: false,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: backPressed,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
        ),
      );
    } else {
      return MissingMandatoryResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        errorFields: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? false,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: backPressed,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: validationStrategy,
        ),
      );
    }
  }

  Future<FieldsWithErrorResult> getFieldWithErrorResult(
      bool? eventStatusIsFinal,
      List<FieldWithIssue> itemsWithErrors,
      List<FieldWithIssue> itemsWithWarning,
      ValidationStrategy? validationStrategy,
      bool backPressed) async {
    if (!(eventStatusIsFinal ?? false)) {
      return FieldsWithErrorResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        fieldUidErrorList: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? true,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: backPressed,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: validationStrategy,
        ),
      );
    } else if (eventStatusIsFinal == true) {
      return FieldsWithErrorResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        fieldUidErrorList: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: false,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: backPressed,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),
          // dataEntryRepository.eventMode(),
          validationStrategy: dataEntryRepository.validationStrategy(),
        ),
      );
    } else {
      return FieldsWithErrorResult(
        mandatoryFields: mandatoryItemsWithoutValue.lock,
        fieldUidErrorList: itemsWithErrors.lock,
        warningFields: itemsWithWarning.lock,
        canComplete: ruleEffectsResult?.canComplete ?? false,
        onCompleteMessage: ruleEffectsResult?.messageOnComplete,
        allowDiscard: backPressed,
        eventResultDetails: EventResultDetails(
          isFinal: await formValueStore.eventStateIsFinal(),

          // dataEntryRepository.eventMode(),
          validationStrategy: validationStrategy,
        ),
      );
    }
  }

  Future<SuccessfulResult> getSuccessfulResult() async {
    return SuccessfulResult(
      canComplete: ruleEffectsResult?.canComplete ?? true,
      onCompleteMessage: ruleEffectsResult?.messageOnComplete,
      eventResultDetails: EventResultDetails(
        isFinal: await formValueStore.eventStateIsFinal(),

        // dataEntryRepository.eventMode(),
        validationStrategy: dataEntryRepository.validationStrategy(),
      ),
    );
  }

  @override
  double completedFieldsPercentage(List<FieldUiModel> value) {
    return completionPercentage;
  }

  @override
  bool calculationLoopOverLimit() {
    return calculationLoop == loopThreshold;
  }

  @override
  List<FieldUiModel> backupOfChangedItems() {
    final updatedList = applyRuleEffects(itemList);
    // Assuming that FieldUiModel implements proper equality:
    return backupList.where((item) => !updatedList.contains(item)).toList();
  }

  List<FieldWithIssue> getFieldsWithError() {
    final list1 = itemsWithError
        .map((errorItem) {
          final item = itemList.firstOrNullWhere(
            (item) => item.uid == errorItem.uid,
          );
          if (item != null) {
            final message = errorItem.error != null
                ? fieldErrorMessageProvider
                    .getFriendlyErrorMessage(errorItem.error!)
                : '';
            return FieldWithIssue(
              fieldUid: item.uid,
              fieldName: item.label,
              issueType: IssueType.Error,
              message: message,
              fieldPath: item.path,
            );
          }
          return null;
        })
        .whereType<FieldWithIssue>()
        .toList();

    final list2 =
        (ruleEffectsResult?.fieldsWithErrors ?? <rule_utils.FieldWithError>[])
            .map<FieldWithIssue>((errorField) {
      final item =
          itemList.firstOrNullWhere((item) => item.uid == errorField.fieldUid);
      return FieldWithIssue(
        fieldUid: errorField.fieldUid,
        fieldName: item?.label ?? '',
        issueType: IssueType.Error,
        message: errorField.errorMessage,
        fieldPath: item?.path ?? '',
      );
    }).toList();

    return [...list1, ...list2];
  }

  // ---------------------------
  // Rule Effects application (recursive)
  // ---------------------------
  List<FieldUiModel> applyRuleEffects(List<FieldUiModel> list,
      {bool skipProgramRules = false}) {
    if (!skipProgramRules) {
      ruleEffects = _ruleEffects();
    }
    // Build a map of uid -> FieldUiModel.
    final fieldMap = {for (var field in list) field.uid: field};

    ruleEffectsResult = rulesUtilsProvider.applyRuleEffectsForEvent(
      applyForEvent: dataEntryRepository.isEvent(),
      fieldViewModels: fieldMap,
      ruleEffects: ruleEffects,
      valueStore: formValueStore,
    );

    if (ruleEffectsResult?.fieldsToUpdate.isNotEmpty ?? false) {
      for (var fieldWithNewValue in ruleEffectsResult!.fieldsToUpdate) {
        final field = itemList
            .firstOrNullWhere((f) => f.uid == fieldWithNewValue.fieldUid);
        if (field != null) {
          updateValueOnList(
              field.uid, fieldWithNewValue.newValue, field.valueType);
        }
      }
    }

    for (var field in fieldsWithOptionEffects) {
      if (field.optionSet != null) {
        fetchOptions(field.uid, field.optionSet!);
      }
    }
    fieldsWithOptionEffects.clear();

    ruleEffectsResult
        ?.fieldsWithOptionEffects()
        ?.forEach((fieldWithOptionEffect) {
      final item =
          itemList.firstOrNullWhere((f) => f.uid == fieldWithOptionEffect);
      if (item != null) {
        if (item.optionSet != null) {
          fetchOptions(item.uid, item.optionSet!);
        }
        fieldsWithOptionEffects.add(item);
      }
    });

    if ((ruleEffectsResult?.fieldsToUpdate.isNotEmpty ?? false) &&
        calculationLoop < loopThreshold) {
      calculationLoop++;
      return applyRuleEffects(fieldMap.values.toList(),
          skipProgramRules: skipProgramRules);
    } else {
      return fieldMap.values.toList();
    }
  }

  List<RuleEffect> _ruleEffects() {
    try {
      return [];
      // return ruleEngineRepository?.evaluate() ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  List<Object?> get props => [formValueStore.recordUid];
}
