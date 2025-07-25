part of 'form_element.dart';

/// A section
class Section extends SectionElement<Map<String, Object?>> {
  Section({
    required super.template,
    required super.form,
    Map<String, FormElementInstance<dynamic>> elements = const {},
  }) : assert(!elements.keys.any((name) => name.contains('.')),
            'element name should not contain dot(.)') {
    addAll(elements);
  }

  final Map<String, FormElementInstance<dynamic>> _elements = {};

  Map<String, FormElementInstance<dynamic>> get elements =>
      Map.unmodifiable(_elements);

  FormGroup get elementControl =>
      elementPath != null ? form.control(elementPath!) as FormGroup : form;

  @override
  Map<String, Object?> get value => Map.unmodifiable(reduceValue()!);

  /// Appends all [elements] to the group.
  void addAll(Map<String, FormElementInstance<dynamic>> elements) {
    _elements.addAll(elements);
    elements.forEach((name, element) {
      element.parentSection = this;
    });
  }

  @override
  Map<String, dynamic> get errors {
    final allErrors = Map<String, dynamic>.of(super.errors);
    elements.forEach((name, element) {
      if (element.visible && element.hasErrors) {
        allErrors.update(
          name,
          (final _) => element.errors,
          ifAbsent: () => element.errors,
        );
      }
    });

    return allErrors;
  }

  void resolveDependencies() {
    for (final element in _elements.values) {
      element.resolveDependencies();
    }

    super.resolveDependencies();
  }

  @override
  void evaluate(
      {String? changedDependency,
      bool updateParent = true,
      bool emitEvent = true}) {
    for (final element in _elements.values) {
      // decide my children
      element.evaluate(
          changedDependency: 'Parent Section call',
          updateParent: updateParent,
          emitEvent: emitEvent);
    }

    // decide my own status
    super.evaluate(
        changedDependency: changedDependency,
        updateParent: updateParent,
        emitEvent: emitEvent);
  }

  @override
  bool contains(String name) {
    return _elements.containsKey(name);
  }

  @override
  FormElementInstance<dynamic> element(String name) {
    final namePath = name.split('.');
    if (namePath.length > 1) {
      final element = findElementInCollection(namePath);
      if (element != null) {
        return element;
      }
    } else if (contains(name)) {
      return _elements[name]!;
    }
    throw FormElementNotFoundException(null);
  }

  @override
  FormElementInstance<dynamic>? findElement(String path) =>
      findElementInCollection(path.split('.'));

  @override
  void forEachChild(
      void Function(FormElementInstance<dynamic> element) callback) {
    _elements.forEach((name, element) => callback(element));
  }

  @override
  void updateValue(Map<String, Object?>? value,
      {bool updateParent = true, bool emitEvent = true}) {
    value ??= {};

    for (final key in _elements.keys) {
      _elements[key]!.updateValue(
        value[key],
        updateParent: false,
        emitEvent: emitEvent,
      );
    }
  }

  @override
  bool allElementsHidden() {
    if (_elements.isEmpty) {
      return false;
    }
    return _elements.values.every((element) => element.hidden);
  }

  @override
  Map<String, Object?>? reduceValue() {
    final map = <String, Object?>{};
    _elements.forEach((key, element) {
      if (element.visible || hidden) {
        map[key] = element.value;
      }
    });

    return map;
  }

  @override
  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.$elementPath Section, markAsHidden');
    if (hidden) {
      logDebug('_.$elementPath Section, markAsHidden, return: already hidden');
      return;
    }
    // just hide all children
    logDebug(
        '2.$elementPath Section, markAsHidden: mark hidden and hide children');
    super.markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
    _elements.forEach((_, element) {
      element.markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
    });
  }

  @override
  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.$elementPath Section, markAsVisible');
    if (visible) {
      logDebug(
          '_.$elementPath Section, markAsVisible, return: already visible');
      return;
    }
    logDebug(
        '2.$elementPath Section, markAsHidden: mark visible and let children decide');
    // should let children decide and only mark myself visible, may children decides their visibility
    super.markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
    _elements.forEach((_, element) {
      element.decideState(
          emitEvent: emitEvent, updateParent: updateParent);
    });
  }

  @override
  void dispose() {
    // forEachChild((element) {
    //   element.parentSection = null;
    //   element.dispose();
    // });
    // elementControl.closeCollectionEvents();
    super.dispose();
  }
}
