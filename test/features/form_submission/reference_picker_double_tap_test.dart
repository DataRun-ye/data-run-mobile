// The household picker opens only after a lookup of the village's other
// submissions. A second tap during that lookup must not open a second picker:
// the stale one stays open and a pick there silently replaces the first.
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reference_search/q_reference_drop_down_search_field.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:drift/drift.dart' show QueryInterceptor, QueryExecutor, ApplyInterceptor;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../dev/support/form_template_fixture.dart';

void main() {
  late AppDatabase database;
  late FormInstance formInstance;
  late ReferenceFieldInstance referenceField;

  setUp(() async {
    await appLocator.reset();
    database = AppDatabase(executor: NativeDatabase.memory().interceptWith(_SlowSubmissionReads()), userId: 'dt');
    appLocator.registerSingleton<AppDatabase>(database);
    await database.customStatement('''
      INSERT INTO org_units (id, translations, name, path, level)
      VALUES ('org-1', '{}', 'Org unit', '/org-1', 1);
      INSERT INTO projects (id, translations, name) VALUES ('project-1', '{}', 'Project');
      INSERT INTO activities (id, translations, name, project)
      VALUES ('activity-1', '{}', 'Activity', 'project-1');
      INSERT INTO teams (id, activity) VALUES ('team-1', 'activity-1');
      INSERT INTO assignments (id, activity, team, org_unit, sync_state, disabled)
      VALUES ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0);
    ''');
    final repository = formRepositoryFromJson({
      'uid': 'reference-form-v1',
      'name': 'Reference form',
      'versionUid': 'reference-form-v1',
      'versionNumber': 1,
      'fields': [
        {
          'id': 'reference-field',
          'name': 'referenceField',
          'label': {'en': 'Catalog entry'},
          'type': 'Reference',
          'mandatory': true,
        },
      ],
      'sections': <Object?>[],
      'options': <Object?>[],
    });
    final form = FormGroup(
        FormElementControlBuilder.formDataControls(repository, const {}));
    final root = Section(
      template: repository.rootSection,
      form: form,
      elements: FormElementBuilder.buildFormElements(form, repository,
          initialFormValue: const {}),
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);
    formInstance = FormInstance(
      submissionId: 'submission-1',
      entryStarted: DateTime.utc(2026, 7, 25),
      enabled: true,
      form: form,
      rootSection: root,
      formFlatTemplate: repository,
      formMetadata: const FormMetadata(
        formId: 'reference-form',
        versionUid: 'reference-form-v1',
        assignmentId: 'assignment-1',
      ),
      fieldKeysRegistery: FieldContextRegistry(),
    );
    referenceField = root.element('referenceField') as ReferenceFieldInstance;
    appLocator.registerSingleton<FormInstance>(formInstance);
  });

  tearDown(() async {
    formInstance.dispose();
    await database.close();
    await appLocator.reset();
  });

  testWidgets('a second tap while the picker is opening opens no second picker', (tester) async {
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(body: QReferenceDropDownSearchField(element: referenceField)),
    ));
    await tester.pumpAndSettle();
    final field = find.byType(InkWell).first;
    await tester.tap(field);
    await tester.pump(const Duration(milliseconds: 150));
    await tester.tap(field, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
  });
}

/// Phones read submissions on a background isolate and decode them on the UI
/// thread; with several village submissions this takes a few hundred ms.
class _SlowSubmissionReads extends QueryInterceptor {
  @override
  Future<List<Map<String, Object?>>> runSelect(
      QueryExecutor executor, String statement, List<Object?> args) async {
    if (statement.contains('"data_instances"')) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
    }
    return executor.runSelect(statement, args);
  }
}
