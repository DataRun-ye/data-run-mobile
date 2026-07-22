import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
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

  test('repeat controls exist only while their row editor is active', () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/YLcsWJlB7uy-v4.json',
    ));
    const patientId = '01K0PATIENT00000000000000';
    const investigationId = '01K0INVESTIGATION000000000';
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
        <String, Object?>{
          '_id': '01K0PATIENT00000000000001',
          'is_test_preformed': 'no',
          'investigations': <Object?>[],
        },
      ],
    };
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
    final patients = root.element('patients') as RepeatSection;
    final firstPatient = patients.elements.first;
    final performed =
        firstPatient.element('is_test_preformed') as FieldInstance<String>;
    final investigations =
        firstPatient.element('investigations') as RepeatSection;
    final investigation = investigations.elements.single;
    final labType =
        investigation.element('lab_test_type') as FieldInstance<String>;

    expect(
      patients.elementControl.controls,
      everyElement(isA<FormControl<Map<String, Object?>>>()),
    );
    expect(performed.mountedControl, isNull);
    expect(labType.mountedControl, isNull);
    expect(performed.value, 'yes');
    expect(labType.value, 'mrdt');

    instance.materializeRepeatItem(firstPatient);

    expect(patients.elementControl.controls.first, isA<FormGroup>());
    expect(
      patients.elementControl.controls.last,
      isA<FormControl<Map<String, Object?>>>(),
    );
    expect(performed.mountedControl, isNotNull);
    expect(
      investigations.elementControl.controls.single,
      isA<FormControl<Map<String, Object?>>>(),
    );
    expect(labType.mountedControl, isNull);

    instance.materializeRepeatItem(investigation);
    final investigationControl = investigation.elementControl;
    final controlDisposed = Completer<void>();
    investigationControl.valueChanges.listen(
      null,
      onDone: controlDisposed.complete,
    );

    labType.updateValue('microscopy', emitEvent: false);
    instance.dematerializeRepeatItem(investigation);
    await controlDisposed.future;

    expect(
      investigations.elementControl.controls.single,
      isA<FormControl<Map<String, Object?>>>(),
    );
    expect(labType.mountedControl, isNull);
    expect(labType.value, 'microscopy');
    expect(investigation.uid, investigationId);

    instance.dematerializeRepeatItem(firstPatient);

    expect(
      patients.elementControl.controls,
      everyElement(isA<FormControl<Map<String, Object?>>>()),
    );
    expect(performed.mountedControl, isNull);
    expect(labType.mountedControl, isNull);
    expect(firstPatient.uid, patientId);
    expect(
      (((root.value['patients'] as List).first
              as Map<String, Object?>)['investigations'] as List)
          .cast<Map<String, Object?>>()
          .single['lab_test_type'],
      'microscopy',
    );

    instance.materializeRepeatItem(firstPatient);
    instance.materializeRepeatItem(investigation);

    expect(labType.elementControl.value, 'microscopy');
    expect(investigation.uid, investigationId);

    instance.dematerializeRepeatItem(investigation);
    instance.dematerializeRepeatItem(firstPatient);
    instance.dispose();
  });

  test('dormant required repeat fields remain part of completion validity',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/YLcsWJlB7uy-v4.json',
    ));
    final initialValue = <String, Object?>{
      'patients': [
        <String, Object?>{
          'is_test_preformed': 'yes',
          'investigations': [<String, Object?>{}],
        },
      ],
    };
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
    final patients = root.element('patients') as RepeatSection;
    final patient = patients.elements.single;
    final investigations = patient.element('investigations') as RepeatSection;
    final investigation = investigations.elements.single;
    final labType =
        investigation.element('lab_test_type') as FieldInstance<String>;

    expect(labType.mountedControl, isNull);
    expect(labType.hasErrors, isTrue);
    expect(root.hasErrors, isTrue);

    instance.materializeRepeatItem(patient);
    instance.materializeRepeatItem(investigation);
    labType.updateValue('mrdt', emitEvent: false);
    instance.dematerializeRepeatItem(investigation);
    instance.dematerializeRepeatItem(patient);

    expect(labType.mountedControl, isNull);
    expect(labType.hasErrors, isFalse);
    instance.dispose();
  });

  test('removing a repeat row disposes it before detaching its indexed path',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/YLcsWJlB7uy-v4.json',
    ));
    final initialValue = <String, Object?>{
      'patients': [
        <String, Object?>{
          'is_test_preformed': 'no',
          'investigations': <Object?>[],
        },
      ],
    };
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
    final patients = root.element('patients') as RepeatSection;
    final removed = patients.elements.single;
    final disposed = Completer<void>();
    removed.propertiesChanged.listen(null, onDone: disposed.complete);

    expect(instance.onRemoveRepeatedItem(0, patients), same(removed));
    await disposed.future;

    expect(patients.elements, isEmpty);
    expect(patients.elementControl.controls, isEmpty);
    expect(removed.parentSection, isNull);
    instance.dispose();
  });
}
