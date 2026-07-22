part of 'form_element.dart';

class FieldInstance<T> extends FormElementInstance<T> {
  FieldInstance({
    required FieldElementState<T> elementProperties,
    required super.form,
    required super.template,
    this.choiceFilter,
    Map<String, ValidationMessageFunction> validationMessages = const {},
  }) : super(elementState: elementProperties) {
    this.validationMessages.addAll(validationMessages);
  }

  final ChoiceFilter? choiceFilter;

  FieldTemplate get template => _template as FieldTemplate;

  FieldElementState<T> get elementState =>
      _elementState as FieldElementState<T>;

  final Map<String, ValidationMessageFunction> validationMessages = {};

  String? get listName => template.listName;

  dynamic get defaultValue => template.defaultValue;

  List<String> get dependencies => {
        ...template.dependencies,
        ...?choiceFilter?.dependencies,
      }.toList();

  Object? _lastNotifiedControlValue = _uninitializedControlValue;
  static final Object _uninitializedControlValue = Object();

  @override
  T? reduceValue() => elementControl.value;

  @override
  FormControl<T> get elementControl => _elementControl;

  late final FormControl<T> _elementControl =
      form.control(elementPath!) as FormControl<T>;

  @override
  void updateValue(T? value,
      {bool updateParent = true, bool emitEvent = true}) {
    if (_sameValue(value, elementControl.value)) {
      return;
    }

    elementControl.updateValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    _notifyControlValueChanged(value, emitEvent: emitEvent);
  }

  void handleControlValueChanged(T? value) {
    _notifyControlValueChanged(value);
  }

  void _notifyControlValueChanged(T? value, {bool emitEvent = true}) {
    if (_sameValue(value, _lastNotifiedControlValue)) {
      return;
    }

    _lastNotifiedControlValue = value is List ? List.of(value) : value;
    notifySubscribers(emitEvent: emitEvent);
  }

  @override
  FormElementInstance<dynamic>? findElement(String path) => this;

  @override
  void forEachChild(
          void Function(FormElementInstance<dynamic> element) callback) =>
      <FormElementInstance<dynamic>>[];

  List<FormOption> get visibleOption => elementState.visibleOptions;

  @override
  // ignore: unnecessary_overrides
  void evaluate(
      {String? changedDependency,
      bool updateParent = true,
      bool emitEvent = true}) {
    super.evaluate(
        changedDependency: changedDependency,
        updateParent: updateParent,
        emitEvent: emitEvent);
    if (choiceFilter?.hasFilters == true) {
      _applyChoiceFilter(updateParent: updateParent, emitEvent: emitEvent);
    }
  }

  void _applyChoiceFilter({
    required bool updateParent,
    required bool emitEvent,
  }) {
    final visibleOptions = choiceFilter!.evaluate(evalContext);
    logDebug('all field options: ${choiceFilter!.options.map((o) => o.name)}');
    logDebug('only result: ${visibleOptions.map((o) => o.name)}');

    if (!listEquals(elementState.visibleOptions, visibleOptions)) {
      updateStatus(
        elementState.copyWith(visibleOptions: visibleOptions),
        emitEvent: emitEvent,
      );
    }

    final retainedValue = _retainValueFromVisibleOptions(visibleOptions);
    if (!_sameValue(elementControl.value, retainedValue)) {
      updateValue(
        retainedValue,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  T? _retainValueFromVisibleOptions(List<FormOption> visibleOptions) {
    final currentValue = elementControl.value;
    if (currentValue is List<String>) {
      return currentValue
          .map((selectedValue) =>
              findFormOptionByValue(visibleOptions, selectedValue)?.code)
          .whereType<String>()
          .toList() as T;
    }

    return findFormOptionByValue(visibleOptions, currentValue)?.code as T?;
  }

  bool _sameValue(Object? left, Object? right) {
    if (left is List && right is List) {
      return listEquals(left, right);
    }
    return left == right;
  }
}

class CalculatedFieldInstance<T> extends FieldInstance<T> {
  CalculatedFieldInstance({
    required super.elementProperties,
    required super.form,
    required super.template,
    this.calculatedExpression,
  });

  final CalculatedExpression? calculatedExpression;

  List<String> get dependencies =>
      [...template.dependencies, ...template.calculationDependencies];

  @override
  // ignore: unnecessary_overrides
  void evaluate(
      {String? changedDependency,
      bool updateParent = true,
      bool emitEvent = true}) {
    super.evaluate(
        changedDependency: changedDependency,
        updateParent: updateParent,
        emitEvent: emitEvent);
    // if (calculatedExpression?.expression != null) {
    //   final result = calculatedExpression!.evaluate(evalContext);
    //   logDebug(
    //       'calculated field evaluation: ${name}, expression: ${calculatedExpression?.expression} ');
    //   final oldState = elementState.copyWith(); // clone
    //   final newState = elementState.copyWith(value: result);
    //   logDebug(
    //       '$name, calculate Field changed: ${oldState.value != newState.value},  ${oldState.value} => ${newState.value}');
    //   updateStatus(newState);
    //   elementControl.updateValue(newState.value);
    // }
  }
}

extension FormFieldModelExtensions<T> on FieldInstance<T> {
  TextInputType? get inputType {
    return switch (type) {
      ValueType.Text => TextInputType.text,
      ValueType.LongText => TextInputType.multiline,
      ValueType.Letter => TextInputType.text,
      ValueType.Number =>
        const TextInputType.numberWithOptions(decimal: true, signed: true),
      ValueType.UnitInterval =>
        const TextInputType.numberWithOptions(decimal: true),
      ValueType.Percentage => TextInputType.number,
      ValueType.IntegerNegative ||
      ValueType.Integer =>
        const TextInputType.numberWithOptions(signed: true),
      ValueType.IntegerPositive ||
      ValueType.IntegerZeroOrPositive =>
        TextInputType.number,
      ValueType.PhoneNumber => TextInputType.phone,
      ValueType.Email => TextInputType.emailAddress,
      ValueType.URL => TextInputType.url,
      _ => TextInputType.text
    };
  }

  TextInputAction? get inputAction {
    return TextInputAction.none;
    // return when(
    //     keyboardActionType, <KeyboardActionType, TextInputAction Function()>{
    //   KeyboardActionType.NEXT: () => TextInputAction.next,
    //   KeyboardActionType.DONE: () => TextInputAction.done,
    //   KeyboardActionType.ENTER: () => TextInputAction.none,
    // });
  }

  int? get maxLength {
    switch (type) {
      case ValueType.Text:
        return 255;
      case ValueType.LongText:
      case ValueType.Letter:
        return 500;
      default:
        return null;
    }
  }

  int get maxLines {
    switch (type) {
      case ValueType.LongText:
      case ValueType.Letter:
        return 2;
      default:
        return 1;
    }
  }

  //
  TextInputAction? get textInputAction {
    // if (keyboardActionType != null) {
    //   return when(
    //       keyboardActionType, <KeyboardActionType, TextInputAction Function()>{
    //     KeyboardActionType.NEXT: () => TextInputAction.next,
    //     KeyboardActionType.DONE: () => TextInputAction.done,
    //     KeyboardActionType.ENTER: () => TextInputAction.none
    //   });
    // }
    return null;
  }
}
