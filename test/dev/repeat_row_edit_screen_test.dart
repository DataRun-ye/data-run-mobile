import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/repeat_row_edit_session.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_screen.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_row_edit_result.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  late AppDatabase db;
  late _EditHarness harness;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    appLocator.registerSingleton<AppDatabase>(db);
    appLocator.registerSingleton<FieldContextRegistry>(FieldContextRegistry());
    harness = _buildHarness();
    appLocator.registerSingleton<FormInstance>(harness.instance);
  });

  tearDown(() async {
    harness.instance.dispose();
    await db.close();
    await appLocator.reset();
  });

  testWidgets('system back closes an existing pristine row without a dialog',
      (tester) async {
    harness.session.action = RepeatRowBackAction.close;
    await _pumpHost(tester, harness);

    await tester.tap(find.text('Open editor'));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsNothing);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Open editor'), findsOneWidget);
    expect(harness.result, isNull);
  });

  testWidgets('a changed invalid row can be discarded or kept open',
      (tester) async {
    harness.session
      ..action = RepeatRowBackAction.confirm
      ..saveable = false;
    await _pumpHost(tester, harness);
    final baselineBarrierCount = find.byType(ModalBarrier).evaluate().length;

    await tester.tap(find.text('Open editor'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Unsaved changes'), findsOneWidget);
    expect(find.text('Save'), findsNothing);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(EditRowScreen), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();

    expect(harness.result, RepeatRowEditResult.discarded);
    expect(find.text('Open editor'), findsOneWidget);
    expect(find.byType(ModalBarrier), findsNWidgets(baselineBarrierCount));
  });

  testWidgets('save persists once and returns a typed result', (tester) async {
    harness.session
      ..action = RepeatRowBackAction.confirm
      ..saveable = true;
    await _pumpHost(tester, harness);

    await tester.tap(find.text('Open editor'));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsNWidgets(2));

    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(harness.saveCount, 1);
    expect(harness.result, RepeatRowEditResult.saved);
    expect(find.text('Open editor'), findsOneWidget);
  });

  testWidgets('back can save a changed valid row through the same result path',
      (tester) async {
    harness.session
      ..action = RepeatRowBackAction.confirm
      ..saveable = true;
    await _pumpHost(tester, harness);

    await tester.tap(find.text('Open editor'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Unsaved changes'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(harness.saveCount, 1);
    expect(harness.result, RepeatRowEditResult.saved);
  });

  testWidgets('a failed save leaves the row editor open and retryable',
      (tester) async {
    harness.session.saveable = true;
    harness.saveError = StateError('save failed');
    await _pumpHost(tester, harness);

    await tester.tap(find.text('Open editor'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save'));
    await tester.pump();

    expect(harness.reportedError, isA<StateError>());
    expect(find.byType(EditRowScreen), findsOneWidget);
    expect(harness.result, isNull);

    harness.saveError = null;
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(harness.result, RepeatRowEditResult.saved);
  });

  testWidgets('system back discards a new pristine row without prompting',
      (tester) async {
    harness.session.action = RepeatRowBackAction.discard;
    await _pumpHost(tester, harness);

    await tester.tap(find.text('Open editor'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Unsaved changes'), findsNothing);
    expect(harness.result, RepeatRowEditResult.discarded);
  });
}

Future<void> _pumpHost(WidgetTester tester, _EditHarness harness) {
  return tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                harness.result =
                    await Navigator.of(context).push<RepeatRowEditResult>(
                  MaterialPageRoute(
                    builder: (_) => FormMetadataWidget(
                      formMetadata: harness.instance.formMetadata,
                      child: ReactiveForm(
                        formGroup: harness.item.elementControl,
                        child: EditRowScreen(
                          item: harness.item,
                          session: harness.session,
                          onSave: () async {
                            harness.saveCount++;
                            final error = harness.saveError;
                            if (error != null) {
                              throw error;
                            }
                          },
                          onSaveError: (error, stackTrace) {
                            harness.reportedError = error;
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Open editor'),
            ),
          ),
        ),
      ),
    ),
  );
}

_EditHarness _buildHarness() {
  final repeatTemplate = SectionTemplate(
    id: 'items-id',
    name: 'items',
    path: 'items',
    repeatable: true,
  );
  final repository = FormTemplateRepository.inMemory(
    formTemplateModel: FormTemplateModel(
      id: 'form-id',
      name: 'test-form',
      versionUid: 'version-id',
      versionNumber: 1,
      fields: BuiltList<Template>(),
      sections: BuiltList<Template>([repeatTemplate]),
      options: BuiltList<FormOption>(),
    ),
  );
  final form = FormGroup({
    'items': FormArray<Map<String, Object?>>([
      FormGroup({}),
    ]),
  });
  final item = RepeatItemInstance(
    template: repeatTemplate,
    form: form,
    uid: '01K0ROW000000000000000000',
  );
  final parent = RepeatSection(
    template: repeatTemplate,
    form: form,
    elements: [item],
  );
  final root = Section(
    template: repository.rootSection,
    form: form,
    elements: {'items': parent},
  )..bindControlReferences();
  final instance = FormInstance(
    submissionId: 'submission-1',
    entryStarted: DateTime(2026),
    enabled: true,
    form: form,
    rootSection: root,
    formFlatTemplate: repository,
    formMetadata: const FormMetadata(
      formId: 'form-id',
      versionUid: 'version-id',
    ),
    fieldKeysRegistery: appLocator<FieldContextRegistry>(),
  );
  final session = _TestEditSession(
    formInstance: instance,
    parent: parent,
    item: item,
  );
  return _EditHarness(instance: instance, item: item, session: session);
}

class _TestEditSession extends RepeatRowEditSession {
  _TestEditSession({
    required super.formInstance,
    required super.parent,
    required super.item,
  }) : super(isNew: false);

  RepeatRowBackAction action = RepeatRowBackAction.close;
  bool saveable = false;

  @override
  RepeatRowBackAction get backAction => action;

  @override
  bool get canSave => saveable;
}

class _EditHarness {
  _EditHarness({
    required this.instance,
    required this.item,
    required this.session,
  });

  final FormInstance instance;
  final RepeatItemInstance item;
  final _TestEditSession session;
  RepeatRowEditResult? result;
  int saveCount = 0;
  Object? saveError;
  Object? reportedError;
}
