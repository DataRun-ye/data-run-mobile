// import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
// import 'package:d_sdk/core/form/element_template/section_template.entity.dart';
// import 'package:d_sdk/core/form/element_template/template.dart';
// import 'package:d_sdk/core/form/tree/element_tree_service.dart';
// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:d_sdk/core/utilities/list_extensions.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/shared/assignment_status.dart';
// import 'package:d_sdk/database/shared/value_type.dart';
// import 'package:d_sdk/datasource/util/field_value.dart';
// import 'package:d_sdk/datasource/util/submission_aggregator.dart';
// import 'package:injectable/injectable.dart';
// import 'package:intl/intl.dart';
//
// @Injectable(as: SubmissionAggregator)
// class DetailSubmissionsTableService implements SubmissionAggregator {
//   @override
//   Map<String, FieldValue> extractValues(
//       Map<String, dynamic> formData, List<Template> fields,
//       {Map<String, List<DataOption>> optionMap = const {}}) {
//     Map<String, FieldValue> extractedValues = {};
//
//     void _extract(Map<String, dynamic> data, Iterable<Template> fields) {
//       fields.forEach((Template field) {
//         if (field.name != null) {
//           try {
//             if (field is SectionTemplate && data.containsKey(field.name)) {
//               if (field.repeatable && data[field.name] is List) {
//                 final items = data[field.name]
//                     .map<Map<String, dynamic>>(
//                         (item) => Map<String, dynamic>.of(item))
//                     .toList();
//                 _extract(_sumNumericResources(items), field.children);
//               } else {
//                 _extract(
//                     data[field.name],
//                     ElementTreeService.getImmediateChildren(
//                         field.path, field.children));
//               }
//             } else if (field.type ==
//                     ValueType
//                         .Progress /* &&
//                 data.containsKey(field.name)*/
//                 ) {
//               final value = ((AssignmentStatus.values
//                           .firstOrNullWhere((t) => t.name == data[field.name])
//                           ?.name ??
//                       data[field.name])
//                   ?.toString());
//               extractedValues[field.name!] =
//                   value != null ? Intl.message(value.toLowerCase()) : '-';
//               FieldValue fieldValue = FieldValue(
//                 id: field.id,
//                 name: field.name!,
//                 valueType: field.type!,
//                 label: field.label.unlock,
//                 value:
//               );
//             }
//             /*else if (field.type == ValueType.Team &&
//               data.containsKey(field.name)) {
//             extractedValues[field.name!] = activityModel.managedTeams
//                     .firstOrNullWhere((t) => t.id == data[field.name])
//                     ?.name ??
//                 data[field.name];
//           }*/
//             else if (field.type?.isSelectType == true &&
//                 field.optionSet != null &&
//                 data.containsKey(field.name)) {
//               final List<DataOption> options = optionMap[field.optionSet] ?? [];
//               if (field.type == ValueType.SelectOne) {
//                 final List<DataOption> selected =
//                     options.where((o) => o.name == data[field.name]).toList();
//                 extractedValues[field.name!] = selected
//                     .map((o) => getItemLocalString(o.label, defaultString: ''))
//                     .join(',');
//               } else if (field.type == ValueType.SelectMulti &&
//                   data[field.name] is List) {
//                 final List<DataOption> selected = options
//                     .where((o) => data[field.name].contains(o.code))
//                     .toList();
//                 extractedValues[field.name!] = selected
//                     .map((o) => getItemLocalString(o.label, defaultString: ''))
//                     .join(',');
//               }
//             } else if (data.containsKey(field.name)) {
//               extractedValues[field.name!] = data[field.name];
//             }
//           } catch (e) {
//             logError('error extracting field: ${field.name} value', source: e);
//           }
//         }
//       });
//     }
//
//     _extract(formData, fields.where((f) => f.mainField == true));
//     return extractedValues;
//   }
//
//   static Map<String, double> _sumNumericResources(
//       List<Map<String, dynamic>> formData) {
//     Map<String, double> subTotals = {};
//
//     void _sumResources(Map<String, dynamic> data) {
//       data.forEach((key, value) {
//         if (value is num) {
//           subTotals[key] = (subTotals[key] ?? 0) + value.toDouble();
//         } else if (value is Map<String, dynamic>) {
//           _sumResources(value);
//         } else if (value is List) {
//           value.forEach((element) {
//             if (element is Map<String, dynamic>) {
//               _sumResources(element);
//             }
//           });
//         }
//       });
//     }
//
//     for (var formData in formData) {
//       _sumResources(formData);
//     }
//
//     // _sumResources(formData);
//     return subTotals;
//   }
// }
