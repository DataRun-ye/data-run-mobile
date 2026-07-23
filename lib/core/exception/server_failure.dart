final class ServerFailure {
  const ServerFailure._({
    this.code,
    this.arguments = const [],
    this.detail,
    this.traceId,
  });

  factory ServerFailure.fromResponseData(Object? data) {
    final parsed = _parse(data);
    return ServerFailure._(
      code: parsed.code,
      arguments: parsed.arguments,
      detail: parsed.detail,
      traceId: parsed.traceId,
    );
  }

  final String? code;
  final List<Object?> arguments;
  final String? detail;
  final String? traceId;

  bool get isEmpty =>
      code == null && arguments.isEmpty && detail == null && traceId == null;

  Map<String, Object?> toJson() => {
        if (code != null) 'code': code,
        if (arguments.isNotEmpty) 'args': arguments,
        if (detail != null) 'detail': detail,
        if (traceId != null) 'traceId': traceId,
      };

  static _ParsedServerFailure _parse(Object? data) {
    if (data is String) {
      return _ParsedServerFailure(detail: _clean(data, maxLength: 300));
    }

    if (data is! Map) {
      return const _ParsedServerFailure();
    }

    final nested = _parse(data['error']);
    return _ParsedServerFailure(
      code: _cleanValue(data['code'] ?? data['error_code'], maxLength: 80) ??
          nested.code,
      arguments: _parseArguments(data['args']) ?? nested.arguments,
      detail: _firstCleanString(
            data,
            const ['detail', 'message', 'title'],
            maxLength: 300,
          ) ??
          nested.detail,
      traceId: _firstCleanString(
            data,
            const ['traceId', 'trace_id', 'requestId', 'request_id'],
            maxLength: 120,
          ) ??
          nested.traceId,
    );
  }

  static List<Object?>? _parseArguments(Object? value) {
    if (value == null) return null;
    if (value is List) return List<Object?>.unmodifiable(value);
    return List<Object?>.unmodifiable([value]);
  }

  static String? _firstCleanString(
    Map<dynamic, dynamic> data,
    List<String> keys, {
    required int maxLength,
  }) {
    for (final key in keys) {
      final value = _cleanValue(data[key], maxLength: maxLength);
      if (value != null) return value;
    }
    return null;
  }

  static String? _cleanValue(Object? value, {required int maxLength}) =>
      value is String ? _clean(value, maxLength: maxLength) : null;

  static String? _clean(String value, {required int maxLength}) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return trimmed.length > maxLength
        ? trimmed.substring(0, maxLength)
        : trimmed;
  }
}

final class _ParsedServerFailure {
  const _ParsedServerFailure({
    this.code,
    this.arguments = const [],
    this.detail,
    this.traceId,
  });

  final String? code;
  final List<Object?> arguments;
  final String? detail;
  final String? traceId;
}
