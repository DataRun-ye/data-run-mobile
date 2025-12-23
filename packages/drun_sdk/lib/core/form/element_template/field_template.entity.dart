import 'dart:convert';

import 'package:d_sdk/core/form/attribute_type.dart';
import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/data_instance/form_data_aggregator.dart';
import 'package:d_sdk/core/form/rule/rule.dart';
import 'package:d_sdk/core/form/rule/validation_rule.dart';
import 'package:d_sdk/core/form/value_type_rendering_type.dart';
import 'package:d_sdk/core/util/list_extensions.dart';
import 'package:d_sdk/core/util/parsing_helpers.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FieldTemplate extends Template {
  final String id;
  final String? description;
  final String? path;
  final String? parent;

  final String? code;
  final String? name;
  final int order;

  final ValueType type;

  final String? listName;
  final String? optionSet;
  final bool mandatory;
  final bool readOnly;

  @Deprecated('Use showInSummary instead')
  final bool mainField;

  final bool showInSummary;
  final String? choiceFilter;
  final dynamic defaultValue;

  final IMap<String, dynamic> label;

  final IMap<String, dynamic> properties;

  final IList<Rule> rules;
  final ValidationRule? validationRule;
  final IList<FormOption> options;

  final String? calculation;

  final AttributeType? attributeType;
  final ScannedCodeProperties? scannedCodeProperties;
  final IList<String> appearance;
  final bool gs1Enabled;

  /// references to other entities
  final MetadataResourceType? resourceType;
  final String? resourceMetadataSchema;
  final IList<String> displayAttributes;
  final Aggregation? aggregation;

  @override
  bool get repeatable => false;

  final ValueTypeRenderingType valueTypeRendering;

  FieldTemplate({
    required this.id,
    this.code,
    this.description,
    this.path,
    this.parent,
    this.mandatory = false,
    this.mainField = false,
    this.showInSummary = false,
    this.readOnly = false,
    this.order = 0,
    this.listName,
    this.optionSet,
    this.name,
    required this.type,
    this.valueTypeRendering = ValueTypeRenderingType.DEFAULT,
    this.resourceType,
    this.resourceMetadataSchema,
    this.choiceFilter,
    this.calculation,
    this.defaultValue,
    this.attributeType,
    this.gs1Enabled = false,
    this.validationRule,
    this.aggregation,
    Iterable<Rule>? rules,
    Iterable<FormOption>? options,
    Iterable<String>? appearance,
    Iterable<String>? displayAttributes,
    this.label = const IMap.empty(),
    this.properties = const IMapConst({}),
    this.scannedCodeProperties,
  })  : this.options = IList.orNull(options) ?? const IList<FormOption>.empty(),
        this.rules = IList.orNull(rules) ?? const IList<Rule>.empty(),
        this.appearance =
            IList.orNull(appearance) ?? const IList<String>.empty(),
        this.displayAttributes =
            IList.orNull(displayAttributes) ?? const IList<String>.empty();

  @override
  List<Object?> get props => [
        optionSet,
        parent,
        readOnly,
        listName,
        calculation,
        resourceType,
        resourceMetadataSchema,
        choiceFilter,
        defaultValue,
        appearance,
        aggregation
      ];

  factory FieldTemplate.fromJson(Map<String, dynamic> json) {
    final valueType = ValueType.getValueType(json['type']);
    if (valueType == null) {
      throw ArgumentError('Invalid value type: $valueType');
    }

    final valueTypeRendering =
        ValueTypeRenderingType.valueOf(json['valueTypeRendering']);

    final aggregation = Aggregation.values
            .firstOrNullWhere((value) => value.name == json['aggregation']) ??
        Template.getDefaultAggregation(valueType);

    final resourceType = json['resourceType'] != null
        ? MetadataResourceType.getType(json['resourceType'])
        : null;

    final rules = json['rules'] != null
        ? (parseDynamicJson(json['rules']) as List)
            .map<Rule>((ruleField) =>
                Rule.fromJson({...ruleField, 'field': json['name']}))
            .toList()
        : <Rule>[];

    final optionMap = json['optionMap'] != null
        ? Map<String, List<FormOption>>.from(json['optionMap'] is String
            ? jsonDecode(json['optionMap'])
            : json['optionMap'])
        : <String, List<FormOption>>{};

    final listName = json['listName'];

    final options = optionMap[listName] ?? [];

    final label = json['label'] != null
        ? Map<String, String?>.from(
            json['label'] is String ? jsonDecode(json['label']) : json['label'])
        : <String, String?>{};

    final validation = json['validationRule'];
    final validationRule = json['validationRule'] != null
        ? ValidationRule.fromJson({...validation, 'field': json['name']})
        : null;

    final properties = json['properties'] != null
        ? Map<String, dynamic>.from(json['properties'] is String
            ? jsonDecode(json['properties'])
            : json['properties'])
        : <String, dynamic>{};

    final appearance = json['appearance'] != null
        ? json['appearance'].runtimeType == String
            ? jsonDecode(json['appearance']).cast<String>()
            : json['appearance'].cast<String>()
        : null;

    final displayAttributes = json['displayAttributes'] != null
        ? json['displayAttributes'].runtimeType == String
            ? jsonDecode(json['displayAttributes']).cast<String>()
            : json['displayAttributes'].cast<String>()
        : null;

    return FieldTemplate(
      type: valueType,
      attributeType: AttributeType.getAttributeType(json['attributeType']),
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      options: options,
      displayAttributes: displayAttributes,
      path: json['path'],
      order: json['order'] ?? 0,
      mandatory: json['mandatory'] ?? false,
      mainField: json['mainField'] ?? false,
      // showInSummary: json['showInSummary'] ?? false,
      readOnly: json['readOnly'] ?? false,
      gs1Enabled: json['gs1Enabled'] ?? false,
      listName: json['listName'],
      optionSet: json['optionSet'],
      choiceFilter: json['choiceFilter'],
      calculation: json['calculation'],
      rules: rules,
      validationRule: validationRule,
      label: label.lock,
      properties: properties.lock,
      parent: json['parent'],
      resourceType: resourceType,
      resourceMetadataSchema: json['resourceMetadataSchema'],
      valueTypeRendering: valueTypeRendering,
      defaultValue: json['defaultValue'] != null
          ? json['defaultValue'] is String
              ? json['defaultValue']
              : json['defaultValue'] as String
          : null,
      scannedCodeProperties: json['scannedCodeProperties'],
      appearance: appearance,
      aggregation: aggregation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'type': type.name,
      'resourceType': resourceType?.name,
      'order': order,
      'path': path,
      'name': name,
      'description': description,
      'options': options.unlockView.map((option) => option.toJson()).toList(),
      'mandatory': mandatory,
      'readOnly': readOnly,
      'mainField': mainField,
      'showInSummary': showInSummary,
      'listName': listName,
      'optionSet': optionSet,
      'choiceFilter': choiceFilter,
      'calculation': calculation,
      'defaultValue': defaultValue,
      'valueTypeRendering': valueTypeRendering.name,
      'resourceMetadataSchema': resourceMetadataSchema,
      'rules': rules.unlockView.map((rule) => rule.toJson()).toList(),
      'validationRule': validationRule?.toJson(),
      'label': label.unlockView,
      // 'constraint': constraint,
      // 'constraintMessage': constraintMessage!.unlockView,
      'properties': properties.unlockView,
      'parent': parent,
      'appearance': appearance.unlockView,
      'aggregation': aggregation?.name,
      'scannedCodeProperties': scannedCodeProperties?.toJson(),
    };
  }

  @override
  String get displayName =>
      getItemLocalString(label.unlockView, defaultString: name);
}
