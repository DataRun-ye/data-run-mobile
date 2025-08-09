import 'dart:convert';

import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:drift/drift.dart';

/// Converts a List<User> tree to/from a JSON String.
class TeamUsersConverter extends TypeConverter<List<User>, String> {
  const TeamUsersConverter();

  @override
  List<User> fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.map((json) => User.fromJson(json)).toList();
  }

  @override
  String toSql(List<User>? value) {
    value ??= [];
    final listJson =
        value.map((t) => t.toJson(serializer: CustomSerializer())).toList();
    return jsonEncode(listJson);
  }
}
