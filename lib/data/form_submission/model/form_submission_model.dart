import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarunmobile/core/models/d_run_base_model.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FormSubmissionModel extends DRunBaseModel<DataFormSubmission> {
  FormSubmissionModel._({
    required DataFormSubmission baseEntity,
    required this.formVersion,
    this.assignment,
    this.orgUnit,
    required this.activity,
    required this.team,
  }) : super(baseEntity: baseEntity);

  factory FormSubmissionModel.fromIdentifiable({
    required DataFormSubmission baseEntity,
    required DRunBaseModel formVersion,
    DRunBaseModel? assignment,
    required DRunIdentifiable activity,
    DRunIdentifiable? orgUnit,
    required DRunIdentifiable team,
    DateTime? dueDate,
    int? startDay,
    String? startDate,
  }) {
    return FormSubmissionModel._(
        baseEntity: baseEntity,
        formVersion: formVersion,
        assignment: assignment,
        orgUnit: orgUnit,
        activity: activity,
        team: team);
  }

  final DRunBaseModel formVersion;
  final DRunBaseModel? assignment;
  final DRunIdentifiable? orgUnit;
  final DRunIdentifiable activity;
  final DRunIdentifiable team;

  bool get deleted => baseEntity.deleted ?? false;

  bool get synced => baseEntity.synced ?? false;

  bool get syncFailed => baseEntity.isFinal ?? false;

  bool get isFinal => baseEntity.isFinal;

  String? get form => formVersion.id!.split('_').first;

  AssignmentStatus get status =>
      baseEntity.status ?? AssignmentStatus.NOT_STARTED;

  @override
  FormSubmissionModel copyWith(
      {DataFormSubmission? baseEntity,
      DRunBaseModel? formVersion,
      DRunBaseModel? assignment,
      DRunIdentifiable? orgUnit,
      DRunIdentifiable? activity,
      DRunIdentifiable? team,
      int? startDay,
      String? startDate,
      DateTime? dueDate}) {
    return FormSubmissionModel.fromIdentifiable(
        baseEntity: baseEntity ?? this.baseEntity,
        formVersion: formVersion ?? this.formVersion,
        assignment: assignment ?? this.assignment,
        orgUnit: orgUnit ?? this.orgUnit,
        activity: activity ?? this.activity,
        team: team ?? this.team);
  }

  @override
  List<Object?> get props =>
      super.props +
      [status, assignment, orgUnit, activity, team, status, formVersion];
}
