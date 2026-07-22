import 'dart:io';

import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('example form templates build and evaluate with repeat rows', () async {
    final files = Directory('example')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .where((file) => !file.path.toLowerCase().contains('submission'))
        .toList()
      ..sort((left, right) => left.path.compareTo(right.path));

    expect(files, isNotEmpty);

    for (final file in files) {
      final template = formTemplateFromJson(await readJsonMap(file.path));
      final repository = FormTemplateRepository.inMemory(
        formTemplateModel: template,
      );
      final initialValue = {
        for (final child in repository.rootSection.children)
          child.name!: _initialValueFor(child),
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

      expect(root.value, isNotNull, reason: file.path);
      root.dispose();
    }
  });
}

Object? _initialValueFor(Template template) {
  if (template is FieldTemplate) {
    return template.defaultValue;
  }

  final section = template as SectionTemplate;
  final row = {
    for (final child in section.children) child.name!: _initialValueFor(child),
  };
  return section.repeatable ? [row] : row;
}
