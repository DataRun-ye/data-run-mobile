part of 'form_element_model.dart';

class FieldElementModel<T> extends FormElementModel<T> {
  FieldElementModel({
    required super.templatePath,
    super.value,
    super.hidden,
    super.valid,
    super.dirty,
    bool mandatory = false,
  });

  @override
  void updateValue(T? value,
      {bool updateParent = true, bool emitEvent = true}) {
    if (_value != value) {
      _value = value;
    }
    updateValueAndValidity(updateParent: updateParent, emitEvent: emitEvent);
  }

  @override
  T? reduceValue() => _value;

  @override
  bool anyElements(bool Function(FormElementModel<dynamic>) condition) => false;

  @override
  FormElementModel<dynamic>? findElement(String path) => this;

  @override
  void forEachChild(
          void Function(FormElementModel<dynamic> element) callback) =>
      <FormElementModel<dynamic>>[];

  @override
  FieldElementModel<T> clone(CollectionElementModel<dynamic>? parent) {
    final instance = getInstance();
    instance.parent = parent;
    return instance;
  }

  @override
  FieldElementModel<T> getInstance() =>
      FieldElementModel(templatePath: templatePath);
}

class SelectFieldElementModel<T> extends FieldElementModel<T> {
  SelectFieldElementModel(
      {required super.templatePath,
      super.value,
      super.hidden,
      super.valid,
      super.dirty,
      super.mandatory,
      this.choiceFilter,
      this.listName});

  final ChoiceFilter? choiceFilter;
  final String? listName;
}
