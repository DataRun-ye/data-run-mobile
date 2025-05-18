import 'package:d_sdk/core/form/element_template/element_template.dart';

/// dfs traversal for Template
Iterable<TemplateType> getDfsTemplateIterator<TemplateType extends Template>(
    Template template) sync* {
  if (template is TemplateType) {
    yield template;
  }

  if (template is SectionTemplate) {
    for (final item in template.children) {
      yield* getDfsTemplateIterator<TemplateType>(item);
    }
  }
}
