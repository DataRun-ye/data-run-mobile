import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';

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
