part of '../form_element.dart';

extension ElementDependencyHandler<T> on FormElementInstance<T> {
  static calculationFriendlyValue(FormElementInstance<dynamic> dependency) {
    if (!dependency.visible) {
      return dependency.template.isNumeric
          ? 0
          : dependency.template.type!.isBoolean
              ? false
              : null;
    } else if (dependency.template.isNumeric &&
        dependency.elementControl!.value == null) {
      return 0;
    } else if (dependency.template.type!.isBoolean &&
        dependency.elementControl!.value == null) {
      return false;
    } else {
      return dependency.elementControl!.value;
    }
  }

  /// the element use name to find the dependency in closest parent
  /// and register itself and add them to their dependencies
  FormElementInstance<dynamic>? findElementInParentSection(String name) {
    FormElementInstance<dynamic>? current = this;

    while (current?.parentSection != null) {
      current = current?.parentSection;
      final found = current?.findElement(name);
      if (found != null) return found;
    }

    return walkTreeForDependency(current!, name);
  }

  /// Recursively walk through all elements in the form tree and find a match
  FormElementInstance<dynamic>? walkTreeForDependency(
      FormElementInstance<dynamic> current, String name) {
    if (current.name == name) {
      return current;
    }

    if (current is SectionElement) {
      final childElements = current is Section
          ? current.elements.values
          : (current as RepeatSection).elements;
      for (var nestedElement in childElements) {
        var result = walkTreeForDependency(nestedElement, name);
        if (result != null) {
          return result;
        }
      }
    }

    return null;
  }
}
