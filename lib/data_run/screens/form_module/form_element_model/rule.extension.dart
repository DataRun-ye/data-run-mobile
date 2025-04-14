import 'package:d_sdk/core/form/rule/action.dart';
import 'package:d_sdk/core/form/rule/rule_action.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_element_model/form_element_model.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';

extension RuleHandler on FormElementTemplate {
  Iterable<RuleAction> ruleActions() {
    return rules.map((rule) => rule.ruleAction);
  }
}

extension ApplyAction on RuleAction {
  void apply(FormElementModel<dynamic> element) {
    switch (action) {
      case ActionType.Visibility:
        if (element.hidden) {
          logDebug('${element.name}, applying action: ${ActionType.Show}');
          element.markAsVisible();
        } else {
          logDebug('${element.name}, applying action: ${ActionType.Hide}');
          element.markAsHidden();
        }
        break;
      case ActionType.Show:
        logDebug('${element.name}, applying action: ${ActionType.Show}');
        element.markAsVisible();
        break;
      case ActionType.Hide:
        logDebug('${element.name}, applying action: ${ActionType.Hide}');
        element.markAsHidden();
        break;
      case ActionType.Error:
        final currentElementErrors = {...element.errors};
        currentElementErrors[getItemLocalString(message.unlockView)] =
            getItemLocalString(message.unlockView);
        element.setErrors(currentElementErrors);
        break;
      case ActionType.Mandatory:
        // element.markAsMandatory();
        break;
      case ActionType.Assign:
        element.updateValue(assignedValue);
        break;
      case ActionType.Filter:
      case ActionType.StopRepeat:
      case ActionType.Warning:
      case ActionType.Count:
      case ActionType.Unknown:
        // TODO NOT Implemented
        break;
    }
  }

  void reset(FormElementModel<dynamic> element) {
    switch (action) {
      case ActionType.Visibility:
        if (element.hidden) {
          element.markAsVisible();
        } else {
          logDebug('${element.name}, resetting action to: ${ActionType.Hide}');
          element.markAsHidden();
        }
        break;
      case ActionType.Show:
        logDebug('${element.name}, resetting action to: ${ActionType.Hide}');
        element.markAsHidden();
        break;
      case ActionType.Hide:
        logDebug('${element.name}, resetting action to: ${ActionType.Show}');
        element.markAsVisible();
        break;
      case ActionType.Error:
        element.removeError(getItemLocalString(message.unlockView));
        break;
      case ActionType.Mandatory:
        // element.markAsMandatory();
        break;
      case ActionType.Assign:
        // element.reset(value: element.template.defaultValue);
        break;
      case ActionType.Filter:
      case ActionType.StopRepeat:
      case ActionType.Warning:
      case ActionType.Count:
      case ActionType.Unknown:
        // TODO NOT Implemented
        break;
    }
  }
}
