import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ActivityDetail extends DRunIdentifiable<Activity> {
  ActivityDetail._({
    required Activity identifiableEntity,
    this.assignmentCount = 0,
    this.assignedTeam,
    this.managedTeamCount,
  }) : super(identifiableEntity: identifiableEntity);

  factory ActivityDetail.fromIdentifiable(
      {required Activity identifiableEntity,
      int assignmentCount = 0,
      String? assignedTeam,
      int? managedTeamCount}) {
    return ActivityDetail._(identifiableEntity: identifiableEntity);
  }

  final int assignmentCount;
  final String? assignedTeam;
  final int? managedTeamCount;

  @override
  ActivityDetail copyWith(
      {Activity? identifiableEntity,
      int? assignmentCount,
      String? assignedTeam,
      int? managedTeamCount}) {
    return ActivityDetail._(
      identifiableEntity: identifiableEntity ?? this.identifiableEntity,
      assignmentCount: assignmentCount ?? this.assignmentCount,
      assignedTeam: assignedTeam ?? this.assignedTeam,
      managedTeamCount: managedTeamCount ?? this.managedTeamCount,
    );
  }

  @override
  List<Object?> get props =>
      super.props + [assignmentCount, assignedTeam, managedTeamCount];
}
