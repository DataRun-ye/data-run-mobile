import 'dart:io';

import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/form_template_fixture.dart';

void main() {
  test('repositories expose one stable template tree without duplicate links',
      () async {
    final files = Directory('test/fixtures/live_forms')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .where((file) => !file.path.endsWith('manifest.json'))
        .toList()
      ..sort((left, right) => left.path.compareTo(right.path));

    expect(files, isNotEmpty);

    for (final file in files) {
      final model = formTemplateFromJson(await readJsonMap(file.path));
      final repository = FormTemplateRepository.inMemory(
        formTemplateModel: model,
      );

      final firstRoot = repository.rootSection;
      final secondRoot = repository.rootSection;

      expect(identical(firstRoot, secondRoot), isTrue, reason: file.path);
      expect(
        firstRoot.children.map((template) => template.id),
        orderedEquals(model.elementTree.map((template) => template.id)),
        reason: file.path,
      );

      final templates = <Template>[...model.fields, ...model.sections];
      for (final section in model.sections.whereType<SectionTemplate>()) {
        final expectedChildren = templates
            .where((template) => template.parent == section.id)
            .toList()
          ..sort((left, right) => left.order.compareTo(right.order));

        expect(
          section.children.map((template) => template.id),
          orderedEquals(expectedChildren.map((template) => template.id)),
          reason:
              '${file.path}: ${section.path} must link each child exactly once',
        );
      }
    }
  });
}
