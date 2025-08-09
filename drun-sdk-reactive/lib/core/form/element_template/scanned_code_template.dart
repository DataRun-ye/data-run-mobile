// import 'dart:convert';
//
// import 'package:d_sdk/modules/datarun/form/shared/element_template/element_template.entity.dart';
// import 'package:d_sdk/modules/datarun/form/shared/element_template/scanned_code_properties.dart';
// import 'package:d_sdk/modules/datarun/form/shared/metadata_resource_type.dart';
// import 'package:d_sdk/modules/datarun/form/shared/rule/rule.dart';
// import 'package:d_sdk/database/shared/value_type.dart';
// import 'package:d_sdk/modules/datarun_shared/utilities/parsing_helpers.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
//
// class ScannedCodeTemplate extends FieldTemplate {
//   final bool gs1Enabled;
//   final ScannedCodeProperties? scannedCodeProperties;
//
//   ScannedCodeTemplate({
//     required super.path,
//     required super.name,
//     super.order = 0,
//     super.resourceType,
//     super.resourceMetadataSchema,
//     super.defaultValue,
//     super.type = ValueType.Calculated,
//     super.parent,
//     super.rules,
//     super.label = const IMap.empty(),
//     super.properties,
//     super.mandatory,
//     super.mainField,
//     super.constraint,
//     super.constraintMessage,
//     this.scannedCodeProperties,
//     this.gs1Enabled = false,
//   });
//
//   @override
//   List<Object?> get props => super.props + [scannedCodeProperties];
//
//   factory ScannedCodeTemplate.fromJson(Map<String, dynamic> json) {
//     final valueType = ValueType.getValueType(json['type']);
//
//     final resourceType = json['resourceType'] != null
//         ? MetadataResourceType.getType(json['resourceType'])
//         : null;
//
//     final rules = json['rules'] != null
//         ? (parseDynamicJson(json['rules']) as List)
//             .map<Rule>((ruleField) =>
//                 Rule.fromJson({...ruleField, 'field': json['name']}))
//             .toList()
//         : <Rule>[];
//
//     final label = json['label'] != null
//         ? Map<String, String?>.from(
//             json['label'] is String ? jsonDecode(json['label']) : json['label'])
//         : <String, String?>{};
//
//     final properties = json['properties'] != null
//         ? Map<String, dynamic>.from(json['properties'] is String
//             ? jsonDecode(json['properties'])
//             : json['properties'])
//         : <String, dynamic>{};
//
//     final constraintMessage = json['constraintMessage'] != null
//         ? Map<String, String>.from(json['constraintMessage'] is String
//             ? jsonDecode(json['constraintMessage'])
//             : json['constraintMessage'])
//         : <String, String>{};
//
//     return ScannedCodeTemplate(
//       type: valueType,
//       name: json['name'],
//       path: json['path'],
//       order: json['order'] ?? 0,
//       mandatory: json['mandatory'] ?? false,
//       mainField: json['mainField'] ?? false,
//       rules: rules,
//       label: label.lock,
//       properties: properties.lock,
//       parent: json['section'],
//       resourceType: resourceType,
//       resourceMetadataSchema: json['resourceMetadataSchema'],
//       scannedCodeProperties: json['scannedCodeProperties'],
//       defaultValue: json['defaultValue'] != null
//           ? json['defaultValue'] is String
//               ? json['defaultValue']
//               : json['defaultValue'] as String
//           : null,
//       constraint: json['constraint'],
//       constraintMessage: constraintMessage.lock,
//       gs1Enabled: json['gs1Enabled'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'path': path,
//       'name': name,
//       'type': type?.name,
//       'order': order,
//       'defaultValue': defaultValue,
//       'resourceType': resourceType?.name,
//       'resourceMetadataSchema': resourceMetadataSchema,
//       'scannedCodeProperties': scannedCodeProperties?.toJson() != null
//           ? jsonEncode(scannedCodeProperties!.toJson())
//           : null,
//       'rules':
//           jsonEncode(rules.unlockView.map((rule) => rule.toJson()).toList()),
//       'label': jsonEncode(label.unlock),
//       'properties': jsonEncode(properties?.unlock),
//       'constraint': constraint,
//       'constraintMessage': constraintMessage != null
//           ? jsonEncode(constraintMessage!.unlockView)
//           : null,
//       'gs1Enabled': gs1Enabled,
//     };
//   }
// }
