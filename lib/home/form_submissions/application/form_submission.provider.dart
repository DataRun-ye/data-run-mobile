import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/home/form_submissions/domain/service/form_instance_service.dart';
import 'package:datarunmobile/home/form_submissions/domain/service/form_instance_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_submission.provider.g.dart';

@riverpod
Future<List<SubmissionSummary>> formSubmissions(Ref ref,
    {SubmissionsFilter? filter, required String formId}) async {
  final submissionService =
      appLocator<FormInstanceService>(param1: formId);
  return submissionService.fetchByFilter(filter);
}

@riverpod
Future<DataSubmission> formSubmission(Ref ref,
    {required String submissionId}) async {
  final submission = await appLocator<DbManager>()
      .db
      .managers
      .dataSubmissions
      .filter((f) => f.id(submissionId))
      .getSingle();
  return submission;
}
