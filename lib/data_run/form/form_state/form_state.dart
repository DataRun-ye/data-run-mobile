// import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
// import 'package:datarun/data_run/screens/form_module/form/code_generator.dart';
// import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
//
// //<editor-fold desc="Template">
// class FormTemplate {
//   final List<FieldTemplate> fields;
//
//   FormTemplate({required this.fields});
//
//   factory FormTemplate.fromJson(Map<String, dynamic> json) {
//     return FormTemplate(
//       fields: (json['fields'] as List)
//           .map((field) => FieldTemplate.fromJson(field))
//           .toList(),
//     );
//   }
// }
//
// class FieldTemplate {
//   final String name;
//   final String type;
//   final String path;
//   final List<FieldTemplate>? fields;
//   final List<Rule>? rules;
//   final Map<String, dynamic>? properties;
//
//   FieldTemplate({
//     required this.name,
//     required this.type,
//     required this.path,
//     this.fields,
//     this.rules,
//     this.properties,
//   });
//
//   factory FieldTemplate.fromJson(Map<String, dynamic> json) {
//     return FieldTemplate(
//       name: json['name'],
//       type: json['type'],
//       path: json['path'],
//       fields: json['fields'] != null
//           ? (json['fields'] as List)
//               .map((field) => FieldTemplate.fromJson(field))
//               .toList()
//           : null,
//       rules: json['rules'] != null
//           ? (json['rules'] as List).map((rule) => Rule.fromJson(rule)).toList()
//           : null,
//       properties: json['properties'],
//     );
//   }
// }
//
// class Rule {
//   final String expression;
//   final String action;
//
//   Rule({required this.expression, required this.action});
//
//   factory Rule.fromJson(Map<String, dynamic> json) {
//     return Rule(
//       expression: json['expression'],
//       action: json['action'],
//     );
//   }
// }
// //</editor-fold>
//
// //<editor-fold desc="FormState">
// class FormState {
//   final Map<String, FieldState> fields; // Flat structure with paths as keys
//
//   FormState({required this.fields});
//
//   FormState copyWith({Map<String, FieldState>? fields}) {
//     return FormState(
//       fields: fields ?? this.fields,
//     );
//   }
//
//
//   factory FormState.fromTemplate(FormFlatTemplate template) {
//     final fields = <String, FieldState>{};
//     template.fields.forEach((field) {
//       fields[field.path!] = FieldState.fromTemplate(field);
//     });
//     return FormState(fields: fields);
//   }
//
//   // factory FormState.fromTemplate(FormFlatTemplate template) {
//   //   final fields = <String, FieldState>{};
//   //   template.fields.forEach((field) {
//   //     _initializeValues(field, fields, basePath: null);
//   //   });
//   //   return FormState(fields: fields);
//   // }
//
//   static void _initializeValues(
//       FormElementTemplate template, Map<String, FieldState> fields,
//       {String? basePath}) {
//     String fullPath =
//         basePath != null ? basePath + '.' + template.name! : template.name!;
//
//     fields[fullPath] = FieldState(
//       name: template.name!,
//     );
//
//     if (template is SectionElementTemplate ||
//         template is RepeatElementTemplate) {
//       template.children.forEach((field) {
//         _initializeValues(field, fields, basePath: fullPath);
//       });
//     }
//   }
//
//   // Method to update a specific node
//   FormState updateField(String path, FieldState updatedNode) {
//     final updatedRootNodes = {...fields};
//     updatedRootNodes[path] = updatedNode;
//     return copyWith(fields: updatedRootNodes);
//   }
//
//   FormState removeItemFromRepeatSection(String path) {
//     final newFields = {...fields}..remove(path);
//     return copyWith(fields: newFields);
//   }
//
//   FormState addItemToRepeatSection(
//       {required RepeatElementTemplate template, required String uid}) {
//     ///
//     final basePath = template.path!;
//
//     final fullPath = '$basePath.$uid';
//     final newFields = Map<String, FieldState>.from(fields);
//     _initializeValues(template, newFields, basePath: fullPath);
//     return copyWith(fields: newFields);
//   }
// }
// //</editor-fold>
//
// //<editor-fold desc="FieldState">
// class FieldState {
//   final String name;
//   final dynamic value; // only for leaf fields with value
//   final bool isVisible; // New property
//   final bool hasError;
//   final Map<String, dynamic>? errors;
//
//   FieldState({
//     required this.name,
//     this.value,
//     this.isVisible = true, // Defaults to visible
//     this.hasError = false,
//     this.errors,
//   });
//
//   factory FieldState.fromTemplate(FormElementTemplate template,
//       [dynamic value]) {
//     return FieldState(name: template.name!, value: value);
//   }
//
//   FieldState copyWith({
//     dynamic value,
//     bool? isVisible,
//     bool? hasError,
//     Map<String, dynamic>? errors,
//   }) {
//     return FieldState(
//       name: name,
//       value: value ?? this.value,
//       isVisible: isVisible ?? this.isVisible,
//       hasError: hasError ?? this.hasError,
//       errors: errors ?? this.errors,
//     );
//   }
// }
//
// //</editor-fold>
//
// //<editor-fold desc="Example json Template">
// void main() {
//   final templateJson = {
//     'activity': 'fdsdsd',
//     'label': {'ar': 'flfa', 'en': 'flfa'},
//     'defaultLocal': 'ar',
//     'version': 1,
//     'fields': [
//       {'name': 'orgUnit', 'type': 'Text', 'path': 'orgUnit'},
//       {
//         'name': 'transactionInfo',
//         'type': 'Section',
//         'path': 'transactionInfo',
//         'fields': [
//           {
//             'name': 'transaction',
//             'type': 'SelectOne',
//             'listName': 'transactionTypes',
//             'path': 'transactionInfo.transaction'
//           },
//           {
//             'name': 'supplier',
//             'type': 'Text',
//             'path': 'transactionInfo.supplier',
//             'rules': [
//               {'expression': "#{transaction} == 'supply'", 'action': 'Show'}
//             ]
//           }
//         ]
//       },
//       {
//         'name': 'stockInfo',
//         'type': 'Section',
//         'path': 'stockInfo',
//         'fields': [
//           {
//             'name': 'stockDetails',
//             'type': 'RepeatableSection',
//             'referenceData': true,
//             'properties': {
//               'attributes': ['DELETE', 'ADD', 'EDIT', 'PAGINATION'],
//               'appearance': ['List', 'Table']
//             },
//             'path': 'stockInfo.stockDetails',
//             'fields': [
//               {
//                 'name': 'stockItemType',
//                 'type': 'Text',
//                 'path': 'stockInfo.stockDetails.stockItemType'
//               },
//               {
//                 'name': 'stockQuantity',
//                 'type': 'Integer',
//                 'path': 'stockInfo.stockDetails.stockQuantity'
//               }
//             ]
//           }
//         ]
//       }
//     ]
//   };
//
//   final formTemplate = FormVersion.fromJson(templateJson);
//
//   /// flat cache of the formTemplate that contains all fields in a flat structure
//   /// and provide path based queries utils and methods to traverse the tree using
//   /// materialized path
//   final FormFlatTemplate formFlatTemplate =
//       FormFlatTemplate.fromTemplate(formTemplate);
//
//   var formState = FormState.fromTemplate(formFlatTemplate);
//
//   final pathToUpdate = 'orgUnit';
//   final toUpdateFieldTemplate =
//       formFlatTemplate.getTemplateByPath(pathToUpdate);
//   if (toUpdateFieldTemplate != null) {
//     // Update a field value
//     formState = formState.updateField(pathToUpdate,
//         FieldState.fromTemplate(toUpdateFieldTemplate, 'New Value'));
//   }
//
//   final rowPathToAdd = 'stockInfo.stockDetails';
//   final rowTemplate = formFlatTemplate.getTemplateByPath(rowPathToAdd);
//
//   // Add a new repeated section instance
//   formState = formState.addItemToRepeatSection(
//     template: rowTemplate as RepeatElementTemplate,
//     uid: CodeGenerator.generateUid(),
//   );
//
//   formState = formState.addItemToRepeatSection(
//     template: rowTemplate as RepeatElementTemplate,
//     uid: CodeGenerator.generateUid(),
//   );
//   // Print the current form state
//   formState.fields.forEach((path, field) {
//     print('Path: $path, Value: ${field.value}');
//   });
//
//   print(formState.fields);
// }
