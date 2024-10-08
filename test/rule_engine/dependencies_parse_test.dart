import 'package:d2_remote/modules/datarun/form/shared/dynamic_form_field.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule_parse_extension.dart';


import 'form.sample.dart';

void main() {
  final List<Map<String, dynamic>> samples = formSample;
  final List<FieldTemplate> templates = [];

  final Map<String, List<String>> dep = {};
  for (final sample in samples) {
    final FieldTemplate field = FieldTemplate.fromJson(sample);
    dep[field.name] = field.dependencies;
    templates.add(field);
  }

  print(dep);

}