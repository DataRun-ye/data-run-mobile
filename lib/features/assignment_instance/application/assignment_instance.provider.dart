import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_instance.provider.g.dart';

@riverpod
Future<List<Assignment>> assignmentInstanceList(Ref ref) async {
  return DSdk.db.assignmentsDao.getAll();
}

@riverpod
Future<Assignment?> assignmentInstanceItem(Ref ref, String id) async {
  return DSdk.db.assignmentsDao.getById(id);
}

@riverpod
Future<List<StageDefinition>> assignmentInstanceItemStages(
    Ref ref, String id) async {
  return DSdk.db.managers.stageDefinitions
      .filter((f) => f.flowType.id(id))
      .get();
}

@riverpod
Future<FormTemplate> assignmentInstanceStageTemplate(Ref ref, String id) async {
  DSdk.db.managers.stageDefinitions
      .filter((f) => f.flowType.id(id))
      .withReferences()
      .get();
  final stagesWithRefs = await DSdk.db.managers.stageDefinitions
      .filter((f) => f.flowType.id(id))
      .withReferences((prefetch) => prefetch(dataTemplate: true))
      .getSingle();

  final (s, refs) = stagesWithRefs;
  final stage = s;
  final dataTemplate = (refs.dataTemplate.prefetchedData)!.first;

  return dataTemplate;
}
