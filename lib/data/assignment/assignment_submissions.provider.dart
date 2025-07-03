import 'dart:io';

import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/form_submission/submission_list.provider.dart';
import 'package:datarunmobile/data/team/teams.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_submissions.provider.g.dart';

/// retrieve a certain assignment forms submissions
@riverpod
class AssignmentSubmissions extends _$AssignmentSubmissions {
  @override
  Future<List<DataSubmission>> build(String assignmentId,
      {required String form}) async {
    final submissions = await ref.watch(formSubmissionsProvider(form).future);

    final futures = submissions
        .where((s) => s.assignment == assignmentId)
        .map((submission) async {
      return submission;
      // ..formVersion =
      // await DSdk.db.managers.formVersions
      //     .filter((f) => f.id(submission.formVersion))
      //     .getSingleOrNull();
      /*await D2Remote.formModule.formTemplateV
            .byId(submission.formVersion is String
                ? submission.formVersion
                : submission.formVersion.id)
            .getOne();*/
    }).toList();

    final submissionsWithTemplate = await Future.wait<DataSubmission>(futures);
    return submissionsWithTemplate;
  }
}
