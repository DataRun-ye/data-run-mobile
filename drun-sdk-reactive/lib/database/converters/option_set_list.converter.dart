import 'dart:convert';

import 'package:d_sdk/database/shared/shared.dart';
import 'package:drift/drift.dart';

/// Converts a List<DOptionSet> to/from a JSON String.
class DOptionSetListConverter extends TypeConverter<List<DOptionSet>, String> {
  const DOptionSetListConverter();

  @override
  List<DOptionSet> fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.map((json) => DOptionSet.fromJson(json)).toList();
  }

  @override
  String toSql(List<DOptionSet>? value) {
    value ??= [];
    final listJson = value.map((optionSet) => optionSet.toJson()).toList();
    return jsonEncode(listJson);
  }
}
