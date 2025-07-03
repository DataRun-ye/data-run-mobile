import 'package:datarunmobile/app_router/assignment_routes.dart';
import 'package:datarunmobile/app_router/form_routes.dart';
import 'package:datarunmobile/app_router/submission_routes.dart';
import 'package:go_router/go_router.dart';

final appRoutes = <RouteBase>[
  ...formRoutes,
  ...assignmentRoutes,
  ...submissionRoutes,
];
