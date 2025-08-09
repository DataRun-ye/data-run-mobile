// class CalculatedTemplate extends FieldTemplate {
//   bool get readOnly => true;
//   final String? calculation;
//
//   CalculatedTemplate({
//     required super.path,
//     required super.name,
//     super.order = 0,
//     super.resourceType,
//     super.resourceMetadataSchema,
//     super.defaultValue,
//     super.type = ValueType.Calculated,
//     this.calculation,
//     super.parent,
//     super.rules,
//     super.label = const IMap.empty(),
//     super.properties,
//   });
//
//   @override
//   List<Object?> get props => super.props + [calculation];
//
//   factory CalculatedTemplate.fromJson(Map<String, dynamic> json) {
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
//     ;
//     return CalculatedTemplate(
//         type: valueType,
//         order: json['order'] ?? 0,
//         name: json['name'],
//         path: json['path'],
//         parent: json['parent'],
//         rules: rules,
//         label: label.lock,
//         properties: properties.lock,
//         resourceType: resourceType,
//         resourceMetadataSchema: json['resourceMetadataSchema'],
//         defaultValue: json['defaultValue'] != null
//             ? json['defaultValue'] is String
//                 ? json['defaultValue']
//                 : json['defaultValue'] as String
//             : null,
//         calculation: json['calculation']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'path': path,
//       'name': name,
//       'type': type?.name,
//       'order': order,
//       'defaultValue': defaultValue,
//       'calculation': calculation,
//       'resourceType': resourceType?.name,
//       'resourceMetadataSchema': resourceMetadataSchema,
//       'rules':
//           jsonEncode(rules.unlockView.map((rule) => rule.toJson()).toList()),
//       'label': jsonEncode(label.unlock),
//       'properties': jsonEncode(properties?.unlock),
//     };
//   }
// }
