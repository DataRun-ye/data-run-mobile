import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/form/rule/rule_parse_extension.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';

/// Finds `#{name}` references in a form version that name no field or section
/// of that version.
///
/// The form engine skips such a check, condition, calculation or choice filter
/// without a trace, so a form published with a misspelled name (as ITN v29
/// was) looks fine on the phone while its checks never run.
abstract final class FormReferenceCheck {
  static final RegExp _reference = RegExp(r'#\{(.*?)\}');

  /// Unknown names, keyed by the element (or option list) that uses them.
  static Map<String, Set<String>> unknownReferences(
    FormTemplateModel template,
  ) {
    final elements = <Template>[...template.fields, ...template.sections];
    final known = {
      for (final element in elements)
        if (element.name != null) element.name!,
    };
    final unknown = <String, Set<String>>{};

    void check(String owner, Iterable<String> names) {
      final missing = names.where((name) => !known.contains(name)).toSet();
      if (missing.isNotEmpty) {
        unknown.putIfAbsent(owner, () => <String>{}).addAll(missing);
      }
    }

    for (final element in elements) {
      final owner = element.path ?? element.name ?? element.id;
      check(owner, element.dependencies);
      check(owner, element.calculationDependencies);
      if (element is FieldTemplate && element.choiceFilter != null) {
        check(owner, _names(element.choiceFilter!));
      }
    }
    for (final option in template.options) {
      final filter = option.filterExpression;
      if (filter != null) {
        check(option.listName ?? option.name, _names(filter));
      }
    }
    return unknown;
  }

  static Iterable<String> _names(String expression) =>
      _reference.allMatches(expression).map((match) => match.group(1)!);
}
