// import 'package:d2_remote/d2_remote.dart';
// import 'package:d2_remote/modules/datarun/data_value/entities/data_value.entity.dart';
// import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';
// import 'package:datarunmobile/core/exceptions/invalid_template_exception.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
//
// class SubmissionDataRepository {
//   SubmissionDataRepository(
//       {required this.submission, required this.formFlatTemplate});
//
//   final String submission;
//   final FormFlatTemplate formFlatTemplate;
//
//   Future<SectionState> loadSection(String path) async {
//     final template = formFlatTemplate.getTemplateByPath(path);
//     if (template is! SectionElementTemplate) {
//       throw new InvalidTemplateException(
//           'Template at the path is not a SectionTemplate: $path');
//     }
//     template
//   }
//
//   Map<String, dynamic> generateSubmissionMap(String formTemplateUid) {
//     // Query all DataValues for the formTemplateUid
//     final List<DataValue> dataValues = queryDataValues(formTemplateUid);
//
//     final submissionMap = <String, dynamic>{};
//     for (var value in dataValues) {
//       if (value.parent != null) {
//         // Handle repeatable sections
//         submissionMap
//             .putIfAbsent(value.templatePath, () => [])
//             .add(_createRow(value.parent, value));
//       } else {
//         // Handle single-instance fields
//         submissionMap[value.dataElement] = value.value;
//       }
//     }
//     return submissionMap;
//   }
//
//   List<DataValue> queryDataValues(String formTemplateUid) {
//     return D2Remote.formSubmissionModule.dataValue.where(
//         attribute: 'attribute', value: value)
//   }
// }
