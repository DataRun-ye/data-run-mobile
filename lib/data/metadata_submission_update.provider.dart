import 'package:datarunmobile/data/metadata_submission_update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_submission_update.provider.g.dart';

@riverpod
Future<List<MetadataSubmissionUpdate>> systemMetadataSubmissions(Ref ref,
    {required String query, required String submissionId}) async {
  return [];
}
