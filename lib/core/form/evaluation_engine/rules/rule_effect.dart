import 'package:datarun/core/form/evaluation_engine/rules/rule_action.dart';
import 'package:equatable/equatable.dart';

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
