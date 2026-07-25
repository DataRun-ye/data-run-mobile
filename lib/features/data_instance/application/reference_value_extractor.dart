import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/value_type.dart';

class ReferenceValueExtractor {
  const ReferenceValueExtractor();

  List<ReferenceValueOccurrence> extract({
    required FormTemplateModel template,
    required Map<String, dynamic>? formData,
  }) {
    if (formData == null) {
      return const [];
    }

    final occurrences = <ReferenceValueOccurrence>[];
    _collectElements(
      elements: template.elementTree,
      container: formData,
      parentPath: '',
      occurrences: occurrences,
    );
    return List.unmodifiable(occurrences);
  }

  void _collectElements({
    required Iterable<Template> elements,
    required Map<Object?, Object?> container,
    required String parentPath,
    required List<ReferenceValueOccurrence> occurrences,
  }) {
    for (final element in elements) {
      final name = element.name;
      if (name == null || name.isEmpty) {
        continue;
      }
      final elementPath = parentPath.isEmpty ? name : '$parentPath.$name';
      final value = container[name];

      if (element is FieldTemplate) {
        if (element.type == ValueType.Reference) {
          _collectFieldValue(
            elementPath: elementPath,
            value: value,
            occurrences: occurrences,
          );
        }
        continue;
      }

      final section = element as SectionTemplate;
      if (value == null) {
        continue;
      }
      if (section.repeatable) {
        if (value is! List) {
          throw _invalidValue(elementPath);
        }
        for (final row in value) {
          if (row is! Map) {
            throw _invalidValue(elementPath);
          }
          _collectElements(
            elements: section.children,
            container: row,
            parentPath: elementPath,
            occurrences: occurrences,
          );
        }
        continue;
      }
      if (value is! Map) {
        throw _invalidValue(elementPath);
      }
      _collectElements(
        elements: section.children,
        container: value,
        parentPath: elementPath,
        occurrences: occurrences,
      );
    }
  }

  void _collectFieldValue({
    required String elementPath,
    required Object? value,
    required List<ReferenceValueOccurrence> occurrences,
  }) {
    if (value == null) {
      return;
    }
    if (value is! String) {
      throw _invalidValue(elementPath);
    }
    if (value.trim().isEmpty) {
      return;
    }
    occurrences.add(
      ReferenceValueOccurrence(elementPath: elementPath, uid: value),
    );
  }

  FormatException _invalidValue(String elementPath) =>
      FormatException('Invalid Reference value at $elementPath');
}

class ReferenceValueOccurrence {
  const ReferenceValueOccurrence({
    required this.elementPath,
    required this.uid,
  });

  final String elementPath;
  final String uid;

  @override
  bool operator ==(Object other) =>
      other is ReferenceValueOccurrence &&
      other.elementPath == elementPath &&
      other.uid == uid;

  @override
  int get hashCode => Object.hash(elementPath, uid);

  @override
  String toString() => 'ReferenceValueOccurrence($elementPath, $uid)';
}
