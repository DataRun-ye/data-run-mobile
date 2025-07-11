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
    String? orgUnit,
    required String submissionId}) async {
  final metadataSubmission =
      await ref.watch(metadataSubmissionRepositoryProvider(orgUnit).future);

  if (metadataSubmission == null) {
    return [];
  }

  final allItems = MetadataSubmissionUpdate.fromJsonList(
      metadataSubmission.toContext()['households'],
      resourceId: metadataSubmission.resourceId,
      submissionId: submissionId,
      metadataSubmission: metadataSubmission.metadataSchema,
      resourceType: metadataSubmission.resourceType);

  return allItems /*.where((item) {
    final lowerQuery = query.toLowerCase();
    return item.formData['householdName'].toLowerCase().contains(lowerQuery) ||
        item.formData['householdHeadSerialNumber']
            .toString()
            .contains(lowerQuery);
  }).toList()*/
      ;
}
