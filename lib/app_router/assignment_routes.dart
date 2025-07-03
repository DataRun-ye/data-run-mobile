import 'package:datarunmobile/home/assignment/presentation/assignment_detail_screen.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submission_edit_screen.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submissions_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> assignmentRoutes = [
  GoRoute(
    path: '/assignments/:assignmentId',
    name: 'assignmentDetail',
    builder: (context, state) => AssignmentDetailScreen(
      assignmentId: state.pathParameters['assignmentId']!,
    ),
    routes: [
      GoRoute(
        path: 'forms/:formId/submissions',
        name: 'formSubmissionsByAssignment',
        builder: (context, state) => SubmissionsScreen(
          formId: state.pathParameters['formId']!,
          assignmentId: state.pathParameters['assignmentId'],
        ),
      ),
      GoRoute(
        path: 'forms/:formId/submissions/create',
        name: 'submissionCreateByAssignment',
        builder: (context, state) => SubmissionEditScreen(
          formId: state.pathParameters['formId']!,
          assignmentId: state.pathParameters['assignmentId'],
        ),
      ),
    ],
  ),
];
