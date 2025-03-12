import 'package:collection/collection.dart';

class FormMeta {
  final Map<String, dynamic> meta;

//<editor-fold desc="Data Methods">
  const FormMeta({
    required this.meta,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormMeta &&
          runtimeType == other.runtimeType &&
          const MapEquality<dynamic, dynamic>()
              .equals(Map.unmodifiable(this.meta), other.meta));

  @override
  int get hashCode => const MapEquality().hash(meta);

  FormMeta copyWith({Map<String, dynamic>? meta}) {
    return FormMeta(
      meta: meta ?? this.meta,
    );
  }

  FormMeta add(String key, metaValue) {
    return copyWith(meta: Map.of({...meta, key: metaValue}));
  }

  Map<String, dynamic> toMap() {
    return {
      'meta': this.meta,
    };
  }

  factory FormMeta.fromMap(Map<String, dynamic> map) {
    return FormMeta(
      meta: map['meta'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}
