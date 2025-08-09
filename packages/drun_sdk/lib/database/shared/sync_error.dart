import 'package:d_sdk/core/util/list_extensions.dart';

enum SyncStage {
  fetch,
  fetchExtra,
  mapping,
  unexpected,
  databaseWrite,
}

class SyncError {
  SyncError({required this.type, required this.message, this.extra});

  final SyncStage type;
  final String message;
  final Map<String, dynamic>? extra;

  SyncError copyWith({
    SyncStage? type,
    String? message,
    Map<String, dynamic>? extra,
  }) {
    return SyncError(
      type: type ?? this.type,
      message: message ?? this.message,
      extra: extra ?? this.extra,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': this.type.name,
      'message': this.message,
      'extra': this.extra,
    };
  }

  factory SyncError.fromJson(Map<String, dynamic> map) {
    final type = SyncStage.values
            .firstOrNullWhere((type) => type.name == map['type']) ??
        SyncStage.unexpected;
    return SyncError(
      type: type,
      message: map['message'] as String,
      extra: map['extra'],
    );
  }
}
