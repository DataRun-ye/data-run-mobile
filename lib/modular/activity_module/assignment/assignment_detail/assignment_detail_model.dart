import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AssignmentDetail extends DRunIdentifiable<Assignment> {
  AssignmentDetail({
    required Assignment identifiableEntity,
  }) : super(identifiableEntity: identifiableEntity);

  factory AssignmentDetail.fromIdentifiable(
      {required Assignment identifiableEntity}) {
    return AssignmentDetail(identifiableEntity: identifiableEntity);
  }

  EntityScope? get scope => identifiableEntity.scope;

  AssignmentStatus? get status => identifiableEntity.status;

  @override
  AssignmentDetail copyWith({
    Assignment? identifiableEntity,
  }) {
    return AssignmentDetail(
        identifiableEntity: identifiableEntity ?? this.identifiableEntity);
  }

  @override
  List<Object?> get props => super.props + [scope, status];
}
