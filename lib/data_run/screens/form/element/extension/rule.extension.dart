import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/action.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_action.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';

extension RuleHandler on Template {
  Iterable<RuleAction> ruleActions() {
    return rules?.unlockView.map((rule) => rule.ruleAction) ?? [];
  }
}

extension ApplyAction on RuleAction {
  void apply(FormElementInstance<dynamic> element,
      {bool updateParent = true, bool emitEvent = true}) {
    switch (action) {
      case ActionType.Show:
        // logDebug('${element.name}, applying action: ${ActionType.Show}');
        element.markAsVisible(updateParent: updateParent, emitEvent: false);
        break;
      case ActionType.Hide:
        // logDebug('${element.name}, applying action: ${ActionType.Hide}');
        element.markAsHidden(updateParent: updateParent, emitEvent: false);
        break;
      case ActionType.Error:
        if (element.visible) {
          final currentElementErrors = {...element.errors};
          currentElementErrors[getItemLocalString(message.unlockView)] =
              getItemLocalString(message.unlockView);
          element.addError(getItemLocalString(message.unlockView));
        }
        break;
      case ActionType.Mandatory:
        if (element.visible) {
          element.markAsMandatory(updateParent: updateParent, emitEvent: false);
        }
        break;
      case ActionType.Assign:
        if (element.visible) {
          element.updateValue(assignedValue,
              updateParent: updateParent, emitEvent: false);
        }
        break;
      case ActionType.Visibility:
      case ActionType.Filter:
      case ActionType.StopRepeat:
      case ActionType.Warning:
      case ActionType.Count:
      case ActionType.Unknown:
        // TODO NOT Implemented
        break;
    }
  }

  void reset(FormElementInstance<dynamic> element,
      {bool updateParent = true, bool emitEvent = true}) {
    switch (action) {
      case ActionType.Show:
        // logDebug('${element.name}, resetting action to: ${ActionType.Hide}');
        element.markAsHidden(updateParent: updateParent, emitEvent: false);
        break;
      case ActionType.Hide:
        // logDebug('${element.name}, resetting action to: ${ActionType.Show}');
        element.markAsVisible(updateParent: updateParent, emitEvent: false);
        break;
      case ActionType.Error:
        element.removeError(getItemLocalString(message.unlockView),
            updateParent: updateParent);
        break;
      case ActionType.Mandatory:
        element.markAsUnMandatory(updateParent: updateParent, emitEvent: false);
        break;
      case ActionType.Assign:
      // element.reset(value: element.template.defaultValue);
      // break;
      case ActionType.Visibility:
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
