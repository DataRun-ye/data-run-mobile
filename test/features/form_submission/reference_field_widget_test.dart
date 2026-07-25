import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/reference_uid.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reference_search/q_reference_drop_down_search_field.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
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
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'reference-widget-test',
    );
    appLocator.registerSingleton<AppDatabase>(database);
    await _insertAssignment(database);

    final repository = formRepositoryFromJson({
      'uid': 'reference-form-v1',
      'name': 'Reference form',
      'versionUid': 'reference-form-v1',
      'versionNumber': 1,
      'fields': [
        {
          'id': 'reference-field',
          'name': 'referenceField',
          'label': {'en': 'Catalog entry', 'ar': 'عنصر الدليل'},
          'type': 'Reference',
          'mandatory': true,
        },
      ],
      'sections': <Object?>[],
      'options': <Object?>[],
    });
    final form = FormGroup(
      FormElementControlBuilder.formDataControls(repository, const {}),
    );
    final root = Section(
      template: repository.rootSection,
      form: form,
      elements: FormElementBuilder.buildFormElements(
        form,
        repository,
        initialFormValue: const {},
      ),
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

  testWidgets('creates and selects a Reference entirely from local state',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: QReferenceDropDownSearchField(element: referenceField),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Select a reference'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      'First Middle Third Family',
    );
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add New'));
    await tester.pumpAndSettle();

    final uid = referenceField.retainedValue;
    expect(ReferenceUid.isValid(uid), isTrue);
    expect(find.text('First Middle Third Family'), findsOneWidget);
    expect(
      await database.select(database.referenceEntries).get(),
      [
        isA<ReferenceEntry>().having((entry) => entry.uid, 'uid', uid).having(
              (entry) => entry.displayName,
              'displayName',
              'First Middle Third Family',
            ),
      ],
    );
  });
}

Future<void> _insertAssignment(AppDatabase database) async {
  await database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES ('org-1', '{}', 'Org unit', '/org-1', 1);
    INSERT INTO projects (id, translations, name)
    VALUES ('project-1', '{}', 'Project');
    INSERT INTO activities (id, translations, name, project)
    VALUES ('activity-1', '{}', 'Activity', 'project-1');
    INSERT INTO teams (id, activity)
    VALUES ('team-1', 'activity-1');
    INSERT INTO assignments
      (id, activity, team, org_unit, sync_state, disabled)
    VALUES
      ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0);
  ''');
}
