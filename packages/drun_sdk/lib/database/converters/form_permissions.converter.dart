import 'dart:convert';

import 'package:d_sdk/database/shared/form_permission.dart';
import 'package:drift/drift.dart';

/// Converts a List<Translation> to/from a JSON String.
class FormPermissionsConverter
    extends TypeConverter<List<FormPermission>, String> {
  const FormPermissionsConverter();

  @override
  List<FormPermission> fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded
        .where((t) => t != null)
        .map<FormPermission>((json) => FormPermission.getType(json)!)
        .toList();
  }

  @override
  String toSql(List<FormPermission>? value) {
    value ??= [];
    final listJson = value.map((permission) => permission.name).toList();
    return jsonEncode(listJson);
  }
}
