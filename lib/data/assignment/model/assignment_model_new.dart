import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarunmobile/core/models/d_run_base_model.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AssignmentModelNew extends DRunBaseModel<Assignment> {
  AssignmentModelNew._({
    required Assignment baseEntity,
    required this.activity,
    required this.orgUnit,
    required this.team,
    this.startDay,
    this.startDate,
    this.dueDate,
  }) : super(baseEntity: baseEntity);

  factory AssignmentModelNew.fromIdentifiable({
    required Assignment baseEntity,
    required DRunIdentifiable activity,
    required DRunIdentifiable orgUnit,
    required DRunIdentifiable team,
    DateTime? dueDate,
    int? startDay,
    String? startDate,
  }) {
    return AssignmentModelNew._(
        baseEntity: baseEntity,
        activity: activity,
        orgUnit: orgUnit,
        team: team,
        startDay: startDay,
        startDate: startDate,
        dueDate: dueDate);
  }

  final DRunIdentifiable activity;

  final DRunIdentifiable orgUnit;

  final DRunIdentifiable team;

  final int? startDay;

  final String? startDate;

  final DateTime? dueDate;

  EntityScope get scope => baseEntity.scope!;

  List<String> get forms => baseEntity.forms;

  AssignmentStatus get status =>
      baseEntity.status ?? AssignmentStatus.NOT_STARTED;

  @override
  AssignmentModelNew copyWith(
      {Assignment? baseEntity,
      DRunIdentifiable? activity,
      DRunIdentifiable? orgUnit,
      DRunIdentifiable? team,
      int? startDay,
      String? startDate,
      DateTime? dueDate}) {
    return AssignmentModelNew.fromIdentifiable(
        baseEntity: baseEntity ?? this.baseEntity,
        activity: activity ?? this.activity,
        orgUnit: orgUnit ?? this.orgUnit,
        team: team ?? this.team,
        startDay: startDay ?? this.startDay,
        startDate: startDate ?? this.startDate,
        dueDate: dueDate ?? this.dueDate);
  }

  @override
  List<Object?> get props => super.props + [status, activity, orgUnit, team];
}
