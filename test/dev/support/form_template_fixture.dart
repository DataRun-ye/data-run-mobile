import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';

Future<Map<String, dynamic>> readJsonMap(String path) async {
  return jsonDecode(await File(path).readAsString()) as Map<String, dynamic>;
}

FormTemplateModel formTemplateFromJson(Map<String, dynamic> json) {
  final normalized = _withTemplatePaths(json);
  return FormTemplateModel(
    id: normalized['uid'] as String? ?? normalized['id'] as String,
    name: normalized['name'] as String,
    code: normalized['code'] as String?,
    label: normalized['label'] as Map<String, dynamic>?,
    versionUid:
        normalized['versionUid'] as String? ?? normalized['uid'] as String,
    versionNumber: normalized['versionNumber'] as int? ?? 1,
    fields: BuiltList<Template>(
      (normalized['fields'] as List)
          .cast<Map<String, dynamic>>()
          .map(Template.fromJsonFactory),
    ),
    sections: BuiltList<Template>(
      (normalized['sections'] as List)
          .cast<Map<String, dynamic>>()
          .map(Template.fromJsonFactory),
    ),
    options: BuiltList<FormOption>(),
  );
}

Map<String, dynamic> _withTemplatePaths(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  final sections = (json['sections'] as List)
      .cast<Map<String, dynamic>>()
      .map(Map<String, dynamic>.from)
      .toList();
  final fields = (json['fields'] as List)
      .cast<Map<String, dynamic>>()
      .map(Map<String, dynamic>.from)
      .toList();

  final sectionById = {
    for (final section in sections) section['id'] as String: section,
  };

  String sectionPath(Map<String, dynamic> section) {
    final existingPath = section['path'] as String?;
    if (existingPath != null && existingPath.isNotEmpty) {
      return existingPath;
    }

    final parentId = section['parent'] as String?;
    final name = section['name'] as String;
    if (parentId == null || !sectionById.containsKey(parentId)) {
      return name;
    }

    return '${sectionPath(sectionById[parentId]!)}.$name';
  }

  for (final section in sections) {
    section['path'] = sectionPath(section);
  }

  for (final field in fields) {
    final parentId = field['parent'] as String?;
    final name = field['name'] as String;
    if (field['path'] == null && parentId != null) {
      field['path'] = '${sectionPath(sectionById[parentId]!)}.$name';
    }
  }

  normalized['sections'] = sections;
  normalized['fields'] = fields;
  return normalized;
}
