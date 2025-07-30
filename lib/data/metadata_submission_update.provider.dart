import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/data/metadata_submission_update.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_submission_update.provider.g.dart';

@riverpod
Future<MetadataSubmission?> metadataSubmissionRepository(
    Ref ref, String? orgUnit) {
  final db = DSdk.db;
  return (db.select(db.metadataSubmissions)
        ..where((tbl) => tbl.resourceId.equals(orgUnit ?? '')))
      .getSingleOrNull();
}

@riverpod
Future<List<MetadataSubmissionUpdate>> systemMetadataSubmissions(Ref ref,
    {required String query,
    required String submissionId}) async {
  final submission = await DSdk.db.managers.dataInstances
      .filter((f) => f.id(submissionId))
      .withReferences((prefetch) => prefetch(assignment: true))
      .getSingleOrNull();

  final $$DataInstancesTableReferences? dd = submission?.$2;

  final Assignment? assignment = dd?.assignment?.prefetchedData?.first;

  final metadataSubmission = await ref
      .watch(metadataSubmissionRepositoryProvider(assignment?.orgUnit).future);

  if (metadataSubmission == null) {
    return [];
  }

  final allItems = MetadataSubmissionUpdate.fromJsonList(
      metadataSubmission.toContext()['households'],
      resourceId: metadataSubmission.resourceId,
      submissionId: submissionId,
      metadataSubmission: metadataSubmission.metadataSchema,
      resourceType: metadataSubmission.resourceType);

  return allItems;
}
