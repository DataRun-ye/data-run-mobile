import 'dart:convert';

import 'package:drift/drift.dart';

/// Converter for forms: List<String> <-> JSON String
class ListConverter<T> extends TypeConverter<List<T>, String> {
  const ListConverter();

  @override
  List<T> fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return List<T>.from(decoded);
  }

  @override
  String toSql(List<T>? forms) {
    forms ??= [];
    return jsonEncode(forms);
  }
}
