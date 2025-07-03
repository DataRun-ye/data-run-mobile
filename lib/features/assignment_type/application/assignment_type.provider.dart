import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_type.provider.g.dart';

@riverpod
Future<List<AssignmentType>> assignmentTypeList(Ref ref) async {
  return DSdk.db.assignmentTypesDao.getAll();
}

@riverpod
Future<AssignmentType?> assignmentTypeItem(Ref ref, String id) async {
  return DSdk.db.assignmentTypesDao.getById(id);
}

/// one stage or multi-stage assignment type, each stage with
/// its own dataTemplate
@riverpod
Future<List<StageDefinition>> assignmentTypeItemStages(
    Ref ref, String id) async {
  return DSdk.db.managers.stageDefinitions
      .filter((f) => f.flowType.id(id))
      .get();
}

@riverpod
Future<FormTemplate?> assignmentTypeStageTemplate(
    Ref ref, String stageId) async {
  return DSdk.db.managers.formTemplates
      .filter((f) => f.stageDefinitionsRefs((f) => f.id(stageId)))
      .getSingleOrNull();
  // final stagesWithRefs = await DSdk.db.managers.stageDefinitions
  //     .filter((f) => f.assignmentType.id(id))
  //     .withReferences((prefetch) => prefetch(dataTemplate: true))
  //     .getSingle();
  //
  // final (s, refs) = stagesWithRefs;
  // final stage = s;
  // final dataTemplate = (refs.dataTemplate.prefetchedData)!.first;
  //
  // return dataTemplate;
}
