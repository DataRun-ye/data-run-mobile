import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/action.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_action.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';

extension RuleHandler on Template {
  Iterable<RuleAction> ruleActions() {
    return rules?.unlockView.map((rule) => rule.ruleAction) ?? [];
  }
}

extension ApplyAction on RuleAction {
  void apply(FormElementInstance<dynamic> element,
      {bool updateParent = true, bool emitEvent = true}) {
    if (element.mandatory && element.hidden) {
      element.markAsUnMandatory(updateParent: updateParent, emitEvent: false);
    }

    switch (action) {
      // case RuleActionType.Visibility:
      //   if (element.hidden) {
      //     logDebug('${element.name}, applying action: ${RuleActionType.Show}');
      //     element.markAsVisible(
      //         updateParent: updateParent, emitEvent: emitEvent);
      //   } else {
      //     logDebug('${element.name}, applying action: ${RuleActionType.Hide}');
      //     element.markAsHidden(
      //         updateParent: updateParent, emitEvent: emitEvent);
      //   }
      //   break;
      case RuleActionType.Show:
        logDebug('${element.name}, applying action: ${RuleActionType.Show}');
        element.markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Hide:
        logDebug('${element.name}, applying action: ${RuleActionType.Hide}');
        element.markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Error:
        if (element.visible) {
          final currentElementErrors = {...element.errors};
          currentElementErrors[getItemLocalString(message.unlockView)] =
              getItemLocalString(message.unlockView);
          element.setErrors(currentElementErrors);
        }
        break;
      case RuleActionType.Mandatory:
        if (element.visible) {
          element.markAsMandatory(
              updateParent: updateParent, emitEvent: emitEvent);
        }
        break;
      case RuleActionType.Assign:
        if (element.visible) {
          element.updateValue(assignedValue,
              updateParent: updateParent, emitEvent: emitEvent);
        }
        break;
      case RuleActionType.Filter:
      case RuleActionType.StopRepeat:
      case RuleActionType.Warning:
      case RuleActionType.Count:
      case RuleActionType.Unknown:
        // TODO NOT Implemented
        break;
      case RuleActionType.HideSection:
      case RuleActionType.ErrorOnComplete:
      case RuleActionType.WarningOnComplete:
      case RuleActionType.DisplayText:
      case RuleActionType.DisplayKeyValuePair:
      case RuleActionType.HideOption:
      case RuleActionType.HideOptionGroup:
      case RuleActionType.ShowOptionGroup:
        break;
    }
  }

  void reset(FormElementInstance<dynamic> element,
      {bool updateParent = true, bool emitEvent = true}) {
    if (element.mandatory && element.hidden) {
      element.markAsUnMandatory(
          updateParent: updateParent, emitEvent: emitEvent);
    }

    switch (action) {
      // case RuleActionType.Visibility:
      //   if (element.hidden) {
      //     element.markAsVisible(
      //         updateParent: updateParent, emitEvent: emitEvent);
      //   } else {
      //     logDebug('${element.name}, resetting action to: ${RuleActionType.Hide}');
      //     element.markAsHidden(
      //         updateParent: updateParent, emitEvent: emitEvent);
      //   }
      //   break;
      case RuleActionType.Show:
        logDebug(
            '${element.name}, resetting action to: ${RuleActionType.Hide}');
        element.markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Hide:
        logDebug(
            '${element.name}, resetting action to: ${RuleActionType.Show}');
        element.markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Error:
        element.removeError(getItemLocalString(message.unlockView),
            updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Mandatory:
        element.markAsUnMandatory(
            updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Assign:
      // element.reset(value: element.template.defaultValue);
      // break;
      case RuleActionType.Filter:
      case RuleActionType.StopRepeat:
      case RuleActionType.Warning:
      case RuleActionType.Count:
      case RuleActionType.Unknown:
        // TODO NOT Implemented
        break;
      case RuleActionType.HideSection:
      case RuleActionType.ErrorOnComplete:
      case RuleActionType.WarningOnComplete:
      case RuleActionType.DisplayText:
      case RuleActionType.DisplayKeyValuePair:
      case RuleActionType.HideOption:
      case RuleActionType.HideOptionGroup:
      case RuleActionType.ShowOptionGroup:
        break;
    }
  }
}
