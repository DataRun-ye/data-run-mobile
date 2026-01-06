import 'dart:convert';

import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormOption with EquatableMixin {
  final String id;
  final String optionSet;
  final String code;
  final String name;
  final bool deleted;
  final Map<String, dynamic> label;
  final int order;
  final String? listName;
  final String? filterExpression;
  final IMap<String, dynamic>? properties;

  String get displayName => getItemLocalString(label, defaultString: name);

  FormOption({
    required this.id,
    required this.optionSet,
    required this.code,
    required this.name,
    required this.label,
    required this.order,
    this.deleted = false,
    this.listName,
    this.filterExpression,
    this.properties,
  });

  factory FormOption.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] != null
        ? Map<String, dynamic>.from(json['properties'] is String
            ? jsonDecode(json['properties'])
            : json['properties'])
        : <String, dynamic>{};

    final label = json['label'] != null
        ? Map<String, dynamic>.from(
            json['label'] is String ? jsonDecode(json['label']) : json['label'])
        : <String, dynamic>{"ar": json['name']};
    return FormOption(
      id: json['uid'] ?? json['id'],
      optionSet: json['optionSetUid'] ?? json['optionSet'],
      code: json['code'],
      name: json['name'],
      deleted: json['deletedAt'] != null,
      label: label,
      order: json['order'] ?? 0,
      listName: json['listName'],
      filterExpression: json['filterExpression'],
      properties: properties.lock,
    );
  }

  FormOption fromDataOption(DataOption dataOption) {
    return FormOption(
      id: dataOption.id,
      optionSet: dataOption.optionSet,
      code: dataOption.code,
      name: dataOption.name,
      deleted: dataOption.deletedAt != null,
      label: dataOption.label ?? {},
      order: dataOption.order,
      listName: listName,
      filterExpression: filterExpression,
      properties: properties,
    );
  }

  factory FormOption.fromDataOptionFactory(DataOption dataOption,
      {IMap<String, dynamic>? properties, String? filterExpression}) {
    return FormOption(
      id: dataOption.id,
      optionSet: dataOption.optionSet,
      code: dataOption.code,
      name: dataOption.name,
      deleted: dataOption.deletedAt != null,
      label: dataOption.label ?? {},
      order: dataOption.order,
      filterExpression: filterExpression,
      properties: IMap(),
    );
  }


  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    return {
      'id': id,
      'optionSet': optionSet,
      'code': code,
      'name': name,
      'deleted': deleted,
      'order': order,
      'displayName': displayName,
      'label': jsonEncode(label),
      'listName': listName,
      'filterExpression': filterExpression,
      'properties': jsonEncode(properties?.unlockView),
    };
  }

  List<String> get filterExpressionDependencies {
    final fieldPattern = RegExp(r'#\{(.*?)\}');

    return filterExpression != null
        ? fieldPattern
            .allMatches(filterExpression!)
            .map((match) => match.group(1)!)
            .toSet()
            .toList()
        : [];
  }

  String? get evalFilterExpression {
    return filterExpression?.replaceAll("#{", "").replaceAll("}", "");
  }

  Map<String, dynamic> toContext() {
    return {
      'id': id,
      'optionSet': optionSet,
      'code': code,
      'name': name,
      'deleted': deleted,
      'label': label,
      'listName': listName,
      ...?properties?.unlockView,
      'filterExpression': evalFilterExpression,
      'filterExpressionDependencies': filterExpressionDependencies,
      'order': order,
    };
  }

  @override
  List<Object?> get props =>
      [id, optionSet, code, name, listName, order, filterExpression];

  FormOption copyWith({
    String? id,
    String? optionSet,
    String? code,
    String? name,
    bool? deleted,
    Map<String, dynamic>? label,
    int? order,
    String? listName,
    String? filterExpression,
    IMap<String, dynamic>? properties,
  }) {
    return FormOption(
      id: id ?? this.id,
      optionSet: optionSet ?? this.optionSet,
      code: code ?? this.code,
      name: name ?? this.name,
      label: label ?? this.label,
      deleted: deleted ?? this.deleted,
      order: order ?? this.order,
      listName: listName ?? this.listName,
      filterExpression: filterExpression ?? this.filterExpression,
      properties: properties ?? this.properties,
    );
  }
}
