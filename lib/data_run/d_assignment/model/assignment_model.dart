// import 'package:d_sdk/core/utilities/date_helper.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:d_sdk/database/shared/team_form_permission.dart';
// import 'package:d_sdk/database/shared/assignment_status.dart';
// import 'package:datarunmobile/commons/helpers/collections.dart';
// import 'package:equatable/equatable.dart';
// import 'package:intl/intl.dart';
//
// class AssignmentModel with EquatableMixin {
//   AssignmentModel({
//     required this.id,
//     required this.activityId,
//     // required this.activity,
//     required this.entityId,
//     required this.entityCode,
//     required this.entityName,
//     required this.teamId,
//     required this.teamCode,
//     required this.teamName,
//     required this.scope,
//     required this.status,
//     this.startDay,
//     this.startDate,
//     this.dueDate,
//     this.rescheduledDate,
//     this.allocatedResources = const {},
//     this.reportedResources = const {},
//     required this.userForms,
//   });
//
//   final String id;
//   final String activityId;
//
//   // final String activity;
//   final String entityId;
//   final String entityCode;
//   final String entityName;
//   final String teamId;
//   final String teamCode;
//   final String teamName;
//   final EntityScope scope;
//   final AssignmentStatus status;
//   final int? startDay;
//   final String? startDate;
//   final DateTime? dueDate;
//   final DateTime? rescheduledDate;
//   final List<Pair<TeamFormPermission, bool>> userForms;
//   final Map<String, dynamic> allocatedResources; // E.g., ITNs, Population
//   final Map<String, dynamic> reportedResources; // E.g., ITNs, Population
//
//   List<Pair<TeamFormPermission, bool>> get availableForms =>
//       userForms.where((form) => form.second).toList();
//
//   AssignmentModel copyWith({
//     String? id,
//     String? activityId,
//     String? activity,
//     String? entityId,
//     String? entityCode,
//     String? entityName,
//     String? teamId,
//     String? teamCode,
//     String? teamName,
//     EntityScope? scope,
//     AssignmentStatus? status,
//     int? startDay,
//     String? startDate,
//     DateTime? dueDate,
//     DateTime? rescheduledDate,
//     List<Pair<TeamFormPermission, bool>>? userForms,
//     Map<String, int>? allocatedResources,
//     Map<String, int>? reportedResources,
//   }) {
//     return AssignmentModel(
//       id: id ?? this.id,
//       activityId: activityId ?? this.activityId,
//       // activity: activity ?? this.activity,
//       entityId: entityId ?? this.entityId,
//       entityCode: entityCode ?? this.entityCode,
//       entityName: entityName ?? this.entityName,
//       teamCode: teamCode ?? this.teamCode,
//       teamId: teamId ?? this.teamId,
//       teamName: teamName ?? this.teamName,
//       scope: scope ?? this.scope,
//       status: status ?? this.status,
//       startDay: startDay ?? this.startDay,
//       startDate: startDate ?? this.startDate,
//       dueDate: dueDate ?? this.dueDate,
//       rescheduledDate: rescheduledDate ?? this.rescheduledDate,
//       userForms: userForms ?? this.userForms,
//       allocatedResources: allocatedResources ?? this.allocatedResources,
//       reportedResources: reportedResources ?? this.reportedResources,
//     );
//   }
//
//   static int calculateStartDay(
//       String activityStartDate, String assignmentStartDate) {
//     final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
//     final activityStart = dateFormat.parse(activityStartDate);
//     final assignmentStart = dateFormat.parse(assignmentStartDate);
//
//     return assignmentStart.difference(activityStart).inDays + 1;
//   }
//
//   static DateTime? calculateAssignmentDate(
//       String activityStartDate, int? startDay) {
//     final DateTime? activityStart = DateTime.tryParse(
//         DateHelper.fromDbUtcToUiLocalFormat(activityStartDate));
//     return activityStart?.add(Duration(days: (startDay ?? 1) - 1));
//   }
//
//   @override
//   List<Object?> get props => [
//         id,
//         activityId,
//         // activity,
//         entityId,
//         entityCode,
//         entityName,
//         teamId,
//         teamCode,
//         teamName,
//         scope,
//         status,
//         startDay,
//         startDate,
//         dueDate,
//         rescheduledDate,
//         userForms,
//         availableForms,
//         allocatedResources,
//         reportedResources
//       ];
// }
