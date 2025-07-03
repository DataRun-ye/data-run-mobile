import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submission_edit_screen.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submissions_screen.dart';
import 'package:datarunmobile/home/form_template/application/form_list_filter.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_template_model.dart';
import 'package:datarunmobile/home/form_template/presentation/form_templates_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> formRoutes = [
  GoRoute(
    path: '/forms',
    name: 'formTemplates',
    builder: (context, state) => const FormTemplatesScreen(
      filters: FormListFilter(),
    ),
    routes: [
      GoRoute(
        path: ':formId/submissions',
        name: 'formSubmissionsGlobal',
        builder: (context, state) => SubmissionsScreen(
          formId: state.pathParameters['formId']!,
        ),
      ),
      GoRoute(
        path: ':formId/submissions/create',
        name: 'submissionCreateFromForm',
        builder: (context, state) => SubmissionEditScreen(
          formId: state.pathParameters['formId']!,
          assignmentId: state.uri.queryParameters['assignmentId'], // Optional
        ),
      ),
    ],
  ),
];

Future<void> loadFormModule(String formId) async {
  final alreadyScoped = appLocator.currentScopeName == 'form-$formId';
  if (alreadyScoped) return;

  await appLocator.pushNewScopeAsync(
    scopeName: 'form-$formId',
    init: (getIt) async {
      final formTemplate =
          await appLocator<FormRepository>().fetchTemplate(formId);
      getIt.registerSingleton<FormTemplateModel>(formTemplate);
      getIt.registerLazySingleton(() => FormValidator(formTemplate));
      getIt.registerFactory(() => FormUIBuilder(formTemplate));
      // Add screen or device orientation if needed
      getIt.registerSingleton<ScreenInfo>(ScreenInfo.fromMediaQueryData());
    },
    dispose: () {
      // Optional cleanup logic
    },
  );
}
