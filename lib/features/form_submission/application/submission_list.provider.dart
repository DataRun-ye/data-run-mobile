import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/features/form_submission/application/submission_edit_access.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_list.provider.g.dart';

@riverpod
Future<bool> submissionEditStatus(Ref ref,
    {required String submissionId}) async {
  return canEditSubmission(
    appLocator<AppDatabase>(),
    submissionId: submissionId,
  );
}
