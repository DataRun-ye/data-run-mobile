import 'package:collection/collection.dart'; // For MapEquality
import 'package:meta/meta.dart';

// --- Data Structures for FormTemplate (Minimal) ---

class ValidationRule {
  // e.g., "#{path.to.field} > 10"

  ValidationRule({required this.expression});

  final String expression;
}

class FormElement {
  // Full path, e.g., "sectionName.fieldName" or "sectionName"
  FormElement({required this.id, required this.path});

  final String id;
  final String path;
}

class FieldTemplate extends FormElement {
  FieldTemplate({
    required String id,
    required String path,
    this.validationRule,
  }) : super(id: id, path: path);
  final ValidationRule? validationRule;
}

class SectionTemplate extends FormElement {
  // "children" are not strictly needed for this problem if FormTemplate.fields contains all fields
  // with fully qualified paths, and FormTemplate.sections is for identifying repeatable paths.
  // However, including it for completeness if a more complex template structure were implied.
  // For this solution, we will primarily use FormTemplate.fields and FormTemplate.sections.
  // final List<FormElement> children;

  SectionTemplate({
    required String id,
    required String path,
    this.repeatable = false,
    // this.children = const [],
  }) : super(id: id, path: path);
  final bool repeatable;
}

class FormTemplateModel {
  // Definitions of sections, primarily for 'repeatable' status

  FormTemplateModel({this.fields = const [], this.sections = const []});

  final List<FieldTemplate>
      fields; // All fields in the form, with unique, fully qualified paths
  final List<SectionTemplate> sections;

  // Helper to get all fields. Assumes `fields` list is comprehensive.
  List<FieldTemplate> getAllFields() => fields;

  // Helper to check if a path corresponds to a repeatable section.
  bool isPathRepeatableSection(String path) {
    return sections.any((s) => s.path == path && s.repeatable);
  }
}

// --- CacheKey Implementation ---

@immutable
// ignore: must_be_immutable
class CacheKey {
  CacheKey({
    required this.elementPath,
    this.aggregation,
    this.params,
  }) {
    _hashCode = _computeHashCode();
  }

  final String elementPath;
  final String? aggregation; // e.g., "sum", "avg"
  final Map<String, dynamic>?
      params; // Parameters for aggregation, e.g., {'field': 'age'}

  // Memoized hash code
  int? _hashCode;

  // Precompute hash for immutable object
  int _computeHashCode() {
    // Consistent hashing for params map
    // Sort keys to ensure order doesn't affect hash
    String paramsString = '';
    if (params != null && params!.isNotEmpty) {
      final sortedKeys = params!.keys.toList()..sort();
      final sortedEntries = sortedKeys.map((key) => '$key:${params![key]}');
      paramsString = '{${sortedEntries.join(",")}}';
    }
    return Object.hash(elementPath, aggregation, paramsString);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CacheKey &&
        other.elementPath == elementPath &&
        other.aggregation == aggregation &&
        MapEquality().equals(other.params, params); // Deep equality for map
  }

  @override
  int get hashCode => _hashCode ??= _computeHashCode(); // Use memoized hash

  @override
  String toString() {
    return 'CacheKey(elementPath: $elementPath, aggregation: $aggregation, params: $params)';
  }
}

// --- DependencyIndex Implementation ---

class DependencyIndex {
  DependencyIndex.fromTemplate(FormTemplateModel template)
      : _template = template {
    // Store repeatable section paths
    for (final section in template.sections) {
      if (section.repeatable) {
        _repeatableSectionPaths.add(section.path);
      }
    }

    // Regex to extract dependencies like #{path.to.field}
    final RegExp depRegex = RegExp(r'#\{(.*?)\}');

    for (final field in template.getAllFields()) {
      if (field.validationRule?.expression != null) {
        final String expression = field.validationRule!.expression;
        final Iterable<RegExpMatch> matches = depRegex.allMatches(expression);

        if (matches.isNotEmpty) {
          _forwardDependencies.putIfAbsent(field.path, () => <String>{});
        }

        for (final match in matches) {
          final String dependentPath = match.group(1)!; // The captured path

          // Add to forward dependencies: field.path depends on dependentPath
          _forwardDependencies[field.path]!.add(dependentPath);

          // Add to reverse dependencies: dependentPath is a dependency for field.path
          _reverseDependencies.putIfAbsent(dependentPath, () => <String>{});
          _reverseDependencies[dependentPath]!.add(field.path);
        }
      }
    }
  }

  // _forwardDependencies: fieldPath -> Set of paths it directly depends on.
  final Map<String, Set<String>> _forwardDependencies = {};

  // _reverseDependencies: fieldPath -> Set of paths that directly depend on it.
  final Map<String, Set<String>> _reverseDependencies = {};

  // Set of paths that are repeatable sections.
  final Set<String> _repeatableSectionPaths = {};

  // The FormTemplate, used for checking repeatable sections during invalidation.
  final FormTemplateModel _template;

  /// Gets all direct and transitive dependents of a given path.
  /// If 'A' depends on 'B', and 'B' depends on 'C', then changing 'C' affects 'B' and 'A'.
  /// This function, given 'C', would return {'B', 'A'}.
  List<String> getAffectedFields(String changedFieldId) {
    final List<String> sorted = [];
    final Set<String> visited = {};
    void dfs(String field) {
      if (!visited.contains(field)) {
        visited.add(field);
        // Start with direct dependents
        if (_reverseDependencies.containsKey(field)) {
          for (final dependent in _reverseDependencies[field]!) {
            dfs(dependent);
          }
        }
        sorted.add(field);
      }
    }

    dfs(changedFieldId);
    return sorted.reversed.toList();
  }
}
