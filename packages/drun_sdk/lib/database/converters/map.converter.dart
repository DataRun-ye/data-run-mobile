import 'dart:convert';

import 'package:drift/drift.dart';

/// Converter for Map<String, Object?> (properties) <-> JSON String.
class MapConverter<T> extends TypeConverter<Map<String, T>, String> {
  const MapConverter();

  @override
  Map<String, T> fromSql(String? fromDb) {
    if (fromDb == null) return {};
    return Map<String, T>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(Map<String, T>? value) {
    value ??= {};
    return jsonEncode(value);
  }
}
