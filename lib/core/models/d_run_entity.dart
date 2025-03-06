import 'package:d2_remote/shared/entities/identifiable.entity.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DIdentifiable with EquatableMixin {
  DIdentifiable(
      {this.id,
      this.code,
      this.name,
      this.disabled = false,
      this.deleted = false,
      IMap<String, dynamic> label = const IMapConst({}),
      IMap<String, dynamic> properties = const IMapConst({})})
      : this.label = label,
        this.properties = properties;

  factory DIdentifiable.fromIdentifiable(
      {required IdentifiableEntity identifiableEntity,
      IMap<String, dynamic> label = const IMapConst({}),
      IMap<String, dynamic> properties = const IMapConst({}),
      bool disabled = false,
      bool deleted = false}) {
    return DIdentifiable(
        id: identifiableEntity.id,
        code: identifiableEntity.code,
        name: identifiableEntity.name,
        label: label,
        properties: properties,
        disabled: disabled,
        deleted: deleted);
  }

  final String? id;
  final String? code;
  final String? name;
  final bool disabled;
  final bool deleted;
  final IMap<String, dynamic> label;
  final IMap<String, dynamic> properties;

  DIdentifiable copyWith({
    String? id,
    String? code,
    String? name,
    IMap<String, dynamic>? label,
    IMap<String, dynamic>? properties,
  }) {
    return DIdentifiable(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      label: label ?? this.label,
      properties: properties ?? this.properties,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        label,
        properties,
        disabled,
        deleted,
      ];
}
