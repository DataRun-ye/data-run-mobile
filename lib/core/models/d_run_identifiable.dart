import 'package:d2_remote/shared/entities/d_run_identifiable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DRunIdentifiable<T extends IdentifiableModel>
    with EquatableMixin
    implements IdentifiableModel {
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
  String? get id => identifiableEntity.uid;

  @override
  String? get uid => identifiableEntity.uid;

  @override
  String? get code => identifiableEntity.code;

  @override
  String? get name => identifiableEntity.name;

  DRunIdentifiable copyWith({T? identifiableEntity}) {
    return DRunIdentifiable(
      identifiableEntity: identifiableEntity ?? this.identifiableEntity,
      displayName: this.displayName,
    );
  }

  @override
  List<Object?> get props => [id, uid, code, name, displayName];
}
