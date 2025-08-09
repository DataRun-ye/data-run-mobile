import 'dart:convert';

import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/rule/rule.dart';
import 'package:d_sdk/core/util/parsing_helpers.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SectionTemplate extends Template {
  final String id;
  final String? code;
  final String path;
  final String? description;

  final String? name;
  final int order;

  final String? parent;

  final List<Template> children;
  final IMap<String, dynamic> label;

  final IMap<String, dynamic> properties;

  final IList<Rule> rules;

  final String? itemTitle;
  final bool readOnly;
  final bool repeatable;
  final int? maxRepeats;
  final int? minRepeats;

  SectionTemplate({
    required this.id,
    this.code,
    required this.path,
    this.name,
    this.description,
    this.order = 0,
    this.parent,
    this.itemTitle,
    this.readOnly = false,
    this.repeatable = false,
    this.maxRepeats,
    this.minRepeats,
    Iterable<Rule>? rules,
    Iterable<Template>? children,
    this.label = const IMap.empty(),
    this.properties = const IMapConst({}),
  })  : this.children = children?.toList() ?? [],
        this.rules = IList.orNull(rules) ?? const IList<Rule>.empty();

  @override
  List<Object?> get props => [parent, itemTitle, readOnly];

  @override
  String get displayName =>
      getItemLocalString(label.unlockView, defaultString: name);

  factory SectionTemplate.fromJson(Map<String, dynamic> json) {
    final rules = json['rules'] != null
        ? (parseDynamicJson(json['rules']) as List)
            .map<Rule>((ruleField) =>
                Rule.fromJson({...ruleField, 'field': json['name']}))
            .toList()
        : <Rule>[];

    final children = json['children'] != null
        ? (parseDynamicJson(json['children']) as List)
            .map<Template>((field) => Template.fromJsonFactory(field))
            .toList()
        : <Template>[];

    final label = json['label'] != null
        ? Map<String, String?>.from(
            json['label'] is String ? jsonDecode(json['label']) : json['label'])
        : <String, String?>{};

    final properties = json['properties'] != null
        ? Map<String, dynamic>.from(json['properties'] is String
            ? jsonDecode(json['properties'])
            : json['properties'])
        : <String, dynamic>{};

    return SectionTemplate(
      id: json['id'],
      code: json['code'],
      path: json['path'],
      parent: json['parent'],
      name: json['name'],
      description: json['description'],
      maxRepeats: json['maxRepeats'],
      minRepeats: json['minRepeats'],
      readOnly: json['readOnly'] ?? false,
      repeatable: json['repeatable'] ?? false,
      itemTitle: json['itemTitle'],
      order: json['order'] ?? 0,
      children: children,
      rules: rules,
      label: label.lock,
      properties: properties.lock,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'path': path,
      'parent': parent,
      'name': name,
      'description': description,
      'order': order,
      'readOnly': readOnly,
      'repeatable': repeatable,
      'maxRepeats': maxRepeats,
      'minRepeats': minRepeats,
      'children':
          children.map((field) => Template.toJsonFactory(field)).toList(),
      'rules': rules.unlockView.map((rule) => rule.toJson()).toList(),
      'label': label.unlockView,
      'properties': properties.unlockView,
    };
  }
}
