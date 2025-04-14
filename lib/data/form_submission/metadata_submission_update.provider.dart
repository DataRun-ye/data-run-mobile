import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/data/form_submission/metadata_submission_update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_submission_update.provider.g.dart';

@riverpod
Future<MetadataSubmission?> metadataSubmissionRepository(
    MetadataSubmissionRepositoryRef ref, String? orgUnit) {
  final db = DSdk.db;
  return (db.select(db.metadataSubmissions)
        ..where((tbl) => tbl.resourceId.equals(orgUnit ?? '')))
      .getSingleOrNull();
}
//
// @riverpod
// class MetadataSubmissionUpdates extends _$MetadataSubmissionUpdates {
//   @override
//   Future<List<MetadataSubmissionUpdate>> build(String submissionId) async {
//     final metadataSubmissionUpdates = await D2Remote
//         .formModule.metaSubmissionUpdate
//         .where(attribute: 'submissionId', value: submissionId)
//         .get();
//     return metadataSubmissionUpdates;
//   }
//
//   void add(MetadataSubmissionUpdate update) async {
//     // Add update to the list here
//     // This method should be implemented in the MetadataSubmissionUpdates class
//     await D2Remote.formModule.metaSubmissionUpdate.setData(update).save();
//     await D2Remote.formModule.metaSubmission;
//     ref.invalidateSelf();
//   }
// }

@riverpod
Future<List<MetadataSubmissionUpdate>> systemMetadataSubmissions(
    SystemMetadataSubmissionsRef ref,
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

// @riverpod
// Future<List<MetadataSubmissionUpdate>> metadataSubmissionUpdateFilter(
//     MetadataSubmissionUpdateFilterRef ref, String query, String orgUnit) async {
//   final allItems =
//       await ref.watch(metadataSubmissionUpdatesProvider(orgUnit).future);
//
//   return allItems.where((item) {
//     final lowerQuery = query.toLowerCase();
//     return item.householdName!.toLowerCase().contains(lowerQuery) ||
//         item.householdHeadSerialNumber.toString().contains(lowerQuery);
//   }).toList();
// }
