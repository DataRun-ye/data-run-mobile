import 'package:datarunmobile/core/form/evaluation_engine/rules/rule_action.dart';
import 'package:equatable/equatable.dart';

///  An object representing an action to be taken based on
///  a rule (e.g., set a value, hide a field, show an error).
/// example:
///
/// ```dart
/// RuleEffect(
///     "ruleUid",
///     RuleAction(
///         "data",
///         ProgramRuleActionType.HIDEOPTION.name,
///         mutableMapOf(
///             "content" to "content",
///             "field" to "uid007",
///             "option" to "Option2",
///         ),
///     ),
///     "data",
/// )
///```
sealed class RuleEffect with EquatableMixin {
  const RuleEffect(this.ruleId, this.ruleAction, [this.data = '']);

  final String ruleId;
  final RuleAction ruleAction;
  final String? data;

  @override
  List<Object?> get props => [ruleId, ruleAction, data];

  @override
  bool? get stringify => true;
}
