import 'package:datarunmobile/home/form_submissions/presentation/submission_detail_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> submissionRoutes = [
  GoRoute(
    path: '/submissions/:submissionId',
    name: 'submissionDetail',
    builder: (context, state) => SubmissionDetailViewScreen(
      submissionId: state.pathParameters['submissionId']!,
    ),
  ),
];
