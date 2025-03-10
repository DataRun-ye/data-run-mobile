part of 'form_element_model.dart';

class RepeatElementModel
    extends CollectionElementModel<List<Map<String, Object?>?>> {
  RepeatElementModel(
      {super.hidden,
      List<RepeatItemElementModel> elements = const [],
      super.templatePath}) {
    addAll(elements);
  }

  final List<RepeatItemElementModel> _elements = [];

  /// Gets the list of child elements.
  List<RepeatItemElementModel> get elements => List.unmodifiable(_elements);

  @override
  Iterable<FormElementModel<dynamic>> get elementsList => elements;

  @override
  List<Map<String, Object?>?> get rawValue =>
      _elements.map<Map<String, Object?>?>((control) {
        if (control is FormControlCollection<Map<String, Object?>?>) {
          return (control as FormControlCollection<Map<String, Object?>?>)
              .rawValue;
        }

        return control.value;
      }).toList();

  @override
  List<Map<String, Object?>?>? reduceValue() {
    return _elements
        .where((element) => element.visible || hidden)
        .map((element) => element.value)
        .toList();
  }

  @override
  bool allElementsHidden() {
    if (_elements.isEmpty) {
      return false;
    }
    return _elements.every((element) => element.hidden);
  }

  @override
  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    for (final element in _elements) {
      element.markAsHidden();
    }
    super.markAsHidden();
  }

  @override
  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    forEachChild((element) {
      element.markAsVisible();
    });
    super.markAsVisible();
  }

  void insert(
    int index,
    RepeatItemElementModel element, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    _elements.insert(index, element);
    element.parent = this;

    updateValueAndValidity(
      emitEvent: emitEvent,
      updateParent: updateParent,
    );
  }

  /// Insert a new [element] at the end of the RepeatSection.
  void add(
    RepeatItemElementModel element,
  ) {
    addAll([element]);
  }

  /// Appends all [elements] to the end of the RepeatSection.
  void addAll(
    List<RepeatItemElementModel> elements, {
    bool emitEvent = true,
    bool updateParent = true,
  }) {
    _elements.addAll(elements);
    for (final element in elements) {
      element.parent = this;
    }

    updateValueAndValidity(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    // emitsCollectionChanged(_controls);
  }

  /// Removes and returns the child element at the given [index].
  void remove(
    RepeatItemElementModel element, {
    bool emitEvent = true,
    bool updateParent = true,
  }) {
    final index = _elements.indexOf(element);
    if (index == -1) {
      throw FormControlNotFoundException();
    }
    removeAt(index, emitEvent: emitEvent, updateParent: updateParent);
  }

  FormElementModel<Map<String, Object?>?> removeAt(
    int index, {
    bool emitEvent = true,
    bool updateParent = true,
  }) {
    final removedElement = _elements.removeAt(index);
    removedElement.parent = null;
    updateValueAndValidity(
      emitEvent: emitEvent,
      updateParent: updateParent,
    );

    // if (emitEvent) {
    //   emitsCollectionChanged(_controls);
    // }

    return removedElement;
  }

  /// Removes all children elements from the repeatSection.
  void clear({bool emitEvent = true, bool updateParent = true}) {
    forEachChild((element) => element.parent = null);
    _elements.clear();
    updateValueAndValidity(
      emitEvent: emitEvent,
      updateParent: updateParent,
    );

    // if (emitEvent) {
    //   emitsCollectionChanged(_controls);
    // }
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

  int RepeatItemIndexWhere(bool test(RepeatItemElementModel item),
      [int start = 0]) {
    return elements.indexWhere(test);
  }

  @override
  FormElementModel<dynamic> element(String name) {
    final namePath = name.split('.');
    if (namePath.length > 1) {
      final control = findElementInCollection(namePath);
      if (control != null) {
        return control;
      }
    } else {
      final index = int.tryParse(name);
      if (index == null) {
        throw FormRepeatElementInvalidIndexException(source: this, index: name);
      } else if (index < _elements.length) {
        return _elements[index];
      }
    }

    throw FormElementNotFoundException(this);
  }

  @override
  FormElementModel<dynamic>? findElement(String path) =>
      findElementInCollection(path.split('.'));

  @override
  void forEachChild(
          void Function(FormElementModel<dynamic> element) callback) =>
      _elements.forEach(callback);

  @override
  void updateValue(List<Map<String, Object?>?>? value,
      {bool updateParent = true, bool emitEvent = true}) {
    for (var i = 0; i < _elements.length; i++) {
      if (value == null || i < value.length) {
        _elements[i].updateValue(
          value?.elementAt(i),
        );
      }
    }

    if (value != null && value.length > _elements.length) {
      final newElements = value
          .toList()
          .asMap()
          .entries
          .where((MapEntry<int, Map<String, Object?>?> entry) =>
              entry.key >= _elements.length)
          .map((MapEntry<int, Map<String, Object?>?> entry) {
        final result = _elements.first.clone(parent);
        result.updateValue(entry.value);
        return result;
      }).toList();

      addAll(
        newElements,
      );
    } else {
      updateValueAndValidity(
        updateParent: updateParent,
      );
    }
  }

  /// Gets all errors of the array.
  ///
  /// Contains all the errors of the array and the child errors.
  @override
  Map<String, Object> get errors {
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

  @override
  bool anyElementsHaveStatus(ElementStatus status) {
    return _elements.any((control) => control.status == status);
  }

  @override
  bool anyElements(bool Function(FormElementModel<dynamic> p1) condition) {
    return _elements.any((control) => control.visible && condition(control));
  }

  @override
  RepeatElementModel getInstance() =>
      RepeatElementModel(templatePath: templatePath);

  @override
  RepeatElementModel clone(CollectionElementModel<dynamic>? parent) {
    final instance = getInstance();
    instance.parent = parent;
    final elements =
        _elements.map((element) => element.clone(instance)).toList();
    instance.addAll(elements);
    return instance;
  }
}
