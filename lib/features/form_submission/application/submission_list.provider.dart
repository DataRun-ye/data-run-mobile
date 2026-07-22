import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_list.provider.g.dart';

@riverpod
Future<bool> submissionEditStatus(Ref ref,
    {required String submissionId}) async {
  final db = appLocator<AppDatabase>();

  final submission = await db.managers.dataInstances
      .filter((f) => f.id(submissionId))
      .getSingleOrNull();

  if (submission == null) return false;

  final isSynced = submission.syncState.isSynced == true;

  final assignmentForm = await db.managers.assignmentForms
      .filter((f) =>
          f.assignment.id(submission.assignment) &
          f.form.id(submission.formTemplate))
      .getSingleOrNull();
  if (assignmentForm == null) return false;
  final editable = assignmentForm.canEditSubmissions == true || !isSynced;
  return editable;
}
