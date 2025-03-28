import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AssignmentDetail extends DRunIdentifiable<Assignment> {
  AssignmentDetail._({
    required Assignment identifiableEntity,
    required this.activity,
    required this.orgUnit,
    required this.team,
    required this.linkedForms,
    this.startDay,
    this.startDate,
  }) : super(identifiableEntity: identifiableEntity);

  factory AssignmentDetail.fromIdentifiable({
    required Assignment identifiableEntity,
    required DRunIdentifiable activity,
    required DRunIdentifiable orgUnit,
    required DRunIdentifiable team,
    Iterable<DRunIdentifiable>? linkedForms,
    int? startDay,
    String? startDate,
  }) {
    return AssignmentDetail._(
      identifiableEntity: identifiableEntity,
      activity: activity,
      orgUnit: orgUnit,
      team: team,
      linkedForms: IList.orNull(linkedForms) ?? IList(),
      startDay: startDay,
      startDate: startDate,
    );
  }

  final DRunIdentifiable activity;

  final DRunIdentifiable orgUnit;

  final DRunIdentifiable team;

  final IList<DRunIdentifiable> linkedForms;

  final int? startDay;

  final String? startDate;

  EntityScope? get scope => identifiableEntity.scope;

  AssignmentStatus? get status => identifiableEntity.status;

  @override
  AssignmentDetail copyWith({
    Assignment? identifiableEntity,
    DRunIdentifiable? activity,
    DRunIdentifiable? orgUnit,
    DRunIdentifiable? team,
    List<DRunIdentifiable>? linkedForms,
    int? startDay,
    String? startDate,
  }) {
    return AssignmentDetail.fromIdentifiable(
      identifiableEntity: identifiableEntity ?? this.identifiableEntity,
      activity: activity ?? this.activity,
      orgUnit: orgUnit ?? this.orgUnit,
      team: team ?? this.team,
      linkedForms: IList.orNull(linkedForms) ?? this.linkedForms,
      startDay: startDay ?? this.startDay,
      startDate: startDate ?? this.startDate,
    );
  }

  @override
  List<Object?> get props =>
      super.props +
      [scope, status, activity, orgUnit, team, startDay, startDate];
}
