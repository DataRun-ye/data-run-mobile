import 'dart:convert';

import 'package:d_sdk/database/shared/party/party_set_spec.dart';
import 'package:drift/drift.dart';

/// Converter for ScannedCodeProperties <-> String (assumes a toJson/fromJson API)
class PartySetSpecConverter extends TypeConverter<PartySetSpec?, String?>
    with JsonTypeConverter2<PartySetSpec?, String?, Map<String, Object?>?> {
  const PartySetSpecConverter();

  @override
  PartySetSpec? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return fromJson(Map<String, dynamic>.of(json.decode(fromDb)));
  }

  @override
  String? toSql(PartySetSpec? value) {
    if (value == null) return null;
    return json.encode(toJson(value));
  }

  @override
  PartySetSpec? fromJson(Map<String, Object?>? json) {
    if (json == null) return null;
    return PartySetSpec.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PartySetSpec? value) {
    return value?.toJson();
  }
}
