import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/repeat_row_edit_session.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_rows_source.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  late AppDatabase db;
  late FormTemplateRepository repository;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    appLocator.registerSingleton<AppDatabase>(db);
    repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/YLcsWJlB7uy-v4.json',
    ));
  });

  tearDown(() async {
    await db.close();
    await appLocator.reset();
  });

  test('existing rows close when pristine and require a decision when changed',
      () {
    final graph = _buildFormInstance(
      repository,
      initialValue: _initialPatients(),
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    graph.instance.materializeRepeatItem(patient);
    final session = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: patients,
      item: patient,
      isNew: false,
    );

    expect(session.isNew, isFalse);
    expect(session.hasChanges, isFalse);
    expect(session.backAction, RepeatRowBackAction.close);

    final patientName = patient.element('PatientName') as FieldInstance<String>;
    patientName.updateValue('Changed name', emitEvent: false);

    expect(session.hasChanges, isTrue);
    expect(session.backAction, RepeatRowBackAction.confirm);

    patientName.updateValue('Original name', emitEvent: false);

    expect(session.hasChanges, isFalse);
    expect(session.backAction, RepeatRowBackAction.close);

    graph.instance.dematerializeRepeatItem(patient);
    graph.instance.dispose();
  });

  test('discard restores an existing row and its nested collection exactly',
      () {
    final graph = _buildFormInstance(
      repository,
      initialValue: _initialPatients(),
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    final tableSource = RepeatTableDataSource(elements: patients.elements);
    graph.instance.materializeRepeatItem(patient);
    final session = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: patients,
      item: patient,
      isNew: false,
    );
    final oldPerformed =
        patient.element('is_test_preformed') as FieldInstance<String>;
    final patientName = patient.element('PatientName') as FieldInstance<String>;
    final investigations = patient.element('investigations') as RepeatSection;

    patientName.updateValue('Changed name', emitEvent: false);
    graph.instance.onRemoveRepeatedItem(0, investigations);
    graph.instance.onAddRepeatedItem(investigations);

    final restored = session.discard()!;
    final restoredInvestigations =
        restored.element('investigations') as RepeatSection;
    final restoredPerformed =
        restored.element('is_test_preformed') as FieldInstance<String>;

    expect(patient.parentSection, isNull);
    expect(patients.elements.single, same(restored));
    expect(() => tableSource.replaceItems(patients.elements), returnsNormally);
    expect(tableSource.elements.single, same(restored));
    expect(restored.uid, '01K0PATIENT00000000000000');
    expect(
      (restored.element('PatientName') as FieldInstance<String>).value,
      'Original name',
    );
    expect(
      restoredInvestigations.elements.map((item) => item.uid),
      <String>[
        '01K0INVESTIGATION000000000',
        '01K0INVESTIGATION000000001',
      ],
    );
    expect(oldPerformed.dependents, isEmpty);
    expect(restoredPerformed.dependents, contains(restoredInvestigations));
    expect(graph.instance.form.pristine, isTrue);

    restoredPerformed.updateValue('no', emitEvent: false);
    expect(restoredInvestigations.hidden, isTrue);
    restoredPerformed.updateValue('yes', emitEvent: false);
    expect(restoredInvestigations.visible, isTrue);

    graph.instance.dispose();
  });

  test('discarding a nested edit restores its identity and row-local rules',
      () {
    final graph = _buildFormInstance(
      repository,
      initialValue: _initialPatients(),
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    graph.instance.materializeRepeatItem(patient);
    final investigations = patient.element('investigations') as RepeatSection;
    final investigation = investigations.elements.first;
    graph.instance.materializeRepeatItem(investigation);
    final session = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: investigations,
      item: investigation,
      isNew: false,
    );
    final labType =
        investigation.element('lab_test_type') as FieldInstance<String>;

    labType.updateValue('none', emitEvent: false);
    expect(session.backAction, RepeatRowBackAction.confirm);

    final restored = session.discard()!;
    final restoredLabType =
        restored.element('lab_test_type') as FieldInstance<String>;
    final restoredResult =
        restored.element('test_result') as FieldInstance<String>;

    expect(investigation.parentSection, isNull);
    expect(restored.uid, '01K0INVESTIGATION000000000');
    expect(restoredLabType.value, 'mrdt');
    expect(restoredResult.visible, isTrue);

    graph.instance.dematerializeRepeatItem(patient);
    graph.instance.dispose();
  });

  test('nested save stays in the outer working copy until outer save',
      () async {
    final graph = _buildFormInstance(
      repository,
      initialValue: _initialPatients(),
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    graph.instance.materializeRepeatItem(patient);
    final outerSession = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: patients,
      item: patient,
      isNew: false,
    );
    final investigations = patient.element('investigations') as RepeatSection;
    final investigation = investigations.elements.first;
    graph.instance.materializeRepeatItem(investigation);
    final nestedSession = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: investigations,
      item: investigation,
      isNew: false,
    );
    final labType =
        investigation.element('lab_test_type') as FieldInstance<String>;

    labType.updateValue('none', emitEvent: false);
    await nestedSession.save(enclosingSession: outerSession);
    graph.instance.dematerializeRepeatItem(investigation);

    expect(outerSession.hasChanges, isTrue);
    expect(labType.value, 'none');

    final restoredPatient = outerSession.discard()!;
    final restoredInvestigations =
        restoredPatient.element('investigations') as RepeatSection;
    final restoredLabType = restoredInvestigations.elements.first
        .element('lab_test_type') as FieldInstance<String>;

    expect(restoredLabType.value, 'mrdt');
    graph.instance.dispose();
  });

  test('a nested row saved to its parent reopens as an existing row', () async {
    final graph = _buildFormInstance(
      repository,
      initialValue: _initialPatients(),
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    graph.instance.materializeRepeatItem(patient);
    final outerSession = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: patients,
      item: patient,
      isNew: false,
    );
    final investigations = patient.element('investigations') as RepeatSection;
    final newInvestigation = graph.instance.onAddRepeatedItem(investigations);
    graph.instance.materializeRepeatItem(newInvestigation);
    final newSession = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: investigations,
      item: newInvestigation,
      isNew: true,
    );

    await newSession.save(enclosingSession: outerSession);
    graph.instance.dematerializeRepeatItem(newInvestigation);
    graph.instance.materializeRepeatItem(newInvestigation);
    final reopenedSession = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: investigations,
      item: newInvestigation,
      isNew: false,
    );

    expect(newInvestigation.uid, isNull);
    expect(reopenedSession.isNew, isFalse);
    expect(reopenedSession.backAction, RepeatRowBackAction.close);
    expect(investigations.elements, hasLength(3));

    graph.instance.dematerializeRepeatItem(newInvestigation);
    outerSession.discard();
    graph.instance.dispose();
  });

  test('discarding a new row removes that exact provisional row', () {
    final graph = _buildFormInstance(
      repository,
      initialValue: _initialPatients(),
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final formWasDirty = graph.instance.form.dirty;
    final formWasTouched = graph.instance.form.touched;
    final provisional = graph.instance.onAddRepeatedItem(patients);
    graph.instance.materializeRepeatItem(provisional);
    final session = RepeatRowEditSession(
      formInstance: graph.instance,
      parent: patients,
      item: provisional,
      isNew: true,
      formWasDirtyBeforeEdit: formWasDirty,
      formWasTouchedBeforeEdit: formWasTouched,
    );
    final laterRow = graph.instance.onAddRepeatedItem(patients);

    expect(session.isNew, isTrue);
    expect(session.hasChanges, isFalse);
    expect(session.backAction, RepeatRowBackAction.discard);
    expect(graph.instance.form.dirty, isTrue);

    session.discard();

    expect(provisional.parentSection, isNull);
    expect(patients.elements, hasLength(2));
    expect(patients.elements.last, same(laterRow));
    expect(patients.elements, isNot(contains(provisional)));
    expect(graph.instance.form.pristine, isTrue);

    graph.instance.dispose();
  });
}

Map<String, Object?> _initialPatients() => <String, Object?>{
      'patients': [
        <String, Object?>{
          '_id': '01K0PATIENT00000000000000',
          'PatientName': 'Original name',
          'is_test_preformed': 'yes',
          'investigations': [
            <String, Object?>{
              '_id': '01K0INVESTIGATION000000000',
              'lab_test_type': 'mrdt',
              'test_result': 'positive',
            },
            <String, Object?>{
              '_id': '01K0INVESTIGATION000000001',
              'lab_test_type': 'microscopy',
              'test_result': 'negative',
            },
          ],
        },
      ],
    };

({FormInstance instance, Section root}) _buildFormInstance(
  FormTemplateRepository repository, {
  required Map<String, Object?> initialValue,
}) {
  final form = FormGroup(
    FormElementControlBuilder.formDataControls(repository, initialValue),
  );
  final root = Section(
    template: repository.rootSection,
    form: form,
    elements: FormElementBuilder.buildFormElements(
      form,
      repository,
      initialFormValue: initialValue,
    ),
  )
    ..bindControlReferences()
    ..resolveDependencies()
    ..evaluate(emitEvent: false);
  final instance = FormInstance(
    submissionId: 'submission-1',
    entryStarted: DateTime(2026),
    enabled: true,
    form: form,
    rootSection: root,
    formFlatTemplate: repository,
    formMetadata: const FormMetadata(
      formId: 'form-id',
      versionUid: 'version-1',
    ),
    fieldKeysRegistery: FieldContextRegistry(),
    initialValue: initialValue,
  );
  return (instance: instance, root: root);
}
