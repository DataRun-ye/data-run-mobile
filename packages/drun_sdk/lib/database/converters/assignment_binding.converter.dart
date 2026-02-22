import 'dart:convert';

import 'package:d_sdk/database/shared/assignment_binding.dart';
import 'package:drift/drift.dart';

/// Converter for ScannedCodeProperties <-> String (assumes a toJson/fromJson API)
class AssignmentBindingConverter
    extends TypeConverter<AssignmentBinding?, String?>
    with
        JsonTypeConverter2<AssignmentBinding?, String?, Map<String, Object?>?> {
  const AssignmentBindingConverter();

  @override
  AssignmentBinding? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return fromJson(Map<String, dynamic>.of(json.decode(fromDb)));
  }

  @override
  String? toSql(AssignmentBinding? value) {
    if (value == null) return null;
    return json.encode(toJson(value));
  }

  @override
  AssignmentBinding? fromJson(Map<String, Object?>? json) {
    if (json == null) return null;
    return AssignmentBinding.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AssignmentBinding? value) {
    return value?.toJson();
  }
}
