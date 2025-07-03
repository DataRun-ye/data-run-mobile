import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarunmobile/home/activity/presentation/activity_list_page.dart';
import 'package:datarunmobile/home/assignment/presentation/assignment_list_screen.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submission_edit_screen.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submissions_screen.dart';
import 'package:datarunmobile/home/form_template/application/form_list_filter.dart';
import 'package:datarunmobile/home/form_template/presentation/form_templates_screen.dart';
import 'package:datarunmobile/home/scaffolds/scaffold_with_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => SplashScreen()),
    GoRoute(path: '/login', builder: (_, __) => LoginScreen()),
    // Main dashboard shell with persistent header/FAB
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // Dashboard Home
        // Dashboard Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/',
              name: AppRoute.dashboard.name,
              builder: (_, __) => DashboardScreen(),
            ),
          ],
        ),

        // Activities Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/activities',
              name: AppRoute.activities.name,
              builder: (_, __) {
                return ActivityListPage();
              },
              routes: [
                GoRoute(
                    path: 'forms',
                    name: AppRoute.activityForms.name,
                    builder: (context, state) {
                      return FormTemplatesScreen(
                        filters: FormListFilter(),
                      );
                    }),
                GoRoute(
                  path: 'forms/:formId/submissions',
                  name: AppRoute.formSubmissions.name,
                  builder: (context, state) => SubmissionsScreen(
                    formId: state.pathParameters['formId']!,
                    activity: state.uri.queryParameters['activityId'], // nullable filter
                    assignmentId: state.uri.queryParameters['assignmentId'], // nullable filter
                  ),
                ),
                GoRoute(
                  path: 'submissions/:submissionId',
                  name: AppRoute.formSubmissionEdit.name,
                  builder: (context, state) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final formInstance = ref.watch(formInstanceProvider(
                            formMetadata: FormMetadataWidget.of(context)));
                        if (formInstance.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (formInstance.hasError) {
                          return getErrorWidget(
                              formInstance.error, formInstance.stackTrace);
                        }
                        return SubmissionEditScreen(
                          formId: state.pathParameters['formId']!,
                          assignmentId: state
                              .uri.queryParameters['assignmentId'], // Optional
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: ErrorView(state.error),
  ),
);

enum AppRoute {
  dashboard('/'),
  activities('/activities'),
  activityForms('activity-forms'),
  formSubmissions('formSubmissions'),
  formSubmissionEdit('formSubmissionEdit'),
  formCreate('form-create'),
  assignments('/assignments'),
  assignmentDetail('assignment-detail'),
  ;

  final String path;

  const AppRoute(this.path);

  String get name => toString().split('/').last;
}

// // Helper functions for parameter parsing
// DateRange _parseDateRange(Map<String, String> params) {
//   // Implementation for date range parsing
// }
//
// AssignmentFilters _parseAssignmentFilters(Map<String, String> params) {
//   // Implementation for filter parsing
// }
