import 'dart:async';

import 'package:d_sdk/core/form/rule/rule_action.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/commons/extensions/value_type_formatter.dart';
import 'package:datarunmobile/core/form/data/form_value_store.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_action.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_effect.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_utils_provider_result.dart';
import 'package:datarunmobile/core/form/evaluation_engine/rules/rules_utils_provider.dart';
import 'package:datarunmobile/core/form/model/field_ui_model.dart';
import 'package:datarunmobile/core/form/model/value_store_result.dart';
import 'package:drift/drift.dart';

class RulesUtilsProviderImpl implements RulesUtilsProvider {
  bool applyForEvent = false;
  bool canComplete = true;
  String? messageOnComplete;

  final List<FieldWithError> fieldsWithErrors = [];
  final List<FieldWithError> fieldsWithWarnings = [];
  final List<String> unsupportedRuleActions = [];

  final Map<String, List<String>> optionsToHide = {};
  final Map<String, List<String>> optionGroupsToHide = {};
  final Map<String, List<String>> optionGroupsToShow = {};

  final List<FieldWithNewValue> fieldsToUpdate = [];
  final List<String> hiddenFields = [];
  final List<RulesUtilsProviderConfigurationError> configurationErrors = [];
  final List<String> stagesToHide = [];

  FormValueStore? valueStore;
  String? currentRuleUid;
  final Map<String, String?> _valuesToChange = {};

  @override
  Future<RuleUtilsProviderResult> applyRuleEffects({
    required bool applyForEvent,
    required Map<String, FieldUiModel> fieldViewModels,
    required List<RuleEffect> calcResult,
    FormValueStore? valueStore,
  }) async {
    // reset state
    this.applyForEvent = applyForEvent;
    canComplete = true;
    messageOnComplete = null;
    fieldsWithErrors.clear();
    fieldsWithWarnings.clear();
    unsupportedRuleActions.clear();
    optionsToHide.clear();
    optionGroupsToHide.clear();
    optionGroupsToShow.clear();
    fieldsToUpdate.clear();
    hiddenFields.clear();
    configurationErrors.clear();
    stagesToHide.clear();
    _valuesToChange.clear();
    this.valueStore = valueStore;

    for (final effect in calcResult) {
      currentRuleUid = effect.ruleId;
      switch (RuleActionType.getAction(effect.ruleAction.type)) {
        case RuleActionType.Warning:
          _showWarning(effect.ruleAction, fieldViewModels, effect.data ?? '');
          break;
        case RuleActionType.Error:
          _showError(effect.ruleAction, fieldViewModels, effect.data ?? '');
          break;
        case RuleActionType.Hide:
          _hideElement(effect.ruleAction, fieldViewModels);
          break;
        case RuleActionType.DisplayText:
        case RuleActionType.DisplayKeyValuePair:
          // no-op
          break;
        // case RuleActionType.HideSection:
        //   _hideSection(fieldViewModels, effect.ruleAction);
        //   break;
        case RuleActionType.Assign:
          await _assign(effect.ruleAction, effect, fieldViewModels);
          break;
        // case RuleActionType.CREATEEVENT:
        //   // no-op
        //   break;
        case RuleActionType.Mandatory:
          _setMandatory(effect.ruleAction, fieldViewModels);
          break;
        case RuleActionType.WarningOnComplete:
          _warningOnCompletion(
              effect.ruleAction, fieldViewModels, effect.data ?? '');
          break;
        case RuleActionType.ErrorOnComplete:
          _errorOnCompletion(
              effect.ruleAction, fieldViewModels, effect.data ?? '');
          break;
        // case RuleActionType.HIDEPROGRAMSTAGE:
        //   _hideProgramStage(effect.ruleAction);
        //   break;
        case RuleActionType.HideOption:
          await _hideOption(effect.ruleAction);
          break;
        case RuleActionType.HideOptionGroup:
          await _hideOptionGroup(effect.ruleAction);
          break;
        case RuleActionType.ShowOptionGroup:
          await _showOptionGroup(effect.ruleAction);
          break;
        default:
          unsupportedRuleActions.add(effect.ruleId);
      }
    }

    // persist value changes
    await Future.forEach(_valuesToChange.entries, _saveAndUpdate);

    currentRuleUid = null;

    return RuleUtilsProviderResult(
      canComplete: canComplete,
      messageOnComplete: messageOnComplete,
      fieldsWithErrors: [...fieldsWithErrors],
      fieldsWithWarnings: [...fieldsWithWarnings],
      unsupportedRules: [...unsupportedRuleActions],
      fieldsToUpdate: [...fieldsToUpdate],
      configurationErrors: [...configurationErrors],
      stagesToHide: [...stagesToHide],
      optionsToHide: Map.from(optionsToHide),
      optionGroupsToHide: Map.from(optionGroupsToHide),
      optionGroupsToShow: Map.from(optionGroupsToShow),
    );
  }

  Future<void> _saveAndUpdate(MapEntry<String, String?> entry) async {
    final result = await _save(entry);
    if (result == ValueStoreResult.VALUE_CHANGED) {
      fieldsToUpdate
          .add(FieldWithNewValue(uid: entry.key, newValue: entry.value));
    }
  }

  Future<ValueStoreResult> _save(MapEntry<String, String?> entry) async {
    return applyForEvent
        ? await _saveForEvent(entry.key, entry.value)
        : await _saveForEnrollment(entry.key, entry.value);
  }

  Future<ValueStoreResult> _saveForEvent(String uid, String? value) async {
    return (await valueStore?.saveWithTypeCheck(uid, value))
            ?.valueStoreResult ??
        ValueStoreResult.VALUE_UNCHANGED;
  }

  Future<ValueStoreResult> _saveForEnrollment(String uid, String? value) async {
    // try {
    //   if (d2.dataElementModule().dataElements().uid(uid).exists()) {
    //     // no-op
    //     return ValueStoreResult.VALUE_UNCHANGED;
    //   } else if (d2
    //       .trackedEntityModule()
    //       .trackedEntityAttributes()
    //       .uid(uid)
    //       .exists()) {
    //     return valueStore?.save(uid, value, null).valueStoreResult ??
    //         ValueStoreResult.VALUE_UNCHANGED;
    //   }
    // } catch (e) {
    //   // log error
    //   return ValueStoreResult.VALUE_UNCHANGED;
    // }
    return ValueStoreResult.VALUE_UNCHANGED;
  }

  void _showWarning(
      RuleAction action, Map<String, FieldUiModel> fields, String data) {
    final uid = action.field ?? '';
    final model = fields[uid];
    final msg = '${action.content} $data';
    if (model != null) {
      fields[uid] = model.setWarning(msg);
      fieldsWithWarnings.add(FieldWithError(uid: uid, message: msg));
    }
  }

  void _showError(
      RuleAction action, Map<String, FieldUiModel> fields, String data) {
    final uid = action.field ?? '';
    final model = fields[uid];
    final msg = '${action.content} $data';
    if (model != null) {
      fields[uid] = model.setError(msg);
      canComplete = false;
      fieldsWithErrors.add(FieldWithError(uid: uid, message: msg));
    }
  }

  void _hideFieldOrSection(
      RuleAction action, Map<String, FieldUiModel> fields) {}

  void _hideElement(RuleAction action, Map<String, FieldUiModel> fields) {
    final uid = action.field ?? '';
    final model = fields[uid];
    if (model != null) {
      return switch (model) {
        FieldUiModelImpl() => _hideField(action, fields),
        SectionUiModelImpl() => _hideSection(action, fields),
        RepeatableSectionUiModel() => _hideRepeat(action, fields),
      };
    }
  }

  /// Hide Field/or Section
  void _hideField(RuleAction action, Map<String, FieldUiModel> fields) {
    final uid = action.field ?? '';
    final model = fields[uid];
    if (model?.mandatory != true) {
      fields.remove(uid);
      _valuesToChange[uid] = null;
      hiddenFields.add(uid);
    }
  }

  void _hideSection(RuleAction action, Map<String, FieldUiModel> fields) {
    final section = action.section;
    fields.removeWhere((key, f) => f.parentSection == section && !f.mandatory);
  }

  void _hideRepeat(RuleAction action, Map<String, FieldUiModel> fields) {
    final section = action.section;
    fields.removeWhere((key, f) => f.parentSection == section && !f.mandatory);
  }

  FutureOr<void> _assign(RuleAction action, RuleEffect ruleEffect,
      Map<String, FieldUiModel> fields) async {
    final uid = action.field ?? '';
    final field = fields[uid];
    if (field != null) {
      late final String? value;
      if (field.optionSet != null && field.displayValue != null) {
        final DataOption? valueOption = await DSdk.db.managers.dataOptions
            .filter(
                (f) => f.optionSet.id(field.optionSet) & f.code(field.value))
            .getSingleOrNull();
        if (valueOption == null) {
          configurationErrors.add(
            RulesUtilsProviderConfigurationError(
              ruleUid: currentRuleUid,
              actionType: ActionType.assign,
              error: ConfigurationError.currentValueNotInOptionSet,
              extraData: [field.label, field.optionSet ?? ''],
            ),
          );
        }
        value = valueOption?.name;
      } else {
        value = field.value;
      }

      if (value == null || value != ruleEffect.data) {
        _valuesToChange[uid] = ruleEffect.data.formatData(field.valueType);
      }

      late final String? valueToShow;

      if (field.optionSet != null && ruleEffect.data?.isNotEmpty == true) {
        final DataOption? effectOption = await DSdk.db.managers.dataOptions
            .filter((f) =>
                f.optionSet.id(field.optionSet) & f.code(ruleEffect.data))
            .getSingleOrNull();

        if (effectOption == null) {
          configurationErrors.add(
            RulesUtilsProviderConfigurationError(
              ruleUid: currentRuleUid,
              actionType: ActionType.assign,
              error: ConfigurationError.valueToAssignNotInOptionSet,
              extraData: [
                currentRuleUid ?? '',
                ruleEffect.data ?? '',
                field.optionSet ?? '',
              ],
            ),
          );
        }
        valueToShow = effectOption?.displayName;
      } else {
        valueToShow = ruleEffect.data;
      }

      final updated = field
          .setValue(ruleEffect.data?.formatData(field.valueType))
          .setDisplayValue(valueToShow?.formatData(field.valueType))
          .setEditable(false);
      fields[uid] = updated;
    } else {
      if (!hiddenFields.contains(uid)) {
        _valuesToChange[uid] = ruleEffect.data?.formatData(null);
      }
    }
  }

  void _setMandatory(RuleAction action, Map<String, FieldUiModel> fields) {
    final uid = action.field ?? '';
    if (fields.containsKey(uid)) {
      fields[uid] = fields[uid]!.setFieldMandatory();
    } else {
      fields.forEach((key, m) {
        if (key.startsWith(uid)) {
          fields[key] = m.setFieldMandatory();
        }
      });
    }
  }

  void _warningOnCompletion(
      RuleAction action, Map<String, FieldUiModel> fields, String data) {
    final uid = action.field ?? '';
    final msg = '${action.content} $data';
    if (fields.containsKey(uid)) {
      fields[uid] = fields[uid]!.setWarning(msg);
      fieldsWithWarnings.add(FieldWithError(uid: uid, message: msg));
    }
    messageOnComplete = msg;
  }

  void _errorOnCompletion(
      RuleAction action, Map<String, FieldUiModel> fields, String data) {
    final uid = action.field ?? '';
    final msg = '${action.content} $data';
    if (fields.containsKey(uid)) {
      fields[uid] = fields[uid]!.setError(msg);
      fieldsWithErrors.add(FieldWithError(uid: uid, message: msg));
    }
    canComplete = false;
    messageOnComplete = msg;
  }

  void _hideProgramStage(RuleAction action) {
    final stage = action.values['programStage'];
    if (stage != null) stagesToHide.add(stage);
  }

  Future<void> _hideOption(RuleAction action) async {
    final uid = action.field ?? '';
    final opt = action.values['option'];
    if (opt != null) {
      optionsToHide.putIfAbsent(uid, () => []).add(opt);
      final res = await valueStore?.deleteOptionValueIfSelected(uid, opt);
      if (res?.valueStoreResult == ValueStoreResult.VALUE_CHANGED) {
        fieldsToUpdate.add(FieldWithNewValue(uid: uid, newValue: null));
      }
    }
  }

  Future<void> _hideOptionGroup(RuleAction action) async {
    final uid = action.field ?? '';
    final grp = action.values['optionGroup'];
    if (grp != null) {
      optionGroupsToHide.putIfAbsent(uid, () => []).add(grp);
      final res =
          await valueStore?.deleteOptionValueIfSelectedInGroup(uid, grp, true);
      if (res?.valueStoreResult == ValueStoreResult.VALUE_CHANGED) {
        fieldsToUpdate.add(FieldWithNewValue(uid: uid, newValue: null));
      }
    }
  }

  Future<void> _showOptionGroup(RuleAction action) async {
    final uid = action.field ?? '';
    final grp = action.values['optionGroup'];
    if (grp != null) {
      optionGroupsToShow.putIfAbsent(uid, () => []).add(grp);
      final res =
          await valueStore?.deleteOptionValueIfSelectedInGroup(uid, grp, false);
      if (res?.valueStoreResult == ValueStoreResult.VALUE_CHANGED) {
        fieldsToUpdate.add(FieldWithNewValue(uid: uid, newValue: null));
      }
    }
  }
}
