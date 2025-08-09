import 'dart:convert';

import 'package:d_sdk/core/form/rule/action.dart';
import 'package:d_sdk/core/form/rule/rule_action.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class Rule with EquatableMixin {
  final String field;

  final String expression;

  final RuleActionType? action;
  final RuleAction ruleAction;
  final IMap<String, String>? message;
  final FilterInfo? filterInfo;
  final dynamic assignedValue;

  @override
  List<Object?> get props => [
        field,
        expression,
        action,
        ruleAction,
        message,
        filterInfo,
        assignedValue
      ];

  Rule(
      {required this.field,
      required this.expression,
      this.action,
      required this.ruleAction,
      this.message,
      this.filterInfo,
      this.assignedValue});

  factory Rule.fromJson(Map<String, dynamic> json) {
    final message = json['message'] != null
        ? Map<String, String>.from(json['message'] is String
            ? jsonDecode(json['message'])
            : json['message'])
        : <String, String>{};
    return Rule(
        field: json['field'],
        action: RuleActionType.getAction(json['action']),
        ruleAction: RuleAction.fromJson({
          'action': json['action'],
          'expression': json['expression'],
          'assignedValue': json['assignedValue'],
          'message': json['message'] != null
              ? Map<String, String>.from(json['message'] is String
                  ? jsonDecode(json['message'])
                  : json['message'])
              : {},
        }),
        expression: json['expression'],
        message: message.lock,
        filterInfo: json['filterInfo'] != null
            ? FilterInfo.fromJson(json['filterInfo'] is String
                ? jsonDecode(json['filterInfo'])
                : json['filterInfo'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'expression': expression,
      'action': action?.name,
      'ruleAction': ruleAction.toJson(),
      'message': message != null ? jsonEncode(message?.unlock) : null,
      'assignedValue': assignedValue,
      'filterInfo': filterInfo != null ? filterInfo!.toJson() : null,
    };
  }
}

class FilterInfo {
  final List<String>? optionsToHide;
  final List<String>? optionsToShow;

  FilterInfo({
    required this.optionsToHide,
    required this.optionsToShow,
  });

  factory FilterInfo.fromJson(Map<String, dynamic> json) {
    final optionsToHide = json['optionsToHide'] != null
        ? json['optionsToHide'].runtimeType == String
            ? jsonDecode(json['optionsToHide']).cast<String>()
            : json['optionsToHide'].cast<String>()
        : null;

    final optionsToShow = json['optionsToShow'] != null
        ? json['optionsToShow'].runtimeType == String
            ? jsonDecode(json['optionsToShow']).cast<String>()
            : json['optionsToShow'].cast<String>()
        : null;

    return FilterInfo(
      optionsToHide: optionsToHide,
      optionsToShow: optionsToShow,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionsToHide': optionsToHide != null ? jsonEncode(optionsToHide) : null,
      'optionsToShow': optionsToShow != null ? jsonEncode(optionsToShow) : null,
    };
  }
}
