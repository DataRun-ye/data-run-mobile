import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormSubmissionRepository {
  FormSubmissionRepository();

  // final DataFormSubmissionQuery _query;
  AppDatabase get _db => DSdk.db;

  Future<IList<DataInstance>> getSubmissions(String form) async {
    final query =
    await _db.managers.dataInstances.filter((f) => f.formTemplate.id(form));
    final List<DataInstance> submissions = await query.get();
    return submissions.lock;
  }

  Future<DataInstance?> getSubmission(String uid) async {
    final DataInstance? submission = await _db.managers.dataInstances
        .filter((f) => f.id(uid))
        .getSingleOrNull();
    return submission;
  }

  Future<void> deleteSubmission(String uid) async {
    _db.dataInstancesDao.deleteById(uid);
    await _db.managers.dataInstances.filter((f) => f.id(uid)).delete();
  }
}
