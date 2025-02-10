import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:intl/intl.dart';

class AssignmentModel {
  AssignmentModel({
    required this.id,
    required this.activityId,
    required this.activity,
    required this.entityId,
    required this.entityCode,
    required this.entityName,
    required this.teamId,
    required this.teamCode,
    required this.teamName,
    required this.scope,
    required this.status,
    this.startDay,
    this.startDate,
    this.dueDate,
    this.rescheduledDate,
    this.allocatedResources = const {},
    this.reportedResources = const {},
    required this.forms,
  });

  final String id;
  String activityId;
  String activity;
  final String entityId;
  final String entityCode;
  final String entityName;
  final String teamId;
  final String teamCode;
  final String teamName;
  final EntityScope scope;
  final AssignmentStatus status;
  final int? startDay;
  final String? startDate;
  final DateTime? dueDate;
  final DateTime? rescheduledDate;
  final List<String> forms;
  final Map<String, dynamic> allocatedResources; // E.g., ITNs, Population
  final Map<String, dynamic> reportedResources; // E.g., ITNs, Population

  AssignmentModel copyWith({
    String? id,
    String? activityId,
    String? activity,
    String? entityId,
    String? entityCode,
    String? entityName,
    String? teamId,
    String? teamCode,
    String? teamName,
    EntityScope? scope,
    AssignmentStatus? status,
    int? startDay,
    String? startDate,
    DateTime? dueDate,
    DateTime? rescheduledDate,
    List<String>? forms,
    Map<String, int>? allocatedResources,
    Map<String, int>? reportedResources,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      activity: activity ?? this.activity,
      entityId: entityId ?? this.entityId,
      entityCode: entityCode ?? this.entityCode,
      entityName: entityName ?? this.entityName,
      teamCode: teamCode ?? this.teamCode,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      scope: scope ?? this.scope,
      status: status ?? this.status,
      startDay: startDay ?? this.startDay,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      rescheduledDate: rescheduledDate ?? this.rescheduledDate,
      forms: forms ?? this.forms,
      allocatedResources: allocatedResources ?? this.allocatedResources,
      reportedResources: reportedResources ?? this.reportedResources,
    );
  }

  static int calculateStartDay(
      String activityStartDate, String assignmentStartDate) {
    final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final activityStart = dateFormat.parse(activityStartDate);
    final assignmentStart = dateFormat.parse(assignmentStartDate);

    return assignmentStart.difference(activityStart).inDays + 1;
  }

  static DateTime? calculateAssignmentDate(
      String activityStartDate, int? startDay) {
    final DateTime? activityStart = DateTime.tryParse(activityStartDate.endsWith('Z') ? activityStartDate : '${activityStartDate}Z');

    // final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", 'en_US');
    // final activityStart = dateFormat.tryParse(activityStartDate);
    return activityStart?.add(Duration(days: (startDay ?? 1) - 1));
  }
}
