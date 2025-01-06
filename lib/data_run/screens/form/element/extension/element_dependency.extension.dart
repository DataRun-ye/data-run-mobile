part of '../form_element.dart';

extension ElementDependencyHandler<T> on FormElementInstance<T> {
  Map<String, dynamic> get evalContext {
    return {
      for (final dependency in _resolvedDependencies)
        dependency.name!: calculationFriendlyValue(dependency)
    };
  }

  calculationFriendlyValue(FormElementInstance<dynamic> dependency) {
    if (!dependency.visible) {
      return dependency.template.isNumeric ? 0 : null;
    } else if (dependency.template.isNumeric && dependency.value == null) {
      return 0;
    } else {
      return dependency.value;
    }
  }

  void updateStatus(FormElementState newValue, {bool emitEvent = true}) {
    // if (newValue != _elementState) {
    _elementState = newValue;
    if (emitEvent) {
      logDebug('${name ?? 'root'}, changed, --> Notifying subscribers');
      propertiesChangedSubject?.add(newValue);
    } else {
      logDebug('${name ?? 'root'}, not emitting status update');
    }
    // applyStateToControl(newValue, updateParent: true, emitEvent: emitEvent);
    notifySubscribers(emitEvent: emitEvent);
  }

  // void applyStateToControl(
  //   FormElementState newState, {
  //   bool updateParent = true,
  //   bool emitEvent = true,
  // }) {
  //   // updateValue(value);
  //   // elementControl!
  //   //     .updateValue(newState.value, updateParent: false, emitEvent: false);
  //   if (newState.hidden) {
  //     markAsHidden(/*updateParent: false, emitEvent: false*/);
  //     // elementControl!
  //     //     .reset(disabled: true, updateParent: false, emitEvent: false);
  //   } else {
  //     markAsVisible(/*updateParent: false, emitEvent: false*/);
  //     // elementControl!.markAsEnabled(updateParent: false, emitEvent: false);
  //     if (newState.mandatory) {
  //       markAsMandatory(/*updateParent: false, emitEvent: false*/);
  //     }
  //     if (newState.hasErrors) {
  //       setErrors(newState.errors);
  //     }
  //   }
  //
  //   elementControl!.updateValueAndValidity(
  //       updateParent: updateParent, emitEvent: emitEvent);
  // }

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
    logDebug('${name ?? 'root'}, notifying: ${resolvedDependentsNames}');
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
      final childElements = current is SectionInstance
          ? current.elements.values
          : (current as RepeatInstance).elements;
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
