import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:datarun/commons/helpers/map.dart';
import 'package:datarun/data_run/d_assignment/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/model/extract_and_sum_allocated_actual.dart';
import 'package:datarun/data_run/d_team/team_model.dart';
import 'package:datarun/data_run/d_team/team_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.g.dart';

@riverpod
Future<List<FormVersion>> assignmentForms(AssignmentFormsRef ref) {
  throw UnimplementedError();
}

@riverpod
AssignmentModel assignment(AssignmentRef ref) {
  throw UnimplementedError();
}

/// a notifier that retrieves all assignments with their data populated
@riverpod
class Assignments extends _$Assignments {
  @override
  Future<List<AssignmentModel>> build() async {
    final query = D2Remote.assignmentModuleD.assignment;
    final List<DAssignment> assignments = await query.get();
    final futures =
        assignments.map<Future<AssignmentModel>>((assignment) async {
      final activityEntity = await D2Remote.activityModuleD.activity
          .byId(assignment.activity!)
          .getOne();
      final orgUnitEntity = await D2Remote.organisationUnitModuleD.orgUnit
          .byId(assignment.orgUnit!)
          .getOne();

      final teamEntity =
          await D2Remote.teamModuleD.team.byId(assignment.team!).getOne();

      final IList<TeamModel> assignedTeams =
          await ref.watch(teamsProvider(EntityScope.Assigned).future);

      final IList<TeamModel> managedTeams =
          await ref.watch(teamsProvider(EntityScope.Managed).future);

      final assignedForms = assignedTeams
          .expand((t) => t.formPermissions)
          .map((f) => f.form)
          .toList();

      final assignmentForms =
          assignment.forms.where((f) => assignedForms.contains(f)).toList();
      List<DataFormSubmission> submissions = [];

      for (var form in assignmentForms) {
        submissions.addAll(await ref.watch(
            assignmentSubmissionsProvider(assignment.id!, form: form).future));
      }

      AssignmentStatus status;

      // if (submissions.isEmpty) {
      //   status = AssignmentStatus.NOT_STARTED;
      // } else {
      //   final sortedSubmissions = submissions.toList()
      //     ..sort((a, b) => b.lastModifiedDate!.compareTo(a.lastModifiedDate!));
      //   status = sortedSubmissions.first.status!;
      status = assignment.status ?? AssignmentStatus.NOT_STARTED;
      // }

      return AssignmentModel(
        id: assignment.id!,
        activityId: activityEntity.id,
        activity: activityEntity.name,
        entityId: orgUnitEntity.id!,
        entityCode: orgUnitEntity.code!,
        entityName: orgUnitEntity.name!,
        teamId: teamEntity.id,
        teamCode: teamEntity.code,
        teamName: teamEntity.name,
        scope: assignment.scope ?? EntityScope.Assigned,
        status: status,
        dueDate: activityEntity.startDate != null
            ? AssignmentModel.calculateAssignmentDate(
                activityEntity.startDate, assignment.startDay)
            : null,
        // DateTime.parse(assignment.startDate!)
        startDay: assignment.startDay,
        rescheduledDate: assignment.startDate != null
            ? DateTime.parse(
                DateHelper.fromDbUtcToUiLocalFormat(assignment.startDate!))
            : null,
        allocatedResources: managedTeams.length > 0
            ? assignment.allocatedResources
                .filter((entry) =>
                    entry.key != 'Latitude' && entry.key != 'Longitude')
                .map((key, value) => MapEntry(key, value ?? 0))
            : {},
        reportedResources: sumActualResources(
            submissions, assignment.allocatedResources.keys.toList()),
        forms: assignment.forms,
      );
    }).toList();

    final assignmentModels = await Future.wait<AssignmentModel>(futures);
    return assignmentModels;
  }

  void updateAssignmentStatus(
      AssignmentStatus? status, String assignmentId) async {
    // final previousState = await future;

    DAssignment? assignment =
        await D2Remote.assignmentModuleD.assignment.byId(assignmentId).getOne();
    if (assignment != null) {
      assignment.status = status;
      assignment.lastModifiedDate = DateHelper.nowUtc();
      await D2Remote.assignmentModuleD.assignment
          .setData(assignment)
          .save(saveOptions: SaveOptions(skipLocalSyncStatus: false));
    }

    ref.invalidateSelf();
    await future;
  }
}

class AssignmentModel with EquatableMixin {
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
  final String activityId;
  final String activity;
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
    final DateTime? activityStart = DateTime.tryParse(
        DateHelper.fromDbUtcToUiLocalFormat(activityStartDate));
    return activityStart?.add(Duration(days: (startDay ?? 1) - 1));
  }

  @override
  List<Object?> get props => [
        id,
        activityId,
        activity,
        entityId,
        entityCode,
        entityName,
        teamId,
        teamCode,
        teamName,
        scope,
        status,
        startDay,
        startDate,
        dueDate,
        rescheduledDate,
        forms,
        allocatedResources,
        reportedResources
      ];
}
