import 'package:d2_remote/shared/mixin/d_run_identifiable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DRunIdentifiable<T extends DRunIdentifiableBase>
    extends DRunIdentifiableBase with EquatableMixin {
  DRunIdentifiable({required this.identifiableEntity, this.displayName});

  factory DRunIdentifiable.fromIdentifiable(
      {required T identifiableEntity, String? displayName}) {
    return DRunIdentifiable(
        identifiableEntity: identifiableEntity,
        displayName: displayName ?? identifiableEntity.name);
  }

  final T identifiableEntity;

  @override
  final String? displayName;

  @override
  String? get id => identifiableEntity.id;

  @override
  String? get code => identifiableEntity.code;

  @override
  String? get name => identifiableEntity.name;

  DRunIdentifiable copyWith({T? identifiableEntity}) {
    return DRunIdentifiable.fromIdentifiable(
      identifiableEntity: identifiableEntity ?? this.identifiableEntity,
      displayName: this.displayName,
    );
  }

  @override
  List<Object?> get props => [id, code, name, displayName];
}
