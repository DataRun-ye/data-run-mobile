import 'dart:convert';
import 'dart:developer';

import 'package:d_sdk/core/form/rule/expression_provider.dart';
import 'package:d_sdk/core/form/rule/rule_action.dart';
import 'package:equatable/equatable.dart';
import 'package:expressions/expressions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class RuleAction
    with EquatableMixin
    implements
        DependenciesProvider,
        ExpressionProvider,
        EvaluationEngine<bool> {
  final String expression;
  final RuleActionType action;
  final bool applyEffect;
  final IMap<String, String> message;
  final dynamic assignedValue;

  RuleAction({
    required this.action,
    this.assignedValue,
    this.message = const IMapConst({}),
    this.applyEffect = true,
    required this.expression,
  });

  @override
  List<Object?> get props => [expression, action, assignedValue, message];

  factory RuleAction.fromJson(Map<String, dynamic> json) {
    final message = json['message'] != null
        ? Map<String, String>.from(json['message'] is String
            ? jsonDecode(json['message'])
            : json['message'])
        : <String, String>{};

    return RuleAction(
        expression: json['expression'],
        action: RuleActionType.getAction(json['action']),
        assignedValue: json['assignedValue'],
        message: IMap(message));
  }

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'action': action.name,
      'message': jsonEncode(message.unlockView),
      'assignedValue': assignedValue,
      // 'isInEffect': isInEffect,
    };
  }

  RuleAction copyWith({
    String? expression,
    RuleActionType? action,
    IMap<String, String>? message,
    dynamic assignedValue,
    bool? applyEffect,
  }) {
    return RuleAction(
        expression: expression ?? this.expression,
        action: action ?? this.action,
        message: message ?? this.message,
        assignedValue: assignedValue ?? this.assignedValue,
        applyEffect: applyEffect ?? this.applyEffect);
  }

  Expression getExpression() {
    return Expression.parse(evalExpression);
  }

  List<String> get dependencies {
    final fieldPattern = RegExp(r'#\{(.*?)\}');

    return fieldPattern
        .allMatches(expression)
        .map((match) => match.group(1)!)
        .toSet()
        .toList();
  }

  String get evalExpression =>
      expression.replaceAll('#{', '').replaceAll('}', '');

  @override
  bool evaluate([Map<String, dynamic>? context]) {
    try {
      final result = evaluator.eval(getExpression(), context!);
      return result;
    } catch (e) {
      log('Error Evaluation $evalExpression', error: e);
      return false;
    }
  }
}
