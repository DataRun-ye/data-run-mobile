import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    appLocator.registerSingleton<AppDatabase>(db);
  });

  tearDown(() async {
    await db.close();
    await appLocator.reset();
  });

  test('hidden fields survive toggles but are removed on save and reopen',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/KcsA3KETRbY-v24.json',
    ));
    final initialValue = <String, Object?>{
      '_username': 'test-user',
      'obsoleteFormKey': 'remove-on-save',
      'mcase': <String, Object?>{
        'name': 'John Doe Smith Brown',
        'visitDate': '2026-07-22',
        'age': '2000-01-01',
        'gender': 'MALE',
        'is_test_preformed': 'yes',
      },
      'testDetails': <String, Object?>{
        'testResult': 'positive',
        'detectionType': 'active',
        'severity': 'uncomplicated',
      },
      'cm': <String, Object?>{'treatment': 'retained-only-while-editing'},
    };
    await _insertSubmission(
      db,
      repository: repository,
      submissionId: 'malaria-submission',
      formData: initialValue,
    );
    final graph = _buildFormInstance(
      repository: repository,
      submissionId: 'malaria-submission',
      initialValue: initialValue,
    );
    final main = graph.root.element('mcase') as Section;
    final performed =
        main.element('is_test_preformed') as FieldInstance<String>;
    final testDetails = graph.root.element('testDetails') as Section;
    final testResult =
        testDetails.element('testResult') as FieldInstance<String>;
    final detectionType =
        testDetails.element('detectionType') as FieldInstance<String>;
    final severity = testDetails.element('severity') as FieldInstance<String>;

    performed.updateValue('no', emitEvent: false);

    expect(testDetails.hidden, isTrue);
    expect(testResult.value, 'positive');
    expect(detectionType.value, 'active');
    expect(severity.value, 'uncomplicated');
    expect(graph.root.value, isNot(contains('testDetails')));
    expect(graph.root.value, isNot(contains('cm')));

    performed.updateValue('yes', emitEvent: false);

    expect(testDetails.visible, isTrue);
    expect(testResult.value, 'positive');
    expect(detectionType.value, 'active');
    expect(severity.value, 'uncomplicated');

    performed.updateValue('no', emitEvent: false);
    graph.instance.form.markAsDirty();
    expect(graph.instance.form.dirty, isTrue);
    await graph.instance.saveFormData();
    expect(graph.instance.form.dirty, isTrue);
    await graph.instance.markSubmissionAsFinal();

    final saved = await db.dataInstancesDao.getById('malaria-submission');
    expect(saved!.formData!['_username'], 'test-user');
    expect(saved.formData, isNot(contains('obsoleteFormKey')));
    expect(saved.formData, isNot(contains('testDetails')));
    expect(saved.formData, isNot(contains('cm')));
    expect(saved.syncState, InstanceSyncStatus.finalized);

    final reopened = _buildFormInstance(
      repository: repository,
      submissionId: 'malaria-submission',
      initialValue: saved.formData!,
    );
    final reopenedDetails = reopened.root.element('testDetails') as Section;
    final reopenedResult =
        reopenedDetails.element('testResult') as FieldInstance<String>;

    expect(reopenedDetails.hidden, isTrue);
    expect(reopenedResult.value, isNull);
    graph.instance.dispose();
    reopened.instance.dispose();
  });

  test('hidden nested repeats retain row identity until save projection',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/YLcsWJlB7uy-v4.json',
    ));
    const patientId = '01JABCDEF123456789ABCDEFG';
    const investigationId = '01JZYXWVU987654321ABCDEFG';
    final initialValue = <String, Object?>{
      'patients': [
        <String, Object?>{
          '_id': patientId,
          'is_test_preformed': 'yes',
          'investigations': [
            <String, Object?>{
              '_id': investigationId,
              'lab_test_type': 'mrdt',
              'test_result': 'positive',
            },
          ],
        },
      ],
    };
    await _insertSubmission(
      db,
      repository: repository,
      submissionId: 'lab-submission',
      formData: initialValue,
    );
    final graph = _buildFormInstance(
      repository: repository,
      submissionId: 'lab-submission',
      initialValue: initialValue,
    );
    final patients = graph.root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    final performed =
        patient.element('is_test_preformed') as FieldInstance<String>;
    final investigations = patient.element('investigations') as RepeatSection;
    final labType = investigations.elements.single.element('lab_test_type')
        as FieldInstance<String>;

    performed.updateValue('no', emitEvent: false);

    expect(investigations.hidden, isTrue);
    expect(investigations.elements, hasLength(1));
    expect(labType.value, 'mrdt');
    var projectedPatient =
        (graph.root.value['patients'] as List).single as Map<String, Object?>;
    expect(projectedPatient['_id'], patientId);
    expect(projectedPatient, isNot(contains('investigations')));

    performed.updateValue('yes', emitEvent: false);

    projectedPatient =
        (graph.root.value['patients'] as List).single as Map<String, Object?>;
    final restoredInvestigation = (projectedPatient['investigations'] as List)
        .single as Map<String, Object?>;
    expect(labType.value, 'mrdt');
    expect(restoredInvestigation['_id'], investigationId);

    performed.updateValue('no', emitEvent: false);
    await graph.instance.saveFormData();

    final saved = await db.dataInstancesDao.getById('lab-submission');
    final savedPatient =
        (saved!.formData!['patients'] as List).single as Map<String, dynamic>;
    expect(savedPatient['_id'], patientId);
    expect(savedPatient, isNot(contains('investigations')));

    final reopened = _buildFormInstance(
      repository: repository,
      submissionId: 'lab-submission',
      initialValue: saved.formData!,
    );
    final reopenedPatients = reopened.root.element('patients') as RepeatSection;
    final reopenedInvestigations = reopenedPatients.elements.single
        .element('investigations') as RepeatSection;
    expect(reopenedInvestigations.hidden, isTrue);
    expect(reopenedInvestigations.elements, isEmpty);
    graph.instance.dispose();
    reopened.instance.dispose();
  });
}

({FormInstance instance, Section root}) _buildFormInstance({
  required FormTemplateRepository repository,
  required String submissionId,
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
    submissionId: submissionId,
    entryStarted: DateTime(2026),
    enabled: true,
    initialValue: initialValue,
    form: form,
    rootSection: root,
    formFlatTemplate: repository,
    formMetadata: FormMetadata(
      formId: repository.template.id,
      versionUid: repository.template.versionUid,
      submission: submissionId,
    ),
    fieldKeysRegistery: FieldContextRegistry(),
  );
  return (instance: instance, root: root);
}

Future<void> _insertSubmission(
  AppDatabase db, {
  required FormTemplateRepository repository,
  required String submissionId,
  required Map<String, Object?> formData,
}) {
  return db.into(db.dataInstances).insert(
        DataInstancesCompanion.insert(
          id: submissionId,
          formTemplate: repository.template.id,
          templateVersion: repository.template.versionUid,
          syncState: InstanceSyncStatus.draft,
          isToUpdate: false,
          formData: Value(Map<String, dynamic>.from(formData)),
        ),
      );
}
