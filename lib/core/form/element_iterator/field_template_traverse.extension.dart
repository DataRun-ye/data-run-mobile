import 'package:d_sdk/core/form/field_template/field_template.dart';

/// dfs traversal for Template
Iterable<TemplateType> getDfsTemplateIterator<TemplateType extends Template>(
    Template template) sync* {
  if (template is TemplateType) {
    yield template;
  }

  if (template is SectionTemplate) {
    for (final item in template.fields) {
      yield* getDfsTemplateIterator<TemplateType>(item);
    }
  }
}
