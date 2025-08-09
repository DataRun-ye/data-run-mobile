import 'dart:convert';

import 'package:drift/drift.dart';

/// Converter for forms: List<String> <-> JSON String
class NullAwareListConverter<T>
    extends NullAwareTypeConverter<List<T>, String> {
  const NullAwareListConverter();

  //
  // @override
  // List<T> fromSql(String? fromDb) {
  //   if (fromDb == null) return [];
  //   final List<dynamic> decoded = jsonDecode(fromDb);
  //   return decoded.cast<T>();
  // }
  //
  // @override
  // String toSql(List<T>? forms) {
  //   forms ??= [];
  //   return jsonEncode(forms);
  // }

  @override
  List<T> requireFromSql(String fromDb) {
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.cast<T>();
  }

  @override
  String requireToSql(List<T> value) {
    return jsonEncode(value);
  }
}
