import 'dart:convert';

import 'package:d_sdk/database/shared/sync_error.dart';
import 'package:drift/drift.dart';

/// Converts a List<SyncError>.
class SyncErrorListConverter extends TypeConverter<List<SyncError>, String> {
  const SyncErrorListConverter();

  @override
  List<SyncError> fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.map((json) => SyncError.fromJson(json)).toList();
  }

  @override
  String toSql(List<SyncError>? value) {
    value ??= [];
    final listJson = value.map((t) => t.toJson()).toList();
    return jsonEncode(listJson);
  }
}
