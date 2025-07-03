import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/action.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_action.dart';
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
      // case RuleActionType.Visibility:
      //   if (element.hidden) {
      //     logDebug('${element.name}, applying action: ${RuleActionType.Show}');
      //     element.markAsVisible();
      //   } else {
      //     logDebug('${element.name}, applying action: ${RuleActionType.Hide}');
      //     element.markAsHidden();
      //   }
      //   break;
      case RuleActionType.Show:
        logDebug('${element.name}, applying action: ${RuleActionType.Show}');
        element.markAsVisible();
        break;
      case RuleActionType.Hide:
        logDebug('${element.name}, applying action: ${RuleActionType.Hide}');
        element.markAsHidden();
        break;
      case RuleActionType.Error:
        final currentElementErrors = {...element.errors};
        currentElementErrors[getItemLocalString(message.unlockView)] =
            getItemLocalString(message.unlockView);
        element.setErrors(currentElementErrors);
        break;
      case RuleActionType.Mandatory:
        // element.markAsMandatory();
        break;
      case RuleActionType.Assign:
        element.updateValue(assignedValue);
        break;
      case RuleActionType.Filter:
      case RuleActionType.Warning:
      case RuleActionType.Unknown:
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

  void reset(FormElementModel<dynamic> element) {
    switch (action) {
      // case RuleActionType.Visibility:
      //   if (element.hidden) {
      //     element.markAsVisible();
      //   } else {
      //     logDebug('${element.name}, resetting action to: ${RuleActionType.Hide}');
      //     element.markAsHidden();
      //   }
      //   break;
      case RuleActionType.Show:
        logDebug(
            '${element.name}, resetting action to: ${RuleActionType.Hide}');
        element.markAsHidden();
        break;
      case RuleActionType.Hide:
        logDebug(
            '${element.name}, resetting action to: ${RuleActionType.Show}');
        element.markAsVisible();
        break;
      case RuleActionType.Error:
        element.removeError(getItemLocalString(message.unlockView));
        break;
      case RuleActionType.Mandatory:
        // element.markAsMandatory();
        break;
      case RuleActionType.Assign:
        // element.reset(value: element.template.defaultValue);
        break;
      case RuleActionType.Filter:
      case RuleActionType.Warning:
      case RuleActionType.Unknown:
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
