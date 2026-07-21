import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:equatable/equatable.dart';

class AssignmentModel with EquatableMixin {
  AssignmentModel({
    required this.id,
    this.activity,
    required this.orgUnit,
    required this.team,
    this.status = AssignmentStatus.NOT_STARTED,
    this.startDay,
    this.startDate,
    this.dueDate,
    this.rescheduledDate,
    this.formCount = 0,
    this.userForms = const [],
  });

  /// assignment
  final String id;

  final IdentifiableModel? activity;
  final IdentifiableModel team;
  final IdentifiableModel orgUnit;
  final AssignmentStatus status;
  final int? startDay;
  final DateTime? startDate;
  final DateTime? dueDate;
  final DateTime? rescheduledDate;
  final List<Pair<AssignmentForm, bool>> userForms;
  final int formCount;

  List<Pair<AssignmentForm, bool>> get availableForms =>
      userForms.where((form) => form.second).toList();

  @override
  List<Object?> get props => [
        id,
        activity,
        orgUnit,
        team,
        // scope,
        status,
        startDay,
        startDate,
        dueDate,
        rescheduledDate,
        formCount,
        // allocatedResources,
        // reportedResources
      ];

  AssignmentModel copyWith({
    String? id,
    IdentifiableModel? activity,
    IdentifiableModel? team,
    IdentifiableModel? orgUnit,
    AssignmentStatus? status,
    int? startDay,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? rescheduledDate,
    List<Pair<AssignmentForm, bool>>? userForms,
    int? formCount,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      activity: activity ?? this.activity,
      team: team ?? this.team,
      orgUnit: orgUnit ?? this.orgUnit,
      status: status ?? this.status,
      startDay: startDay ?? this.startDay,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      rescheduledDate: rescheduledDate ?? this.rescheduledDate,
      userForms: userForms ?? this.userForms,
      formCount: formCount ?? this.formCount,
    );
  }
}
