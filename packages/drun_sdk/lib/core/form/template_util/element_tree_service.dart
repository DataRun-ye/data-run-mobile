import 'package:d_sdk/core/form/tree_element.dart';
import 'package:d_sdk/core/util/list_extensions.dart';

enum LookupStrategy { id, name }

LookupStrategy lookupStrategy = LookupStrategy.name;

class ElementTreeService {
  static String? getParentPath<T extends TreeElement>(T element) {
    final parentPath = element.path!.split('.')
      ..removeLast();
    if (parentPath.isEmpty) return null; // Root node has no parent
    return parentPath.join('.');
  }

  static String _normalizedPath(String path) =>
      path.endsWith('.') ? path.substring(0, path.length - 1) : path;

  // runtime paths (i.e might have paths with brackets
  static String _normalizePath(String path) {
    return path.replaceAllMapped(
        RegExp(r'\[\d+\]|\[\*\]|\[\d+\.\.\d+\]'), (match) => '');
  }

  static String? getNamePath(TreeElement element) {
    if (element.path == null) return null;
    return element.path!.replaceFirst(element.id, element.name!);
  }

  bool pathExists<T extends TreeElement>(String path, Iterable<T> flatFields) {
    final segments = _normalizePath(path).split('.');
    final templatePaths = flatFields.map((s) => s.path);
    return templatePaths.contains(segments.join('.'));
  }

  static T? getParent<T extends TreeElement>(String fieldPath,
      Iterable<T> flatFields) {
    final parentPath = fieldPath.split('.')
      ..removeLast();
    if (parentPath.isEmpty) return null; // Root node has no parent
    return flatFields.firstOrNullWhere((n) => n.path == parentPath.join('.'));
  }

  static List<T> getImmediateChildren<T extends TreeElement>(String path,
      Iterable<T> flatFields) {
    final normalizedPath = _normalizedPath(path);

    final depth = normalizedPath
        .split('.')
        .length + 1;
    final childElements = flatFields.where((node) {
      return node.path!.startsWith('$normalizedPath.') &&
          node.path!.split('.').length == depth;
    }).toList();
    return childElements;
  }

  /// Get ancestors of a specific path
  static List<T> getAncestors<T extends TreeElement>(String path,
      Iterable<T> flatFields) {
    final ancestors = <T>[];
    while (path != '') {
      final parent = getParent<T>(path, flatFields);
      if (parent != null) {
        ancestors.add(parent);
        path = parent.path!;
      } else {
        break;
      }
    }
    return ancestors.reversed.toList();
  }

  /// Get first descendant by its id
  static T? getFirstById<T extends TreeElement>(String id,
      Iterable<T> flatFields) {
    final element =
    flatFields.firstOrNullWhere((node) => node.path!.endsWith('$id'));
    return element;
  }

  /// Get element by path
  static T? getTemplateByPath<T extends TreeElement>(String path,
      Iterable<T> flatFields) {
    return flatFields.firstOrNullWhere((element) => element.path == path);
  }

  /// Get all descendants of a specific path
  static List<T> getDescendants<T extends TreeElement>(String path,
      Iterable<T> flatFields) {
    return flatFields.where((node) => node.path!.startsWith('$path.')).toList();
  }

  /// Get children of a specific path
  static List<T> getChildren<T extends TreeElement>(String path,
      Iterable<T> flatFields) {
    final normalizedPath = _normalizedPath(path);

    return flatFields
        .where((node) =>
    node.path!.startsWith('$normalizedPath.') &&
        node.path!.split('.').length ==
            normalizedPath
                .split('.')
                .length + 1)
        .toList();
  }

  /// Get ImmediateChildren of a specific path
  static List<T> getChildrenOfType<T extends TreeElement>(String path,
      Iterable<T> flatFields) {
    final normalizedPath =
    path.endsWith('.') ? path.substring(0, path.length - 1) : path;

    return flatFields
        .where((node) =>
    node.path!.startsWith('$normalizedPath.') &&
        node.path!.split('.').length ==
            normalizedPath
                .split('.')
                .length + 1)
        .whereType<T>()
        .toList();
  }

  static T? getScopedDependencyById<T extends TreeElement>(String id,
      String currentPath, Iterable<T> flatFields) {
    final pathSegments = currentPath.split('.');

    // upwards in the path
    for (int i = pathSegments.length - 1; i >= 0; i--) {
      final currentPathSegment = pathSegments.sublist(0, i + 1).join('.');

      // in the current scope
      final element =
      getTemplateByPath<T>(currentPathSegment + '.' + id, flatFields);
      if (element != null) {
        return element;
      }
    }

    // If not found, check the global scope
    final rootElements =
    flatFields.where((element) => element.path!.split('.').length == 1);

    for (final rootElement in rootElements) {
      final scopedElement = getScopedElement<T>(rootElement, id, flatFields);
      if (scopedElement != null) {
        return scopedElement;
      }
    }

    return null;
  }

  static T? getScopedElement<T extends TreeElement>(T rootElement, String id,
      Iterable<T> flatFields) {
    if (rootElement.id == id) {
      return rootElement;
    }

    for (final child in getDescendants<T>(rootElement.path!, flatFields)) {
      final element = getScopedElement<T>(child, id, flatFields);
      if (element != null) {
        return element;
      }
    }
    return null;
  }

  T? getScopedDependencyByName<T extends TreeElement>(String name,
      {required String currentPath, required Iterable<T> flatFields}) {
    final pathSegments = currentPath.split('.');

    // upwards in the path
    for (int i = pathSegments.length - 1; i >= 0; i--) {
      final currentPathSegment = pathSegments.sublist(0, i + 1).join('.');

      // in the current scope
      final element = getTemplateByPath<T>(
        currentPathSegment + '.' + name,
        flatFields,
      );
      if (element != null) {
        return element;
      }
    }

    // If not found, check the global scope
    final rootElements =
    flatFields.where((element) => element.path!.split('.').length == 1);

    for (final rootElement in rootElements) {
      final scopedElement = getScopedElement(
        rootElement,
        name,
        flatFields,
      );
      if (scopedElement != null) {
        return scopedElement;
      }
    }

    return null;
  }
}
