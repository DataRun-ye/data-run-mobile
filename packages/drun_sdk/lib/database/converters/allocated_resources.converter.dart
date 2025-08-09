import 'dart:convert';

import 'package:drift/drift.dart';

/// Converter for allocatedResources: Map<String, Object?> <-> JSON String
class AllocatedResourcesConverter
    extends TypeConverter<Map<String, dynamic>, String> {
  const AllocatedResourcesConverter();

  @override
  Map<String, dynamic> fromSql(String? fromDb) {
    if (fromDb == null) return {};
    return Map<String, dynamic>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(Map<String, dynamic>? resources) {
    resources ??= {};
    return jsonEncode(resources);
  }
}
