import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/data/reference_uid.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reference_search/q_reference_drop_down_search_field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_rows_source.dart';
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
    await _pumpLocalized(
      tester,
      QReferenceDropDownSearchField(element: referenceField),
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

  testWidgets('keeps the empty Reference hint below its field label',
      (tester) async {
    await _pumpLocalized(
      tester,
      QReferenceDropDownSearchField(element: referenceField),
    );
    await tester.pumpAndSettle();

    final decorator = tester.widget<InputDecorator>(
      find.byType(InputDecorator),
    );
    expect(
      decorator.decoration.floatingLabelBehavior,
      FloatingLabelBehavior.always,
    );
    expect(find.text('Catalog entry *'), findsOneWidget);
    expect(find.text('Select a reference'), findsOneWidget);
  });

  testWidgets('keeps the create action above the keyboard', (tester) async {
    await _pumpLocalized(
      tester,
      QReferenceDropDownSearchField(element: referenceField),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Select a reference'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'New Person Name Here');
    await tester.pumpAndSettle();

    tester.view.viewInsets = const FakeViewPadding(bottom: 180);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();

    final keyboardInset =
        MediaQuery.viewInsetsOf(tester.element(find.text('Add New'))).bottom;
    expect(keyboardInset, greaterThan(0));
    final keyboardTop =
        tester.view.physicalSize.height / tester.view.devicePixelRatio -
            keyboardInset;
    expect(
      tester.getBottomRight(find.text('Add New')).dy,
      lessThan(keyboardTop),
    );
  });

  testWidgets('selects and restores an existing Reference by display name',
      (tester) async {
    await database.into(database.referenceEntries).insert(
          const ReferenceEntry(
            uid: 'a1234567890',
            orgUnitUid: 'org-1',
            displayName: 'Existing Person Name Here',
          ),
        );

    await _pumpLocalized(
      tester,
      QReferenceDropDownSearchField(element: referenceField),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Select a reference'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Existing Person Name Here'));
    await tester.pumpAndSettle();

    expect(referenceField.retainedValue, 'a1234567890');
    expect(find.text('Existing Person Name Here'), findsOneWidget);
    expect(find.text('a1234567890'), findsNothing);

    await tester.tap(find.text('Existing Person Name Here'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.text('Existing Person Name Here'), findsNWidgets(2));
  });

  testWidgets('Reference selection settles with the production value listener',
      (tester) async {
    await database.into(database.referenceEntries).insert(
          const ReferenceEntry(
            uid: 'a1234567890',
            orgUnitUid: 'org-1',
            displayName: 'Existing Person Name Here',
          ),
        );
    var valueEvents = 0;
    final subscription =
        referenceField.elementControl.valueChanges.listen((value) {
      valueEvents++;
      referenceField.handleControlValueChanged(value);
    });
    addTearDown(subscription.cancel);

    await _pumpLocalized(
      tester,
      QReferenceDropDownSearchField(element: referenceField),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select a reference'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Existing Person Name Here'));
    await tester.pumpAndSettle();

    expect(referenceField.retainedValue, 'a1234567890');
    expect(valueEvents, lessThan(5));
  });

  testWidgets('preserves a missing UID and shows a neutral fallback',
      (tester) async {
    referenceField.updateValue('a1234567890');

    await _pumpLocalized(
      tester,
      QReferenceDropDownSearchField(element: referenceField),
    );
    await tester.pumpAndSettle();

    expect(referenceField.retainedValue, 'a1234567890');
    expect(find.textContaining('a123…7890'), findsOneWidget);
    expect(find.text('a1234567890'), findsNothing);
  });

  testWidgets('repeat-table display resolves a Reference UID to its name',
      (tester) async {
    await ReferenceEntryRepository(database).insertLocal(
      const ReferenceEntry(
        uid: 'a1234567890',
        orgUnitUid: 'org-1',
        displayName: 'Existing Person Name Here',
      ),
    );
    referenceField.updateValue('a1234567890');
    final tableSource = RepeatTableDataSource(
      referenceAssignmentUid: 'assignment-1',
    );
    addTearDown(tableSource.dispose);

    await _pumpLocalized(
      tester,
      tableSource.userFriendlyValue(referenceField),
    );
    await tester.pumpAndSettle();

    expect(find.text('Existing Person Name Here'), findsOneWidget);
    expect(find.text('a1234567890'), findsNothing);
  });
}

Future<void> _pumpLocalized(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
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
