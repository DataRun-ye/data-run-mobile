// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:d_sdk/database/shared/assignment_status.dart';
// import 'package:d_sdk/database/shared/entity_scope.dart';
// import 'package:datarunmobile/core/models/d_run_base_model.dart';
// import 'package:datarunmobile/core/models/d_run_identifiable.dart';
// import 'package:flutter/cupertino.dart';
//
// @immutable
// class AssignmentModelNew extends DRunBaseModel {
//   final String id;
//
//   AssignmentModelNew({
//     required super.id,
//     required this.activity,
//     required this.orgUnit,
//     required this.team,
//     this.startDay,
//     this.startDate,
//     this.dueDate,
//     this.scope = EntityScope.Assigned,
//     this.forms = const [],
//     this.status = AssignmentStatus.NOT_STARTED,
//   });
//
//   final DRunIdentifiable activity;
//
//   final DRunIdentifiable orgUnit;
//
//   final DRunIdentifiable team;
//
//   final int? startDay;
//
//   final String? startDate;
//
//   final DateTime? dueDate;
//
//   final EntityScope scope;
//
//   final List<String> forms;
//
//   final AssignmentStatus status;
//
//   @override
//   AssignmentModelNew copyWith(
//       {String? id,
//       DRunIdentifiable? activity,
//       DRunIdentifiable? orgUnit,
//       DRunIdentifiable? team,
//       int? startDay,
//       String? startDate,
//       DateTime? dueDate}) {
//     return AssignmentModelNew(
//         id: id ?? this.id,
//         activity: activity ?? this.activity,
//         orgUnit: orgUnit ?? this.orgUnit,
//         team: team ?? this.team,
//         startDay: startDay ?? this.startDay,
//         startDate: startDate ?? this.startDate,
//         dueDate: dueDate ?? this.dueDate);
//   }
//
//   @override
//   List<Object?> get props => super.props + [status, activity, orgUnit, team];
//
//   Map<String, dynamic> toMap() {
//     return {
//       ...super.toMap(),
//       'activity': this.activity,
//       'orgUnit': this.orgUnit,
//       'team': this.team,
//       'startDay': this.startDay,
//       'startDate': this.startDate,
//       'dueDate': this.dueDate,
//       'scope': this.scope.name,
//       'forms': this.forms,
//       'status': this.status?.name,
//     };
//   }
//
//   factory AssignmentModelNew.fromMap(Map<String, dynamic> map) {
//     return AssignmentModelNew(
//       id: map['id'] as String,
//       activity: DRunIdentifiable.fromMap(map['activity']),
//       orgUnit: DRunIdentifiable.fromMap(map['orgUnit']),
//       team: DRunIdentifiable.fromMap(map['team']),
//       startDay: map['startDay'] as int,
//       startDate: map['startDate'] as String,
//       dueDate: map['dueDate'] as DateTime,
//       scope: map['scope'] as EntityScope,
//       forms: map['forms'] as List<String>,
//       status: map['status'] as AssignmentStatus,
//     );
//   }
// }
