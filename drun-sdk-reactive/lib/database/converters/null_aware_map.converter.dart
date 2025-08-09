import 'dart:convert';

import 'package:drift/drift.dart';

/// Converter for Map<String, Object?> (properties) <-> JSON String.
class NullAwareMapConverter<T>
    extends NullAwareTypeConverter<Map<String, T>, String> {
  const NullAwareMapConverter();

  @override
  Map<String, T> requireFromSql(String fromDb) {
    return Map<String, T>.from(jsonDecode(fromDb));
  }

  @override
  String requireToSql(Map<String, T> value) {
    return jsonEncode(value);
  }
}
