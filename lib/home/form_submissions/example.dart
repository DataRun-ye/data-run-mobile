// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// // Example JSON schema for a Daily Task form
// const String formSchemaJson = '''
// {
//     "formId": "itnDailyForm_v3",
//     "title": "ITN Distribution - Daily Report",
//     "fields": [
//         {
//             "fieldId": "householdsVisited",
//             "type": "integer",
//             "label": "Households Visited",
//             "validation": {
//                 "required": true,
//                 "min": 1
//             }
//         },
//         {
//             "fieldId": "netsDistributed",
//             "type": "integer",
//             "label": "Nets Distributed",
//             "validation": {
//                 "required": true,
//                 "min": 0
//             }
//         },
//         {
//             "fieldId": "comments",
//             "type": "text",
//             "label": "Comments",
//             "validation": {
//                 "required": false,
//                 "maxLength": 250
//             }
//         }
//     ]
// }
// ''';
//
// // Model classes
// class FormFieldSchema {
//   final String fieldId;
//   final String type;
//   final String label;
//   final Map<String, dynamic> validation;
//
//   FormFieldSchema({
//     required this.fieldId,
//     required this.type,
//     required this.label,
//     required this.validation,
//   });
//
//   factory FormFieldSchema.fromJson(Map<String, dynamic> json) {
//     return FormFieldSchema(
//       fieldId: json['fieldId'],
//       type: json['type'],
//       label: json['label'],
//       validation: json['validation'] ?? {},
//     );
//   }
// }
//
// class FormSchema {
//   final String formId;
//   final String title;
//   final List<FormFieldSchema> fields;
//
//   FormSchema({required this.formId, required this.title, required this.fields});
//
//   factory FormSchema.fromJson(String jsonStr) {
//     final Map<String, dynamic> data = json.decode(jsonStr);
//     final fields = (data['fields'] as List)
//         .map((f) => FormFieldSchema.fromJson(f))
//         .toList();
//     return FormSchema(
//       formId: data['formId'],
//       title: data['title'],
//       fields: fields,
//     );
//   }
// }
//
// // Dynamic form widget
// class DynamicForm extends StatefulWidget {
//   final FormSchema schema;
//   final void Function(Map<String, dynamic> values) onSubmit;
//
//   const DynamicForm({required this.schema, required this.onSubmit, Key? key})
//       : super(key: key);
//
//   @override
//   _DynamicFormState createState() => _DynamicFormState();
// }
//
// class _DynamicFormState extends State<DynamicForm> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, dynamic> _values = {};
//
//   @override
//   void initState() {
//     super.initState();
// // Initialize default values
//     for (var field in widget.schema.fields) {
//       _values[field.fieldId] = null;
//     }
//   }
//
//   Widget _buildField(FormFieldSchema field) {
//     switch (field.type) {
//       case 'integer':
//         return TextFormField(
//           decoration: InputDecoration(labelText: field.label),
//           keyboardType: TextInputType.number,
//           validator: (v) {
//             if (field.validation['required'] == true &&
//                 (v == null || v.isEmpty)) {
//               return 'Required';
//             }
//             final num? value = num.tryParse(v ?? '');
//             if (value == null) return 'Invalid number';
//             if (field.validation.containsKey('min') &&
//                 value < field.validation['min']) {
//               return 'Must be ≥ ${field.validation['min']}';
//             }
//             return null;
//           },
//           onSaved: (v) => _values[field.fieldId] = int.tryParse(v ?? ''),
//         );
//
//       case 'text':
//       default:
//         return TextFormField(
//           decoration: InputDecoration(labelText: field.label),
//           maxLength: field.validation['maxLength'],
//           validator: (v) {
//             if (field.validation['required'] == true &&
//                 (v == null || v.isEmpty)) {
//               return 'Required';
//             }
//             return null;
//           },
//           onSaved: (v) => _values[field.fieldId] = v,
//         );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.schema.title)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               ...widget.schema.fields.map(_buildField).toList(),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     widget.onSubmit(_values);
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Usage example in your app
// class DailyFormPage extends StatelessWidget {
//   const DailyFormPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final schema = FormSchema.fromJson(formSchemaJson);
//     return DynamicForm(
//       schema: schema,
//       onSubmit: (values) {
// // Send values to backend: include metadata (activityInstanceId, taskId, userId)
//         print('Submitted values: $values');
//       },
//     );
//   }
// }
