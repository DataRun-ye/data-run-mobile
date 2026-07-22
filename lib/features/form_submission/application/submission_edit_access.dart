import 'package:datarunmobile/database/app_database.dart';
import 'package:drift/drift.dart';

Future<bool> canEditSubmission(
  AppDatabase db, {
  required String submissionId,
}) async {
  final submission = await db.managers.dataInstances
      .filter((filter) => filter.id(submissionId))
      .getSingleOrNull();
  if (submission == null) return false;

  final assignmentForm = await db.managers.assignmentForms
      .filter((filter) =>
          filter.assignment.id(submission.assignment) &
          filter.form.id(submission.formTemplate))
      .getSingleOrNull();
  if (assignmentForm == null) return false;

  return !submission.syncState.isSynced ||
      assignmentForm.canEditSubmissions == true;
}
