import 'dart:convert';

import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:drift/drift.dart';

/// Converts a List<FormOption> to/from a JSON String.
class FormOptionListConverter extends TypeConverter<List<FormOption>?, String?> {
  const FormOptionListConverter();

  @override
  List<FormOption>? fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.map((json) => FormOption.fromJson(json)).toList();
  }

  @override
  String? toSql(List<FormOption>? value) {
    value ??= [];
    final listJson = value.map((option) => option.toJson()).toList();
    return jsonEncode(listJson);
  }
}
