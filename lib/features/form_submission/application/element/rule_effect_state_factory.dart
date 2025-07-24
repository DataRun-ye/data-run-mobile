import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/core/form/rule/action.dart';
import 'package:d_sdk/core/form/rule/rule_action.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RuleEffectStateFactory {
  final List<String> unsupportedRuleActions = [];

  FormElementState<T> applyRuleEffects<T>({
    // required bool applyForEvent,
    required FormElementState<T> elementState,
    required List<RuleAction> calcResult,
    // DataValueRepository? valueStore,
  }) {
    unsupportedRuleActions.clear();
    FormElementState<T> formElementState = elementState.copyWith();
    for (final effect in calcResult) {
      final message = getItemLocalString(effect.message.unlockView);
      switch (effect.action) {
        case RuleActionType.Warning:
          formElementState = effect.applyEffect
              ? formElementState.setWarning(message)
              : formElementState.resetWarning(message);
          break;
        case RuleActionType.Error:
          formElementState = effect.applyEffect
              ? formElementState.setError(message)
              : formElementState.resetError(message);
          break;
        case RuleActionType.Hide:
          formElementState = effect.applyEffect
              ? formElementState.copyWith(
                  hidden: true, mandatory: false, errors: {}, warning: '')
              : formElementState.copyWith(hidden: false);
          break;
        case RuleActionType.Show:
          formElementState = effect.applyEffect
              ? formElementState.copyWith(hidden: false)
              : formElementState.copyWith(
                  hidden: true, mandatory: false, errors: {}, warning: '');
          break;

        // case RuleActionType.HideSection:
        //   _hideSection(fieldViewModels, effect.ruleAction);
        //   break;
        case RuleActionType.Assign:
          formElementState = formElementState is FieldElementState
              ? effect.applyEffect
                  ? formElementState.copyWith(value: effect.assignedValue)
                  : formElementState.copyWith(value: null)
              : formElementState;
          break;
        // case RuleActionType.CREATEEVENT:
        //   // no-op
        //   break;
        case RuleActionType.Mandatory:
          formElementState = effect.applyEffect
              ? formElementState.copyWith(mandatory: true)
              : formElementState.copyWith(mandatory: false);
          break;

        case RuleActionType.HideOption:
          // formElementState = formElementState;
          break;
        case RuleActionType.HideOptionGroup:
          // formElementState = formElementState;
          break;
        case RuleActionType.ShowOptionGroup:
          // formElementState = await _showOptionGroup(effect);
          break;
        case RuleActionType.DisplayText:
        case RuleActionType.DisplayKeyValuePair:
          // no-op
          break;
        case RuleActionType.WarningOnComplete:
        case RuleActionType.ErrorOnComplete:
          break;
        default:
          unsupportedRuleActions.add(effect.action.name);
      }
    }

    return formElementState;
  }
}
