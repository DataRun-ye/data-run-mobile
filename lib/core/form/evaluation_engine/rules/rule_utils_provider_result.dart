class RuleUtilsProviderResult {
  const RuleUtilsProviderResult({
    required this.canComplete,
    this.messageOnComplete,
    required this.fieldsWithErrors,
    required this.fieldsWithWarnings,
    required this.unsupportedRules,
    required this.fieldsToUpdate,
    required this.stagesToHide,
    required this.configurationErrors,
    required this.optionsToHide,
    required this.optionGroupsToHide,
    required this.optionGroupsToShow,
  });

  final bool canComplete;
  final String? messageOnComplete;
  final List<FieldWithError> fieldsWithErrors;
  final List<FieldWithError> fieldsWithWarnings;
  final List<String> unsupportedRules;
  final List<FieldWithNewValue> fieldsToUpdate;
  final List<String> stagesToHide;
  final List<RulesUtilsProviderConfigurationError> configurationErrors;
  final Map<String, List<String>> optionsToHide;
  final Map<String, List<String>> optionGroupsToHide;
  final Map<String, List<String>> optionGroupsToShow;

  Map<String, String> errorMap() {
    final map = <String, String>{};
    for (final item in fieldsWithErrors) {
      map[item.uid] = item.message;
    }
    return map;
  }

  Map<String, String> warningMap() {
    final map = <String, String>{};
    for (final item in fieldsWithWarnings) {
      map[item.uid] = item.message;
    }
    return map;
  }

  List<String> optionsToHideForField(String fieldUid) =>
      optionsToHide[fieldUid] ?? [];

  List<String> optionGroupsToHideForField(String fieldUid) =>
      optionGroupsToHide[fieldUid] ?? [];

  List<String> optionGroupsToShowForField(String fieldUid) =>
      optionGroupsToShow[fieldUid] ?? [];

  List<String> fieldsWithOptionEffects() => [
        ...optionsToHide.keys,
        ...optionGroupsToHide.keys,
        ...optionGroupsToShow.keys,
      ];
}

class FieldWithNewValue {
  const FieldWithNewValue({
    required this.uid,
    this.newValue,
  });

  final String uid;
  final String? newValue;
}

class FieldWithError {
  const FieldWithError({
    required this.uid,
    required this.message,
  });

  final String uid;
  final String message;
}

class RulesUtilsProviderConfigurationError {
  const RulesUtilsProviderConfigurationError({
    this.ruleUid,
    this.actionType = ActionType.none,
    required this.error,
    required this.extraData,
  });

  final String? ruleUid;
  final ActionType actionType;
  final ConfigurationError error;
  final List<String> extraData;
}

enum ActionType { assign, none }

enum ConfigurationError {
  valueToAssignNotInOptionSet('conf_error_value_to_assign_option_set'),
  currentValueNotInOptionSet('conf_error_value_option_set');

  const ConfigurationError(this.messageKey);

  final String messageKey;
}

// Extension for converting configuration errors to a message string
extension ConfigurationErrorsMessageExtension
    on List<RulesUtilsProviderConfigurationError> {
  String toMessage(String Function(String key) localize) {
    const bullet = '• ';
    return isEmpty
        ? ''
        : map((error) => _formatError(error, localize)).join('\n\n$bullet');
  }

  String _formatError(
    RulesUtilsProviderConfigurationError error,
    String Function(String key) localize,
  ) {
    final message = localize(error.error.messageKey);
    if (error.extraData.isEmpty) return message;
    return message.replaceAllMapped(
      RegExp(r'{(\d+)}'),
      (match) => error.extraData[int.parse(match.group(1)!)],
    );
  }
}
