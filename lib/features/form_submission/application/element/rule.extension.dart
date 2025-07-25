import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/rule/action.dart';
import 'package:d_sdk/core/form/rule/rule_action.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';

extension RuleHandler on Template {
  Iterable<RuleAction> ruleActions() {
    return rules?.unlockView.map((rule) => rule.ruleAction) ?? [];
  }
}

extension ApplyAction on RuleAction {
  void apply(FormElementInstance<dynamic> element,
      {bool updateParent = true, bool emitEvent = true}) {
    if (element.mandatory && element.hidden) {
      element.markAsUnMandatory(
          updateParent: updateParent, emitEvent: emitEvent);
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
        logDebug('${element.elementPath}, apply: ${RuleActionType.Show}');
        element.markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Hide:
        logDebug('${element.elementPath}, apply: ${RuleActionType.Hide}');
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
      case RuleActionType.Warning:
      case RuleActionType.Unknown:
        // TODO NOT Implemented
        break;
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
        logDebug('${element.elementPath}, reset: ${RuleActionType.Hide}');
        element.markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Hide:
        logDebug('${element.elementPath}, reset: ${RuleActionType.Show}');
        element.markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Error:
        element.removeError(getItemLocalString(message.unlockView));
        break;
      case RuleActionType.Mandatory:
        element.markAsUnMandatory(
            updateParent: updateParent, emitEvent: emitEvent);
        break;
      case RuleActionType.Assign:
      // element.reset(value: element.template.defaultValue);
      // break;
      case RuleActionType.Filter:
      case RuleActionType.Warning:
      case RuleActionType.Unknown:
        // TODO NOT Implemented
        break;
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
