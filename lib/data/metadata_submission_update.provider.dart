import 'package:datarunmobile/data/metadata_submission_update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_submission_update.provider.g.dart';

// @riverpod
// Future<MetadataSubmission?> metadataSubmissionRepository(
//     Ref ref, String? orgUnit) {
//   final db = DSdk.db;
//   return (db.select(db.metadataSubmissions)
//         ..where((tbl) => tbl.resourceId.equals(orgUnit ?? '')))
//       .getSingleOrNull();
// }

@riverpod
Future<List<MetadataSubmissionUpdate>> systemMetadataSubmissions(Ref ref,
    {required String query, required String submissionId}) async {
  return [];
}
