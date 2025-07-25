part of 'form_element.dart';

extension ElementDependencyHandler<T> on FormElementInstance<T> {
  Map<String, dynamic> get evalContext {
    return {
      for (final dependency in _resolvedDependencies)
        dependency.name!: calculationFriendlyValue(dependency)
    };
  }

  calculationFriendlyValue(FormElementInstance<dynamic> dependency) {
    if (dependency.hidden) {
      if (dependency.template.type!.isNumeric) return 0;
      if (dependency.template.type!.isBoolean) return false;
      if (dependency.template.type! == ValueType.Age) return 0;
      return null;
    } else if (dependency.template.type!.isNumeric &&
        (dependency.value == null || dependency.value is! num)) {
      return 0;
    } else if (dependency.template.type!.isBoolean &&
        dependency.value == null) {
      return false;
    } else if (dependency.template.type! == ValueType.Age) {
      if (dependency.value != null) {
        return AgeValue(dateOfBirth: DateTime.parse(dependency.value).toLocal())
            .years(DateTime.now());
      }
      return 0;
    } else {
      return dependency.value;
    }
  }

  void updateStatus(FormElementState<T> newValue, {bool emitEvent = true}) {
    // if (newValue != _elementState) {
    logDebug('1.${elementPath ?? 'root'}, updateStatus: emitEvent($emitEvent)');
    _elementState = newValue;
    if (emitEvent) {
      propertiesChangedSubject?.add(newValue);
      logDebug(
          '2.${elementPath ?? 'root'}, updateStatus: Notifying subscribers');
      notifySubscribers(emitEvent: emitEvent);
    } else {
      logDebug('_.${elementPath ?? 'root'}: no notifying');
    }
  }

  void addDependency(FormElementInstance<dynamic> dependency) {
    _resolvedDependencies.add(dependency);
    dependency._addDependent(this);
  }

  void removeDependent(FormElementInstance<dynamic> dependent) {
    _dependents.remove(dependent);
  }

  void removeDependency(FormElementInstance<dynamic> dependency) {
    _resolvedDependencies.remove(dependency);
  }

  void _addDependent(FormElementInstance<dynamic> dependent) {
    _dependents.add(dependent);
  }

  List<String> get resolvedDependentsNames =>
      _dependents.map((dependent) => dependent.name!).toList();

  void notifySubscribers({bool emitEvent = true}) {
    logDebug(
        '1.${elementPath ?? 'root'}, notifySubscribers: ${resolvedDependentsNames}');
    _dependents.forEach(
        (s) => s.evaluate(changedDependency: name, emitEvent: emitEvent));
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
