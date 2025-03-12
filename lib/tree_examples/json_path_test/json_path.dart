//
// import 'package:json_path/json_path.dart';
// import 'package:datarunmobile/tree_examples/json_path_test/form_template_json_sample.dart';
//
// void main() {
//     final rules = JsonPath(r'$..rules');
//   final names = JsonPath(r'$..name');
//
//   print('All rules in the store:');
//
//   final formRules = rules.read(formSampleForJsonPath);
//   final formNames = names.read(formSampleForJsonPath);
//
//   Map<String, dynamic> allRules = {};
//   Map<String, dynamic> allNames = {};
//
//   for (final match in formRules) {
//     allRules[match.path] = match.value;
//     print('${match.path}:\t${match.value}');
//   }
//
//   for (final match in formNames) {
//     allNames[match.path] = match.value;
//     print('${match.path}:\t${match.value}');
//   }
//
//   print('\nExpressions: $formRules');
// }
