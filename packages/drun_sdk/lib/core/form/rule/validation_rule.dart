import 'dart:convert';
import 'dart:developer' show log;

import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:equatable/equatable.dart';
import 'package:expressions/src/expressions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'expression_provider.dart';

class ValidationRule
    with EquatableMixin
    implements
        DependenciesProvider,
        ExpressionProvider,
        EvaluationEngine<bool> {
  final String field;
  final String expression;
  final IMap<String, String>? validationMessage;

  @override
  List<Object?> get props => [
        field,
        expression,
        validationMessage,
      ];

  ValidationRule({
    required this.field,
    required this.expression,
    this.validationMessage,
  });

  factory ValidationRule.fromJson(Map<String, dynamic> json) {
    final message = json['validationMessage'] != null
        ? Map<String, String>.from(json['validationMessage'] is String
            ? jsonDecode(json['validationMessage'])
            : json['validationMessage'])
        : <String, String>{};
    return ValidationRule(
        field: json['field'],
        expression: json['expression'],
        validationMessage: message.lock);
  }

  ValidationRule copyWith({
    String? field,
    String? expression,
    IMap<String, String>? validationMessage,
  }) {
    return ValidationRule(
      field: field ?? this.field,
      expression: expression ?? this.expression,
      validationMessage: validationMessage ?? this.validationMessage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'expression': expression,
      'validationMessage': validationMessage?.unlockView,
    };
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
  bool evaluate([Map<String, dynamic>? context = const {}]) {
    try {
      final result = evaluator.eval(getExpression(), context!);
      return result;
    } catch (e) {
      log('Error Evaluation $evalExpression', error: e);
      return false;
    }
  }

  String get displayMessage => getItemLocalString(validationMessage?.unlockView,
      defaultString: "validation_error_no_message_configured");
}
