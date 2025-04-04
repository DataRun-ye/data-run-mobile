import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:d2_remote/shared/mixin/d_run_base.dart';

@immutable
class DRunBaseModel<T extends DRunBase>
    extends DRunBase with EquatableMixin {
  DRunBaseModel({required this.baseEntity});

  factory DRunBaseModel.fromIdentifiable({required T baseEntity}) {
    return DRunBaseModel(baseEntity: baseEntity);
  }

  final T baseEntity;

  @override
  String get id => baseEntity.id!;

  DRunBaseModel copyWith({T? baseEntity}) {
    return DRunBaseModel.fromIdentifiable(
      baseEntity: baseEntity ?? this.baseEntity,
    );
  }

  @override
  List<Object?> get props => [id];
}
