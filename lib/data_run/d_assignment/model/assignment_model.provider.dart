import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/team/teams.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/model/filter_query.provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.provider.g.dart';

@riverpod
AssignmentModel assignment(Ref ref) {
  throw UnimplementedError();
}

/// a notifier that retrieves all assignments with their data populated
@Riverpod(dependencies: [activityModel])
class AssignmentModels extends _$AssignmentModels {
  @override
  Future<List<AssignmentModel>> build() async {
    final activityModel = ref.watch(activityModelProvider);
    final query =
        DSdk.db.assignmentsDao.selectAssignments(activityId: activityModel.id);

    final List<AssignmentModel> assignments = await query.get();
    final assignmentModels = assignments.map<AssignmentModel>((assignment) {
      // final assignedForms = appLocator<User>().userFormsUIDs;

      // final assignmentForms =
      //     assignment.forms.where((f) => assignedForms.contains(f)).toList();

      return assignment;
    }).toList();

    return assignmentModels;
  }

  void updateAssignmentStatus(
      AssignmentStatus? progressStatus, String assignmentId) async {
    await DSdk.db.managers.assignments.filter((f) => f.id(assignmentId)).update(
        (o) => o.call(flowStatus: Value.absentIfNull(progressStatus)));

    ref.invalidateSelf();
    await future;
  }
}

/// filters the list of assignment by certain
@Riverpod(dependencies: [activityModel, AssignmentModels])
Future<List<AssignmentModel>> filterAssignments(Ref ref) async {
  final assignments = await ref.watch(assignmentModelsProvider.future);
  final query = ref.watch(filterQueryProvider);
  final teamsAsync =
      await ref.watch(teamsProvider(EntityScope.Assigned).future);
  final lowerCaseQuery = query.searchQuery.toLowerCase();
  assignments.sort((a, b) => (a.startDay ?? 11).compareTo((b.startDay ?? 11)));
  final filteredAssignments = assignments.where((assignment) {
    for (var entry in query.filters.entries) {
      final key = entry.key;
      final value = entry.value;

      final selectedTeams = teamsAsync
          .where((t) =>
              key == 'teams' &&
              value is Iterable &&
              value.isNotEmpty &&
              value.contains(t.name))
          .map((t) => t.id)
          .toList();

      if (key == 'status' &&
          value is Iterable &&
          value.isNotEmpty &&
          (!value.contains(assignment.status))) {
        return false;
      }
      // TODO add date range
      if (key == 'days' &&
          value is Iterable &&
          value.isNotEmpty &&
          (assignment.startDay == null ||
              !value.contains(assignment.startDay))) {
        return false;
      }

      if (key == 'teams' &&
          value is Iterable &&
          value.isNotEmpty &&
          (!selectedTeams.contains(assignment.team.id))) {
        return false;
      }
    }

    if (query.searchQuery.isNotEmpty) {
      final lowerCaseActivity = assignment.activity?.name?.toLowerCase() ?? '';
      final lowerCaseEntityCode = assignment.orgUnit.code?.toLowerCase() ?? '';
      final lowerCaseEntityName = assignment.orgUnit.name?.toLowerCase() ?? '';
      final lowerCaseTeamName = assignment.team.name?.toLowerCase() ?? '';

      if (!lowerCaseActivity.contains(lowerCaseQuery) &&
          !lowerCaseEntityCode.contains(lowerCaseQuery) &&
          !lowerCaseEntityName.contains(lowerCaseQuery) &&
          !lowerCaseTeamName.contains(lowerCaseQuery)) {
        return false;
      }
    }

    return true;
  }).toList();

  // Apply sorting
  if (query.sortBy != null) {
    filteredAssignments.sort((a, b) {
      final aValue = _getAssignmentFieldValue(a, query.sortBy!);
      final bValue = _getAssignmentFieldValue(b, query.sortBy!);

      if (aValue == null || bValue == null) return 0;
      return query.ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  return filteredAssignments;
}

// Helper function to get field values dynamically
dynamic _getAssignmentFieldValue(AssignmentModel assignment, String field) {
  switch (field) {
    case 'dueDate':
      return assignment.dueDate;
    case 'status':
      return assignment.status.index; // Assuming `AssignmentStatus` is an enum
    case 'teamName':
      return assignment.team.name;
    // Add more fields as needed
    default:
      return null;
  }
}
