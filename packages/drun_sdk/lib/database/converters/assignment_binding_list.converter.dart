import 'dart:convert';

import 'package:d_sdk/database/shared/assignment_binding.dart';
import 'package:drift/drift.dart';

/// Converts a List<AssignmentBinding> to/from a JSON String.
class AssignmentBindingListConverter
    extends TypeConverter<List<AssignmentBinding>?, String?> {
  const AssignmentBindingListConverter();

  @override
  List<AssignmentBinding>? fromSql(String? fromDb) {
    if (fromDb == null) return [];
    final List<dynamic> decoded = jsonDecode(fromDb);
    return decoded.map((json) => AssignmentBinding.fromJson(json)).toList();
  }

  @override
  String? toSql(List<AssignmentBinding>? value) {
    value ??= [];
    final listJson = value.map((binding) => binding.toJson()).toList();
    return jsonEncode(listJson);
  }
}
