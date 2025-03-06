import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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
sealed class RuleAction with EquatableMixin {
  const RuleAction(
    this.data,
    this.type,
    this.values,
  );

  final String data;
  final String type;
  final IMap<String, String> values;

  @override
  List<Object?> get props => [data, type, values];

  @override
  bool? get stringify => true;
}
