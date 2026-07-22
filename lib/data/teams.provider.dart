import 'package:collection/collection.dart';
import 'package:datarunmobile/core/util/string_extension.dart';
import 'package:datarunmobile/d_sdk.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams.provider.g.dart';

class AssignmentFormAvailability {
  const AssignmentFormAvailability({
    required this.assignmentForm,
    required this.isAvailableLocally,
  });

  final AssignmentForm assignmentForm;
  final bool isAvailableLocally;
}

@riverpod
Future<List<AssignmentFormAvailability>> userAvailableForms(
  Ref ref, {
  String? assignment,
}) async {
  List<AssignmentForm> assignmentForms = [];
  if (assignment.isNotNullOrEmpty) {
    assignmentForms.addAll(await DSdk.db.managers.assignmentForms
        .filter((f) => f.assignment.id(assignment))
        .get());
  } else {
    assignmentForms.addAll(await DSdk.db.managers.assignmentForms.get());
  }

  final userForm = assignmentForms.map((a) => a.form);
  final List<FormTemplate> availableFormTemplates = await DSdk
      .db.managers.formTemplates
      .filter((f) => f.id.isIn(userForm))
      .get();

  final List<String> availableForms =
      availableFormTemplates.map((f) => f.id).toList();

  final availableAssignedForms = assignmentForms
      .map((assignmentForm) => AssignmentFormAvailability(
            assignmentForm: assignmentForm,
            isAvailableLocally: availableForms.contains(assignmentForm.form),
          ))
      .sorted((a, b) => a.assignmentForm.form.compareTo(b.assignmentForm.form))
      .toList();

  return availableAssignedForms;
}

@riverpod
Future<List<IdentifiableModel>> teams(Ref ref, {String? activity}) async {
  var query = DSdk.db.managers.teams;

  if (activity.isNotNullOrEmpty) {
    query = query..filter((f) => f.activity.id(activity));
  }

  return query
      .map((t) => IdentifiableModel(
          id: t.id,
          name: '${Intl.message('team')} ${t.code}',
          code: t.code,
          properties: {'activity': t.activity}))
      .get();
}

@riverpod
Future<List<IdentifiableModel>> managedTeams(
  Ref ref, {
  String? assignmentId,
}) async {
  if (!assignmentId.isNotNullOrEmpty) {
    return [];
  }

  final assignment = await DSdk.db.managers.assignments
      .filter((f) => f.id(assignmentId))
      .getSingleOrNull();
  if (assignment == null) {
    return [];
  }

  final query = DSdk.db.managers.managedTeams
      .filter((f) => f.managedBy.id(assignment.team))
      .filter((f) => f.activity.id(assignment.activity));

  return query
      .map((t) => IdentifiableModel(
          id: t.id,
          name: '${Intl.message('team')} ${t.code}',
          code: t.code,
          properties: {'activity': t.activity}))
      .get();
}
