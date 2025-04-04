import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ActivityModel extends DRunIdentifiable<Activity> {
  ActivityModel._({
    required Activity baseEntity,
    this.assignmentCount = 0,
    this.assignedTeam,
    this.managedTeamCount,
  }) : super(baseEntity: baseEntity);

  factory ActivityModel.fromIdentifiable(
      {required Activity baseEntity,
      int assignmentCount = 0,
      String? assignedTeam,
      int? managedTeamCount}) {
    return ActivityModel._(baseEntity: baseEntity);
  }

  final int assignmentCount;
  final String? assignedTeam;
  final int? managedTeamCount;

  @override
  ActivityModel copyWith(
      {Activity? baseEntity,
      int? assignmentCount,
      String? assignedTeam,
      int? managedTeamCount}) {
    return ActivityModel._(
      baseEntity: baseEntity ?? this.baseEntity,
      assignmentCount: assignmentCount ?? this.assignmentCount,
      assignedTeam: assignedTeam ?? this.assignedTeam,
      managedTeamCount: managedTeamCount ?? this.managedTeamCount,
    );
  }

  @override
  List<Object?> get props =>
      super.props + [assignmentCount, assignedTeam, managedTeamCount];
}
