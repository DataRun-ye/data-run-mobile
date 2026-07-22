import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

  test('disposing a form instance releases its scoped form graph', () async {
    final form = FormGroup({
      'details': FormGroup({}),
      'items': FormArray<Map<String, Object?>>([
        FormGroup({
          'children': FormArray<Map<String, Object?>>([
            FormGroup({}),
          ]),
        }),
      ]),
    });
    final child = Section(
      template: SectionTemplate(
        id: 'details-section',
        path: 'details',
        name: 'details',
      ),
      form: form,
    );
    final repeatTemplate = SectionTemplate(
      id: 'items-section',
      path: 'items',
      name: 'items',
      repeatable: true,
    );
    final nestedRepeatTemplate = SectionTemplate(
      id: 'children-section',
      parent: 'items-section',
      path: 'items.children',
      name: 'children',
      repeatable: true,
    );
    final nestedRow = RepeatItemInstance(
      template: nestedRepeatTemplate,
      form: form,
    );
    final nestedRepeat = RepeatSection(
      template: nestedRepeatTemplate,
      form: form,
      elements: [nestedRow],
    );
    final repeatRow = RepeatItemInstance(
      template: repeatTemplate,
      form: form,
      elements: {'children': nestedRepeat},
    );
    final repeat = RepeatSection(
      template: repeatTemplate,
      form: form,
      elements: [repeatRow],
    );
    final root = Section(
      template: SectionTemplate(id: 'form-id', path: ''),
      form: form,
      elements: {
        'details': child,
        'items': repeat,
      },
    );
    final registry = FieldContextRegistry();
    registry.getOrCreateKey('details');
    final instance = FormInstance(
      submissionId: 'submission-1',
      entryStarted: DateTime(2026),
      enabled: true,
      form: form,
      rootSection: root,
      formFlatTemplate: _emptyTemplateRepository(),
      formMetadata: const FormMetadata(
        formId: 'form-id',
        versionUid: 'version-1',
      ),
      fieldKeysRegistery: registry,
    );
    final rootDone = Completer<void>();
    final childDone = Completer<void>();
    final repeatDone = Completer<void>();
    final nestedRepeatDone = Completer<void>();
    final nestedRowDone = Completer<void>();
    final formDone = Completer<void>();
    root.propertiesChanged.listen(null, onDone: rootDone.complete);
    child.propertiesChanged.listen(null, onDone: childDone.complete);
    repeat.collectionChanges.listen(null, onDone: repeatDone.complete);
    nestedRepeat.collectionChanges
        .listen(null, onDone: nestedRepeatDone.complete);
    nestedRow.propertiesChanged.listen(null, onDone: nestedRowDone.complete);
    form.valueChanges.listen(null, onDone: formDone.complete);

    instance.dispose();
    instance.dispose();

    await Future.wait([
      rootDone.future,
      childDone.future,
      repeatDone.future,
      nestedRepeatDone.future,
      nestedRowDone.future,
      formDone.future,
    ]);
    expect(root.elements, isEmpty);
    expect(repeat.elements, isEmpty);
    expect(nestedRepeat.elements, isEmpty);
    expect(repeatRow.parentSection, isNull);
    expect(nestedRow.parentSection, isNull);
    expect(instance.forElementMap, isEmpty);
  });
}

FormTemplateRepository _emptyTemplateRepository() {
  return FormTemplateRepository.inMemory(
    formTemplateModel: FormTemplateModel(
      id: 'form-id',
      name: 'form',
      versionUid: 'version-1',
      versionNumber: 1,
      fields: BuiltList<Template>(),
      sections: BuiltList<Template>(),
      options: BuiltList<FormOption>(),
    ),
  );
}
