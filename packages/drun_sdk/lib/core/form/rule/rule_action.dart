import 'package:d_sdk/core/util/list_extensions.dart';

enum RuleActionType {
  // Expression must be logical (true, false)
  Show, // deprecated, use Visibility
  Hide, // deprecated, use Visibility
  Error, // deprecated, use Constraint
  Warning, // deprecated, use Constraint
  Filter, // deprecated, use choice Filter
  Mandatory,
  // Expression result must be numerical >= 0
  // Expression result must be a compatible Value with the Field type
  // i.e for default Value
  Assign,
  DisplayText,
  DisplayKeyValuePair,
  WarningOnComplete,
  ErrorOnComplete,
  HideOption,
  HideOptionGroup,
  ShowOptionGroup,
  Unknown;

  static List<RuleActionType> get VISIBILITY_ACTIONS =>
      <RuleActionType>[Show, Hide];

  bool get isVisibility => VISIBILITY_ACTIONS.contains(this);

  static RuleActionType getAction(String? action) {
    return RuleActionType.values.firstOrNullWhere(
            (a) => a.name.toLowerCase() == action?.toLowerCase()) ??
        RuleActionType.Unknown;
  }
}
