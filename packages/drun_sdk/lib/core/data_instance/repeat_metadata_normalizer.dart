import 'package:d_sdk/core/code_generator.dart';

class RepeatMetadataNormalizer {
  static const String idKey = '_id';
  static const String legacyUidKey = '_uid';
  static const String legacyRepeatUidKey = 'repeatUid';
  static const String indexKey = '_index';
  static const String parentIdKey = '_parentId';
  static const String submissionUidKey = '_submissionUid';

  static Map<String, dynamic> normalizeFormData(
    Map<String, dynamic> formData, {
    required String submissionUid,
  }) {
    return _normalizeMap(
      formData,
      submissionUid: submissionUid,
      parentRepeatId: null,
    );
  }

  static String? readRepeatRowId(Map<dynamic, dynamic>? row) {
    if (row == null) {
      return null;
    }

    return _nonBlankString(row[idKey]) ??
        _nonBlankString(row[legacyUidKey]) ??
        _nonBlankString(row[legacyRepeatUidKey]);
  }

  static Map<String, dynamic> _normalizeMap(
    Map<dynamic, dynamic> source, {
    required String submissionUid,
    required String? parentRepeatId,
  }) {
    final result = <String, dynamic>{};

    source.forEach((key, value) {
      if (key is String) {
        result[key] = _normalizeValue(
          value,
          submissionUid: submissionUid,
          parentRepeatId: parentRepeatId,
        );
      }
    });

    return result;
  }

  static dynamic _normalizeValue(
    Object? value, {
    required String submissionUid,
    required String? parentRepeatId,
  }) {
    if (value is Map) {
      return _normalizeMap(
        value,
        submissionUid: submissionUid,
        parentRepeatId: parentRepeatId,
      );
    }

    if (value is List) {
      return _normalizeList(
        value,
        submissionUid: submissionUid,
        parentRepeatId: parentRepeatId,
      );
    }

    return value;
  }

  static List<dynamic> _normalizeList(
    List<dynamic> source, {
    required String submissionUid,
    required String? parentRepeatId,
  }) {
    return [
      for (var index = 0; index < source.length; index++)
        if (source[index] is Map)
          _normalizeRepeatRow(
            source[index] as Map,
            submissionUid: submissionUid,
            parentRepeatId: parentRepeatId,
            rowIndex: index + 1,
          )
        else
          source[index],
    ];
  }

  static Map<String, dynamic> _normalizeRepeatRow(
    Map<dynamic, dynamic> source, {
    required String submissionUid,
    required String? parentRepeatId,
    required int rowIndex,
  }) {
    final rowId = readRepeatRowId(source) ?? CodeGenerator.generateUlid();
    final result = <String, dynamic>{};

    source.forEach((key, value) {
      if (key is String) {
        result[key] = _normalizeValue(
          value,
          submissionUid: submissionUid,
          parentRepeatId: rowId,
        );
      }
    });

    result[idKey] = rowId;
    result[indexKey] = result[indexKey] ?? rowIndex;
    result[parentIdKey] =
        _nonBlankString(result[parentIdKey]) ?? parentRepeatId ?? submissionUid;
    result[submissionUidKey] =
        _nonBlankString(result[submissionUidKey]) ?? submissionUid;

    return result;
  }

  static String? _nonBlankString(Object? value) {
    if (value == null) {
      return null;
    }

    final text = value.toString();
    return text.trim().isEmpty ? null : text;
  }
}
