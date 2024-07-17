// ignore_for_file: always_specify_types

import 'dart:async';

import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:mass_pro/commons/date/field_with_issue.dart';
import 'package:mass_pro/commons/extensions/string_extension.dart';
import 'package:mass_pro/commons/helpers/iterable.dart';
import 'package:mass_pro/form/data/data_entry_repository.dart';
import 'package:mass_pro/form/data/data_integrity_check_result.dart';
import 'package:mass_pro/form/data/form_repository.dart';
import 'package:mass_pro/form/data/form_value_store.dart';
import 'package:mass_pro/form/model/action_type.dart';
import 'package:mass_pro/form/model/field_ui_model.dart';
import 'package:mass_pro/form/model/row_action.dart';
import 'package:mass_pro/form/model/section_ui_model_impl.dart';
import 'package:mass_pro/form/model/store_result.dart';
import 'package:mass_pro/form/ui/provider/display_name_provider.dart';
import 'package:mass_pro/form/ui/validation/field_error_message_provider.dart';
import 'package:mass_pro/sdk/core/common/value_type.dart';


class FormRepositoryImpl implements FormRepository {
  FormRepositoryImpl({
    this.formValueStore,
    required this.fieldErrorMessageProvider,
    required this.displayNameProvider,
    this.dataEntryRepository,
  });

  static const int _loopThreshold = 5;

  /// used to save each value to the database and gets the response
  final FormValueStore? formValueStore;

  /// encapsulate error messages returnint a localized user friendly
  /// message representing the an error message if there are any
  final FieldErrorMessageProvider fieldErrorMessageProvider;
  final DisplayNameProvider displayNameProvider;

  /// used to convert the action field on the database entities into the List of
  /// List<FieldUiModel> of fields model representing each field
  final DataEntryRepository? dataEntryRepository;

  /// Calculated after each event
  double _completionPercentage = 0;

  /// store fields with errors
  IList<RowAction> _itemsWithError = IList();

  /// map of mandatory Fields Without Value
  IMap<String, String> _mandatoryItemsWithoutValue = IMap({});
  String? _openedSectionUid;

  /// List<FieldUiModel> of fields model representing each field
  IList<FieldUiModel> _itemList = IList();

  /// current focused item
  String? _focusedItemId;

  /// Data Integrity is checking and validating the form entries
  /// when Data Integrity is run this field is set to true
  bool _runDataIntegrity = false;
  int _calculationLoop = 0;

  /// back up list of IList<FieldUiModel> that represent the value of the database
  /// so we can know if the value has changed or not so we can ask the user whether it
  /// want tho save the changes or discared if they don't equal the current [_itemList]
  IList<FieldUiModel> _backupList = IList();

  @override
  Future<IList<FieldUiModel>> fetchFormItems() async {
    final IList<String>? sectionUids =
        (await dataEntryRepository?.sectionUids())?.lock;

    _openedSectionUid = sectionUids != null && sectionUids.isNotEmpty
        ? sectionUids.first
        : null;

    final List<FieldUiModel>? items = await dataEntryRepository?.list();
    _itemList = items?.lock ?? IList();

    _backupList = _itemList;
    return composeList();
  }

  @override
  Future<IList<FieldUiModel>> composeList() {
    _calculationLoop = 0;

    return _mergeListWithErrorFields(_itemList, _itemsWithError)
        .then((IList<FieldUiModel> listOfItems) {
          _calculateCompletionPercentage(listOfItems);
          return listOfItems;
        })
        .then(
            (IList<FieldUiModel> listOfItems) => _setOpenedSection(listOfItems))
        .then((IList<FieldUiModel> listOfItems) => _setFocusedItem(listOfItems))
        .then((IList<FieldUiModel> listOfItems) => _setLastItem(listOfItems));
  }

  Future<IList<FieldUiModel>> _mergeListWithErrorFields(
      IList<FieldUiModel> list, IList<RowAction> fieldsWithError) async {
    _mandatoryItemsWithoutValue.clear();
    final IList<FieldUiModel> mergeList = IList<FieldUiModel>([]);
    mergeList.map((element) {});
    // list
    final List<FieldUiModel> mergedList =
        await Future.wait<FieldUiModel>(list.map((FieldUiModel item) async {
      if (item.mandatory && item.value == null) {
        _mandatoryItemsWithoutValue = _mandatoryItemsWithoutValue.add(
            item.label, item.programStageSection ?? '');
      }
      final RowAction? action = fieldsWithError
          .firstOrNullWhere((RowAction action) => action.id == item.uid);

      if (action != null) {
        final String? error = action.error != null
            ? fieldErrorMessageProvider.getFriendlyErrorMessage(action.error!)
            : null;

        final String? displayName = await displayNameProvider
            .provideDisplayName(action.valueType, action.value);
        return item
            .setValue(action.value)
            .setError(error)
            .setDisplayName(displayName);
      } else {
        return item;
      }
    }));
    return mergedList.lock;
  }

  /// pure function doesn't effect this class variables
  /// runs at finishing data entry, either by clicking back key
  /// or save key, if there are errors it will notify in the UI
  @override
  DataIntegrityCheckResult runDataIntegrityCheck({required bool allowDiscard}) {
    _runDataIntegrity = true;
    final IList<FieldWithIssue> itemsWithErrors = _getFieldsWithError();
    /*final*/
    final IList<FieldWithIssue> itemsWithWarning = IList([]);
    if (itemsWithErrors
        .isNotEmpty) {
      return FieldsWithErrorResult(
          mandatoryFields: _mandatoryItemsWithoutValue,
          fieldUidErrorList: itemsWithErrors,
          warningFields: itemsWithWarning,
          canComplete: /*ruleEffectsResult?.canComplete ??*/ true,
          onCompleteMessage: /*ruleEffectsResult?.messageOnComplete*/ null,
          allowDiscard: allowDiscard);
    }

    if (_mandatoryItemsWithoutValue.isNotEmpty) {
      return MissingMandatoryResult(
          mandatoryFields: _mandatoryItemsWithoutValue,
          errorFields: itemsWithErrors,
          warningFields: itemsWithWarning,
          canComplete: /*ruleEffectsResult?.canComplete ??*/ true,
          onCompleteMessage: /*ruleEffectsResult?.messageOnComplete*/ null,
          allowDiscard: allowDiscard);
    }

    if (itemsWithWarning.isNotEmpty) {
      return FieldsWithWarningResult(
          fieldUidWarningList: itemsWithWarning,
          canComplete: /*ruleEffectsResult?.canComplete ??*/ true,
          onCompleteMessage: /*ruleEffectsResult?.messageOnComplete*/ null);
    }

    if (backupOfChangedItems().isNotEmpty && allowDiscard) {
      return const NotSavedResult();
    }

    return const SuccessfulResult(
        canComplete: /*ruleEffectsResult?.canComplete ?? */ true,
        onCompleteMessage: /*ruleEffectsResult?.messageOnComplete*/ null);
  }

  @override
  IList<FieldUiModel> backupOfChangedItems() {
    // return backupList.minus(itemList.applyRuleEffects());
    return _backupList;
  }

  @override
  bool calculationLoopOverLimit() {
    return _calculationLoop == _loopThreshold;
  }

  @override
  void clearFocusItem() {
    _focusedItemId = null;
  }

  @override
  double completedFieldsPercentage(IList<FieldUiModel> value) {
    return _completionPercentage;
  }

  @override
  FieldUiModel? currentFocusedItem() {
    return _itemList
        .firstOrNullWhere((FieldUiModel item) => _focusedItemId == item.uid);
  }

  @override
  void removeAllValues() {
    _itemList = _itemList
        .map((FieldUiModel fieldUiModel) =>
            fieldUiModel.setValue(null).setDisplayName(null))
        .toIList();
  }

  @override
  Future<StoreResult?> save(String id, String? value, String? extraData) {
    final storeResult = formValueStore?.save(id, value, extraData) ??
        Future<StoreResult?>.value();
    return storeResult;
  }

  @override
  void setFieldRequestingCoordinates(String uid, bool requestInProcess) {
    // TODO(NMC): improve
    _itemList.let((IList<FieldUiModel> list) => list
        .firstOrNullWhere((FieldUiModel item) => item.uid == uid)
        ?.let((FieldUiModel item) => _itemList = list.replace(
            list.indexOf(item), item.setIsLoadingData(requestInProcess))));
  }

  @override
  void setFocusedItem(RowAction action) {
    when(action.type, {
      ActionType.ON_NEXT: () => _focusedItemId = _getNextItem(action.id),
      ActionType.ON_FINISH: () => _focusedItemId = null,
    }).orElse(() => _focusedItemId = action.id);
  }

  /// if action has error and its item is not yet in _itemsWithError, it adds
  /// it to it. Else which means it was _itemsWithError, it then removes it.
  @override
  void updateErrorList(RowAction action) {
    /// if action has error
    if (action.error != null) {
      /// if item is not in _itemsWithError
      if (_itemsWithError
              .firstOrNullWhere((RowAction item) => item.id == action.id) ==
          null) {
        _itemsWithError = _itemsWithError.add(action);
      }
    } else {
      _itemsWithError
          .firstOrNullWhere((RowAction item) => item.id == action.id)
          ?.let((RowAction item) =>
              _itemsWithError = _itemsWithError.remove(item));
    }
  }

  @override
  void updateSectionOpened(RowAction action) {
    _openedSectionUid = action.id;
  }

  /// updates the field model in _itemList with the value based on the uid
  @override
  Future<void> updateValueOnList(
      String uid, String? value, ValueType? valueType) async {
    final int itemIndex =
        _itemList.indexWhere((FieldUiModel item) => item.uid == uid);
    if (itemIndex >= 0) {
      // TODO(NMC): improve
      final FieldUiModel item = _itemList[itemIndex];
      _itemList = _itemList.replace(
          itemIndex,
          item.setValue(value).setDisplayName(await displayNameProvider
              .provideDisplayName(valueType, value, item.optionSet)));
      /*   .setLegend(
                legendValueProvider?.provideLegendValue(item.uid, value))*/
    }
  }

  void _calculateCompletionPercentage(IList<FieldUiModel> list) {
    const List<ValueType> unsupportedValueTypes = [
      ValueType.FileResource,
      ValueType.TrackerAssociate,
      ValueType.Username
    ];

    final Iterable<FieldUiModel> fields = list.where((FieldUiModel it) =>
        it.valueType != null && !unsupportedValueTypes.contains(it.valueType));

    final int totalFields = fields.length;
    final int fieldsWithValue =
        fields.where((FieldUiModel it) => it.value != null).length;
    if (totalFields == 0) {
      _completionPercentage = 0;
    } else {
      _completionPercentage =
          fieldsWithValue.toDouble() / totalFields.toDouble();
    }
  }

  Future<IList<FieldUiModel>> _setOpenedSection(
      IList<FieldUiModel> list) async {
    final List<FieldUiModel> fields = [];
    for (final FieldUiModel field in list) {
      if (field.isSection()) {
        fields.add(_updateSection(field, list));
      } else {
        final FieldUiModel item = await _updateField(field);
        fields.add(item);
      }
    }

    return fields
        .where((FieldUiModel field) =>
            field.isSectionWithFields() ||
            field.programStageSection == _openedSectionUid)
        .toIList();
  }

  FieldUiModel _updateSection(
      FieldUiModel sectionFieldUiModel, IList<FieldUiModel> fields) {
    int total = 0;
    int values = 0;
    final bool isOpen = sectionFieldUiModel.uid == _openedSectionUid;
    fields
        .where((FieldUiModel item) =>
            item.programStageSection == sectionFieldUiModel.uid &&
            item.valueType != null)
        .forEach((FieldUiModel item) {
      total++;
      if (!item.value.isNullOrEmpty) {
        values++;
      }
    });

    const int
        warningCount = /*ruleEffectsResult?.warningMap()?.filter { warning ->
    fields.firstOrNull { field ->
    field.uid == warning.key && field.programStageSection == sectionFieldUiModel.uid
    } != null
    }?.size ?: */
        0;
    //

    final int mandatoryCount = _runDataIntegrity
        ? _mandatoryItemsWithoutValue
            .where((_, mandatory) => mandatory == sectionFieldUiModel.uid)
            .length
        : 0;

    final int errorCount = IMap.fromIterable<String, String, FieldWithIssue>(
      _getFieldsWithError(),
      keyMapper: (it) => it.fieldUid,
      valueMapper: (it) => it.message,
    )
        .where((key, value) =>
            fields.firstOrNullWhere((FieldUiModel field) =>
                field.uid == key &&
                field.programStageSection == sectionFieldUiModel.uid) !=
            null)
        .length;

    if (dataEntryRepository != null) {
      return dataEntryRepository!.updateSection(sectionFieldUiModel, isOpen,
          total, values, errorCount + mandatoryCount, warningCount);
    }

    return sectionFieldUiModel;
  }

  FutureOr<FieldUiModel> _updateField(FieldUiModel fieldUiModel) {
    final bool needsMandatoryWarning =
        fieldUiModel.mandatory && fieldUiModel.value == null;

    if (needsMandatoryWarning) {
      _mandatoryItemsWithoutValue = _mandatoryItemsWithoutValue.add(
          fieldUiModel.label, fieldUiModel.programStageSection ?? '');
    }

    if (dataEntryRepository != null) {
      final mandatoryWarning = needsMandatoryWarning && _runDataIntegrity
          ? fieldErrorMessageProvider.mandatoryWarning()
          : null;
      return dataEntryRepository!.updateField(
          fieldUiModel,
          mandatoryWarning,
          /*ruleEffectsResult?.optionsToHide(fieldUiModel.uid) ?:*/ [],
          /*ruleEffectsResult?.optionGroupsToHide(fieldUiModel.uid) ?:*/ [],
          /*ruleEffectsResult?.optionGroupsToShow(fieldUiModel.uid) ?:*/ []);
    }
    return fieldUiModel;
  }

  IList<FieldWithIssue> _getFieldsWithError() {
    return _itemsWithError.mapNotNull((RowAction? errorItem) {
      final FieldUiModel? item = _itemList
          .firstOrNullWhere((FieldUiModel item) => item.uid == errorItem?.id);
      if (item != null) {
        return FieldWithIssue(
            fieldUid: item.uid,
            fieldName: item.label,
            issueType: IssueType.ERROR,
            message: errorItem?.error != null
                ? fieldErrorMessageProvider
                    .getFriendlyErrorMessage(errorItem!.error!)
                : '');
      }
      return null;
    }).toIList();
  }

  IList<FieldUiModel> _setFocusedItem(IList<FieldUiModel> list) {
    if (_focusedItemId != null) {
      final FieldUiModel? item = list
          .firstOrNullWhere((FieldUiModel item) => item.uid == _focusedItemId);
      if (item != null) {
        list = list.replace(list.indexOf(item), item.setFocus());
      }
    }
    return list;
  }

  IList<FieldUiModel> _setLastItem(IList<FieldUiModel> list) {
    if (list.isEmpty) {
      return list;
    }
    if (list.every((FieldUiModel it) => it is SectionUiModelImpl)) {
      final FieldUiModel lastItem = _getLastSectionItem(list);
      if (_usesKeyboard(lastItem.valueType) &&
          lastItem.valueType != ValueType.LongText) {
        return list.replace(
            list.indexOf(lastItem), lastItem.setKeyBoardActionDone());
      }
    }
    return list;
  }

  FieldUiModel _getLastSectionItem(IList<FieldUiModel> list) {
    if (list.every((FieldUiModel item) => item is SectionUiModelImpl)) {
      return list.reversed.first;
    }
    return list.reversed
        .firstWhere((FieldUiModel item) => item.valueType != null);
  }

  bool _usesKeyboard(ValueType? valueType) {
    return valueType != null
        ? valueType.isText || valueType.isNumeric || valueType.isInteger
        : false;
  }

  String? _getNextItem(String currentItemUid) {
    _itemList.let((IList<FieldUiModel> fields) {
      // final oldItem = fields.firstOrNullWhere((item) => item.uid == currentItemUid);
      final int pos = fields
          .indexWhere((FieldUiModel oldItem) => oldItem.uid == currentItemUid);
      if (pos < fields.length - 1) {
        return fields[pos + 1].uid;
      }
    });
    return null;
  }
}
