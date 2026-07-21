import 'dart:convert';

import 'package:d_sdk/core/form/element_template/template.dart';
import 'package:drift/drift.dart';

/// Converts a List<Template> tree to/from a JSON String.
class TemplateListConverter extends TypeConverter<List<Template>, String> {
  const TemplateListConverter();

  @override
  List<Template> fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.map((json) => Template.fromJsonFactory(json)).toList();
  }

  @override
  String toSql(List<Template>? value) {
    value ??= [];
    final listJson = value.map((t) => Template.toJsonFactory(t)).toList();
    return jsonEncode(listJson);
  }
}
