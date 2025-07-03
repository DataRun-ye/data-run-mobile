import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormSubmissionRepository {
  FormSubmissionRepository();

  // final DataFormSubmissionQuery _query;
  // DataFormSubmissionQuery get _query =>
  final db = DSdk.db;

  Future<IList<DataSubmission>> getSubmissions(String form) async {
    // final query = _query.byFormTemplate(form);
    final List<DataSubmission> submissions =
        await (db.select(db.dataSubmissions)
              ..where((tbl) => tbl.dataTemplate.equals(form)))
            .get();

    return submissions.lock;
  }

  Future<DataSubmission?> getSubmission(String uid) async {
    final DataSubmission? submission = await (db.select(db.dataSubmissions)
          ..where((tbl) => tbl.id.equals(uid)))
        .getSingleOrNull();
    return submission;
  }

  Future<int> deleteSubmission(String uid) async {
    return (db.delete(db.dataSubmissions)..where((tbl) => tbl.id.equals(uid)))
        .go();
  }
}
