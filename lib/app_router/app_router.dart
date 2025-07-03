import 'package:datarunmobile/app_router/route_registry.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter()
      : _goRouter = GoRouter(
          routes: appRoutes,
          // redirect logic, etc...
        );

  final GoRouter _goRouter;

  /// Form templates root
  void goToFormTemplates() {
    _goRouter.goNamed('formTemplates');
  }

  /// Navigate to form submissions list, with optional assignment context
  void goToFormSubmissions({
    required String formId,
    String? assignmentId,
  }) {
    if (assignmentId != null) {
      _goRouter.goNamed(
        'formSubmissionsByAssignment',
        pathParameters: {
          'assignmentId': assignmentId,
          'formId': formId,
        },
      );
    } else {
      _goRouter.goNamed(
        'formSubmissionsGlobal',
        pathParameters: {
          'formId': formId,
        },
      );
    }
  }

  /// Navigate to form submission creation
  void goToCreateSubmission({
    required String formId,
    String? assignmentId,
  }) {
    if (assignmentId != null) {
      _goRouter.goNamed(
        'submissionCreateByAssignment',
        pathParameters: {
          'assignmentId': assignmentId,
          'formId': formId,
        },
      );
    } else {
      _goRouter.goNamed(
        'submissionCreateFromForm',
        pathParameters: {
          'formId': formId,
        },
      );
    }
  }

  /// Navigate to a specific submission detail screen
  void goToSubmissionDetail(String submissionId) {
    _goRouter.goNamed(
      'submissionDetail',
      pathParameters: {
        'submissionId': submissionId,
      },
    );
  }

  /// Assignment detail with nested forms
  void goToAssignmentDetail(String assignmentId) {
    _goRouter.goNamed(
      'assignmentDetail',
      pathParameters: {
        'assignmentId': assignmentId,
      },
    );
  }

  // push: show screen as modal/stack
  Future<void> pushCreateSubmission({
    required String formId,
    String? assignmentId,
  }) async {
    final pathParams = {
      'formId': formId,
      if (assignmentId != null) 'assignmentId': assignmentId,
    };

    await _goRouter.pushNamed(
      assignmentId != null
          ? 'submissionCreateByAssignment'
          : 'submissionCreateFromForm',
      pathParameters: pathParams,
    );
  }

// pop with result
  void popWithResult<T>(T result) {
    _goRouter.pop<T>(result);
  }

  /// Assignment detail with nested forms
  void logOut() {
    _goRouter.goNamed('logout');
  }

  void pushSync() {
    _goRouter.pushNamed('sync');
  }
}
