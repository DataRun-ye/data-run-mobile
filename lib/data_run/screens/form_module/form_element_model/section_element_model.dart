part of 'form_element_model.dart';

class SectionElementModel extends CollectionElementModel<Map<String, Object?>> {
  SectionElementModel({
    super.templatePath,
    super.hidden,
    Map<String, FormElementModel<dynamic>> elements = const {},
  }) : assert(!elements.keys.any((name) => name.contains('.')),
            'element name should not contain dot(.)') {
    addAll(elements);
  }

  /// by path
  final Map<String, FormElementModel<dynamic>> _elements = {};

  Map<String, FormElementModel<dynamic>> get elements =>
      Map.unmodifiable(_elements);

  @override
  Map<String, Object> get errors {
    final allErrors = Map<String, Object>.of(super.errors);
    _elements.forEach((name, element) {
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
  bool contains(String name) {
    return _elements.containsKey(name);
  }

  @override
  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    _elements.forEach((_, element) {
      element.markAsHidden();
    });
    super.markAsHidden();
  }

  @override
  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    _elements.forEach((_, element) {
      element.markAsVisible();
    });
    super.markAsVisible();
  }

  @override
  FormElementModel<dynamic> element(String name) {
    final namePath = name.split('.');
    if (namePath.length > 1) {
      final element = findElementInCollection(namePath);
      if (element != null) {
        return element;
      }
    } else if (contains(name)) {
      return _elements[name]!;
    }
    throw FormElementNotFoundException(this);
  }

  @override
  Map<String, Object?> get rawValue =>
      _elements.map<String, Object?>((key, element) {
        if (element is CollectionElementModel<dynamic>) {
          return MapEntry(key, element.rawValue);
        }

        return MapEntry(key, element.value);
      });

  @override
  void updateValue(Map<String, Object?>? value,
      {bool updateParent = true, bool emitEvent = true}) {
    value ??= {};
    for (final key in _elements.keys) {
      _elements[key]!.updateValue(
        value[key],
      );
    }
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
  bool anyElementsHaveStatus(ElementStatus status) {
    return _elements.values.any((control) => control.status == status);
  }

  @override
  FormElementModel<dynamic>? findElement(String path) =>
      findElementInCollection(path.split('.'));

  @override
  void forEachChild(void Function(FormElementModel<dynamic> element) callback) {
    _elements.forEach((name, element) => callback(element));
  }

  @override
  Iterable<FormElementModel<dynamic>> get elementsList => elements.values;

  /// Appends all [elements] to the group.
  void addAll(Map<String, FormElementModel<dynamic>> elements) {
    _elements.addAll(elements);
    elements.forEach((name, element) {
      element.parent = this;
    });
  }

  @override
  bool allElementsHidden() {
    if (_elements.isEmpty) {
      return false;
    }
    return _elements.values.every((control) => control.hidden);
  }

  @override
  bool anyElements(bool Function(FormElementModel<dynamic> p1) condition) {
    return _elements.values
        .any((control) => control.visible && condition(control));
  }

  @override
  SectionElementModel getInstance() =>
      SectionElementModel(templatePath: templatePath);

  @override
  SectionElementModel clone(CollectionElementModel<dynamic>? parent) {
    final instance = getInstance();
    instance.parent = parent;
    final elements =
        _elements.map((key, element) => MapEntry(key, element.clone(instance)));
    instance.addAll(elements);
    return instance;
  }
}
