part of 'form_element.dart';

class RepeatInstance extends SectionElement<List<Map<String, Object?>?>> {
  RepeatInstance({
    required super.template,
    required super.form,
    List<RepeatItemInstance> elements = const [],
  });

  final List<RepeatItemInstance> _elements = [];

  /// Gets the list of child elements.
  List<RepeatItemInstance> get elements => List.unmodifiable(_elements);

  @override
  Map<String, dynamic> get errors {
    final allErrors = Map.of(super.errors);
    _elements.asMap().entries.forEach((entry) {
      final element = entry.value;
      final name = entry.key.toString();
      if (element.visible && element.hasErrors) {
        allErrors.update(
          name,
          (_) => element.errors,
          ifAbsent: () => element.errors,
        );
      }
    });

    return allErrors;
  }

  void resolveDependencies() {
    for (final element in _elements) {
      element.resolveDependencies();
    }

    super.resolveDependencies();
  }

  // @override
  // List<Map<String, Object?>?> get rawValue =>
  //     _elements.map<Map<String, Object?>?>((element) {
  //       return element.rawValue;
  //     }).toList();

  /// Insert a new [element] at the end of the RepeatSection.
  void add(RepeatItemInstance element,
      {bool updateParent = true, bool emitEvent = true}) {
    addAll([element], emitEvent: emitEvent, updateParent: updateParent);
  }

  /// Appends all [elements] to the end of the RepeatSection.
  void addAll(
    List<RepeatItemInstance> elements, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    _elements.addAll(elements);
    for (final control in elements) {
      control.parentSection = this;
    }

    updateValueAndValidity(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    // emitsCollectionChanged(_controls);
  }

  @override
  List<Map<String, Object?>?>? reduceValue() {
    return _elements
        .where((element) => element.visible || hidden)
        .map((element) => element.value)
        .toList();
  }

  void insert(
    int index,
    RepeatItemInstance element, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    _elements.insert(index, element);
    element.parentSection = this;

    updateValueAndValidity(
      emitEvent: emitEvent,
      updateParent: updateParent,
    );
    //
    // if (emitEvent) {
    //   emitsCollectionChanged(_controls);
    // }
  }

  /// Removes and returns the child element at the given [index].
  void remove(
    RepeatItemInstance element, {
    bool emitEvent = true,
    bool updateParent = true,
  }) {
    final index = _elements.indexOf(element);
    if (index == -1) {
      throw FormControlNotFoundException();
    }
    removeAt(index, emitEvent: emitEvent, updateParent: updateParent);
  }

  RepeatItemInstance removeAt(
    int index, {
    bool emitEvent = true,
    bool updateParent = true,
  }) {
    final removedControl = _elements.removeAt(index);
    removedControl.parentSection = null;
    updateValueAndValidity(
      emitEvent: emitEvent,
      updateParent: updateParent,
    );

    // if (emitEvent) {
    //   emitsCollectionChanged(_controls);
    // }

    return removedControl;
  }

  /// Removes all children elements from the repeatSection.
  void clear({bool emitEvent = true, bool updateParent = true}) {
    forEachChild((element) => element.parentSection = null);
    _elements.clear();

    // elementControl.clear(updateParent: updateParent, emitEvent: emitEvent);
    updateValueAndValidity(
      emitEvent: emitEvent,
      updateParent: updateParent,
    );
  }

  void reset({List<Map<String, Object?>?>? value}) {
    updateValue(value);
    // elementControl.reset(value: value);
  }

  /// Checks if repeatSection contains a element by a given [name].
  /// The name here must be the string representation of the children index.
  ///
  /// `i.e repeated.element('0')`
  @override
  bool contains(String name) {
    final index = int.tryParse(name);
    if (index != null && index < _elements.length) {
      return true;
    }

    return false;
  }

  int sectionIndexWhere(bool test(FormElementInstance<dynamic> section),
      [int start = 0]) {
    return elements.indexWhere(test);
  }

  @override
  FormElementInstance<dynamic> element(String name) {
    final namePath = name.split('.');
    if (namePath.length > 1) {
      final control = findElementInCollection(namePath);
      if (control != null) {
        return control;
      }
    } else {
      final index = int.tryParse(name);
      if (index == null) {
        throw FormRepeatElementInvalidIndexException(index: name);
      } else if (index < _elements.length) {
        return _elements[index];
      }
    }

    throw FormRepeatElementInvalidIndexException(index: name);
  }

  @override
  FormElementInstance<dynamic>? findElement(String path) =>
      findElementInCollection(path.split('.'));

  @override
  void updateValue(List<Map<String, Object?>?>? value,
      {bool updateParent = true, bool emitEvent = true}) {
    for (var i = 0; i < _elements.length; i++) {
      if (value == null || i < value.length) {
        _elements[i].updateValue(
          value?.elementAt(i),
          updateParent: false,
          emitEvent: emitEvent,
        );
      }
    }

    updateValueAndValidity(updateParent: updateParent);
  }

  @override
  void forEachChild(
          void Function(FormElementInstance<dynamic> element) callback) =>
      _elements.forEach(callback);

  @override
  bool allElementsHidden() {
    if (_elements.isEmpty) {
      return false;
    }
    return _elements.every((control) => control.hidden);
  }

  // void get repeatSectionFocus => form.focus(elementPath);
  //
  @override
  FormArray<Map<String, Object?>> get elementControl =>
      form.control(elementPath) as FormArray<Map<String, Object?>>;

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
