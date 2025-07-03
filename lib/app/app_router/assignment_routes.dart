import 'package:go_router/go_router.dart';

final assignmentRoutes = <RouteBase>[
  GoRoute(
    path: '/assignments',
    builder: (_, __) => AssignmentListPage(),
    routes: [
      GoRoute(
        path: ':assignmentId',
        builder: (ctx, state) => AssignmentDetailPage(
          assignmentId: state.pathParameters['assignmentId']!,
        ),
        routes: [
          GoRoute(
            path: 'stages/:stageId',
            builder: (ctx, state) => StageFormPage(
              assignmentId: state.pathParameters['assignmentId']!,
              stageId: state.pathParameters['stageId']!,
            ),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/entities/:entityId',
    builder: (ctx, state) => EntityDetailPage(
      entityId: state.pathParameters['entityId']!,
    ),
  ),
];
