import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/data_value/queries/data_form_submission.query.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FormSubmissionRepository {
  FormSubmissionRepository();

  // final DataFormSubmissionQuery _query;
  DataFormSubmissionQuery get _query =>
      (D2Remote.formSubmissionModule.formSubmission as DataFormSubmissionQuery);

  Future<IList<DataFormSubmission>> getSubmissions(String form) async {
    final query = _query.byFormTemplate(form);
    final List<DataFormSubmission> submissions = await query.get();
    return submissions.lock;
  }

  Future<DataFormSubmission?> getSubmission(String uid) async {
    final DataFormSubmission? submission = await _query.byId(uid).getOne();
    return submission;
  }

  Future<int> deleteSubmission(String uid) async {
    return _query.byId(uid).delete();
    ;
  }
}
