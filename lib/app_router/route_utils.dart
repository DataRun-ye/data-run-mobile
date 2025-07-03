import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteUtils {
  // Navigate to the global form templates list
  static void goToFormTemplates(BuildContext context) {
    context.goNamed('formTemplates');
  }

  static void pushToFormTemplates(BuildContext context) {
    context.pushNamed('formTemplates');
  }

  // Navigate to the submissions list of a form (not within assignment context)
  static void goToFormSubmissionsGlobal(BuildContext context, String formId) {
    context.goNamed(
      'formSubmissionsGlobal',
      pathParameters: {'formId': formId},
    );
  }

  static void pushToFormSubmissionsGlobal(BuildContext context, String formId) {
    context.pushNamed(
      'formSubmissionsGlobal',
      pathParameters: {'formId': formId},
    );
  }

  // Navigate to create a submission from the global form context
  static void goToSubmissionCreateFromForm(
      BuildContext context, String formId) {
    context.goNamed(
      'submissionCreateFromForm',
      pathParameters: {'formId': formId},
    );
  }

  static void pushToSubmissionCreateFromForm(
      BuildContext context, String formId) {
    context.pushNamed(
      'submissionCreateFromForm',
      pathParameters: {'formId': formId},
    );
  }

  // Navigate to assignment detail screen
  static void goToAssignmentDetail(BuildContext context, String assignmentId) {
    context.goNamed(
      'assignmentDetail',
      pathParameters: {'assignmentId': assignmentId},
    );
  }

  static void pushToAssignmentDetail(
      BuildContext context, String assignmentId) {
    context.pushNamed(
      'assignmentDetail',
      pathParameters: {'assignmentId': assignmentId},
    );
  }

  // Navigate to form templates screen within an assignment context
  static void goToAssignmentForms(BuildContext context, String assignmentId) {
    context.goNamed(
      'assignmentForms',
      pathParameters: {'assignmentId': assignmentId},
    );
  }

  static void pushToAssignmentForms(BuildContext context, String assignmentId) {
    context.pushNamed(
      'assignmentForms',
      pathParameters: {'assignmentId': assignmentId},
    );
  }

  // Navigate to submissions list of a form within an assignment context
  static void goToAssignmentFormSubmissions(
    BuildContext context,
    String assignmentId,
    String formId,
  ) {
    context.goNamed(
      'assignmentFormSubmissions',
      pathParameters: {
        'assignmentId': assignmentId,
        'formId': formId,
      },
    );
  }

  static void pushToAssignmentFormSubmissions(
    BuildContext context,
    String assignmentId,
    String formId,
  ) {
    context.pushNamed(
      'assignmentFormSubmissions',
      pathParameters: {
        'assignmentId': assignmentId,
        'formId': formId,
      },
    );
  }

  // Navigate to create a submission within an assignment context
  static void goToSubmissionCreateInAssignment(
    BuildContext context,
    String assignmentId,
    String formId,
    String formVersionId,
  ) {
    context.goNamed(
      'submissionCreateInAssignment',
      pathParameters: {
        'assignmentId': assignmentId,
        'formId': formId,
        'formVersionId': formVersionId,
      },
    );
  }

  static void pushToSubmissionCreateInAssignment(
    BuildContext context,
    String assignmentId,
    String formId,
    String formVersionId,
  ) {
    context.pushNamed(
      'submissionCreateInAssignment',
      pathParameters: {
        'assignmentId': assignmentId,
        'formId': formId,
        'formVersionId': formVersionId,
      },
    );
  }
}
