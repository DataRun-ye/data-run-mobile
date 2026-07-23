import 'dart:convert';

class ImportSummaryModel {
  ImportSummaryModel({
    required Iterable<String> created,
    required Iterable<String> updated,
    required Map<String, Object?> failed,
  })  : created = List.unmodifiable(created),
        updated = List.unmodifiable(updated),
        failed = Map.unmodifiable(failed);

  factory ImportSummaryModel.empty() {
    return ImportSummaryModel(
      created: const [],
      updated: const [],
      failed: const {},
    );
  }

  factory ImportSummaryModel.fromJson(Map<String, dynamic> json) {
    return ImportSummaryModel(
      created: _parseIds(json['created'], fieldName: 'created'),
      updated: _parseIds(json['updated'], fieldName: 'updated'),
      failed: _parseFailures(json['failed']),
    );
  }

  final List<String> created;
  final List<String> updated;
  final Map<String, Object?> failed;

  static List<String> _parseIds(
    Object? value, {
    required String fieldName,
  }) {
    if (value == null) return const [];
    if (value is String) {
      try {
        return _parseIds(jsonDecode(value), fieldName: fieldName);
      } on FormatException {
        throw FormatException('Invalid $fieldName response');
      }
    }
    if (value is! List || value.any((item) => item is! String)) {
      throw FormatException('Invalid $fieldName response');
    }
    return value.cast<String>();
  }

  static Map<String, Object?> _parseFailures(Object? value) {
    if (value == null) return const {};
    if (value is String) {
      try {
        return _parseFailures(jsonDecode(value));
      } on FormatException {
        throw const FormatException('Invalid failed response');
      }
    }
    if (value is! Map || value.keys.any((key) => key is! String)) {
      throw const FormatException('Invalid failed response');
    }
    return value.cast<String, Object?>();
  }
}
