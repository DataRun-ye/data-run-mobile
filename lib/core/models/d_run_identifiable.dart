import 'package:d2_remote/shared/mixin/d_run_identifiable.dart';
import 'package:datarunmobile/core/models/d_run_base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DRunIdentifiable<T extends DRunIdentifiableBase> extends DRunBaseModel<T>
    with EquatableMixin
    implements DRunIdentifiableBase {
  DRunIdentifiable({required super.baseEntity, this.displayName});

  factory DRunIdentifiable.fromIdentifiable(
      {required T baseEntity, String? displayName}) {
    return DRunIdentifiable(
        baseEntity: baseEntity,
        displayName: displayName ?? baseEntity.displayName);
  }

  @override
  final String? displayName;

  @override
  String get id => baseEntity.id!;

  @override
  String? get code => baseEntity.code;

  @override
  String? get name => baseEntity.name;

  DRunIdentifiable copyWith({T? baseEntity}) {
    return DRunIdentifiable.fromIdentifiable(
      baseEntity: baseEntity ?? this.baseEntity,
      displayName: this.displayName,
    );
  }

  @override
  List<Object?> get props => [id, code, name, displayName];
}
