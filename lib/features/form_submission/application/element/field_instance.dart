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

  List<String> get filterDependencies => [...template.filterDependencies];

  // List<String> get filterExpressionDependencies => [
  //       ...?choiceFilter?.options
  //           .expand((o) => o.filterExpressionDependencies)
  //           .toSet()
  //     ];

  List<String> get dependencies => [
        ...template.dependencies,
        // if (filterExpressionDependencies.isNotEmpty)
        //   ...filterExpressionDependencies,
        // if (filterExpressionDependencies.isEmpty) ...filterDependencies
      ];

  @override
  T? reduceValue() => elementState.value;

  @override
  FormControl<T> get elementControl =>
      form.control(elementPath!) as FormControl<T>;

  @override
  void updateValue(T? value,
      {bool updateParent = true, bool emitEvent = true}) {
    if (value == this.value) {
      return;
    }

    updateStatus(elementState.reset(value: value));
    elementControl.updateValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  @override
  FormElementInstance<dynamic>? findElement(String path) => this;

  @override
  void forEachChild(
          void Function(FormElementInstance<dynamic> element) callback) =>
      <FormElementInstance<dynamic>>[];

  List<DataOption> get visibleOption => elementState.visibleOptions;

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
    // if (filterExpressionDependencies.isNotEmpty) {
    //   final visibleOptionsUpdate = choiceFilter!.evaluate(evalContext);
    //   logDebug(
    //       'all field options: ${choiceFilter!.options.map((o) => o.name)}');
    //   logDebug('only result: ${visibleOptionsUpdate.map((o) => o.name)}');
    //   final oldState = elementState.copyWith(); // clone
    //   final newState = elementState.resetValueFromVisibleOptions(
    //       visibleOptions: visibleOptionsUpdate);
    //   logDebug(
    //       '$name, option changed: ${oldState.value != newState.value},  ${oldState.value} => ${newState.value}');
    //   updateStatus(newState /* notify: oldState.value != newState.value*/);
    //   elementControl.updateValue(newState.value);
    // } else if (choiceFilter?.expression != null) {
    //   final visibleOptionsUpdate = choiceFilter!.evaluate(evalContext);
    //   logDebug(
    //       'all field options: ${choiceFilter!.options.map((o) => o.name)}');
    //   logDebug('only result: ${visibleOptionsUpdate.map((o) => o.name)}');
    //   final oldState = elementState.copyWith(); // clone
    //   final newState = elementState.resetValueFromVisibleOptions(
    //       visibleOptions: visibleOptionsUpdate);
    //   logDebug(
    //       '$name, option changed: ${oldState.value != newState.value},  ${oldState.value} => ${newState.value}');
    //   updateStatus(newState /* notify: oldState.value != newState.value*/);
    //   elementControl.updateValue(newState.value);
    // }
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
