import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/core/util/string_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams.provider.g.dart';

@riverpod
Future<List<Pair<AssignmentForm, bool>>> userAvailableForms(Ref ref,
    {String? assignment}) async {
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
      .map((fp) => Pair(fp, availableForms.contains(fp.form)))
      .toList();

  return availableAssignedForms;
}

@riverpod
Future<List<IdentifiableModel>> teams(Ref ref, {String? activity}) async {
  var query = DSdk.db.managers.teams;

  if (activity.isNotNullOrEmpty) {
    query = query..filter((f) => f.activity.id(activity));
  }

  final ts = await query.get();
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
  String? team,
  String? activity,
  String? assignmentId,
}) async {
  var query = DSdk.db.managers.managedTeams;
  if (assignmentId.isNotNullOrEmpty) {
    final Assignment assignment = await DSdk.db.managers.assignments
        .filter((f) => f.id(assignmentId))
        .getSingle();
    query = query..filter((f) => f.managedBy.id(assignment.team));
  } else {
    if (team.isNotNullOrEmpty) {
      query = query..filter((f) => f.managedBy.id(team));
    }
    if (activity.isNotNullOrEmpty) {
      query = query..filter((f) => f.activity.id(activity));
    }
  }
  return query
      .map((t) => IdentifiableModel(
          id: t.id,
          name: '${Intl.message('team')} ${t.code}',
          code: t.code,
          properties: {'activity': t.activity}))
      .get();
}
