part of 'form_element.dart';

class FieldInstance<T> extends FormElementInstance<T> {
  FieldInstance({
    required FieldElementState<T> elementProperties,
    required super.form,
    required super.template,
    T? initialValue,
    this.choiceFilter,
    Map<String, ValidationMessageFunction> validationMessages = const {},
  })  : _retainedValue = initialValue,
        super(elementState: elementProperties) {
    this.validationMessages.addAll(validationMessages);
  }

  final ChoiceFilter? choiceFilter;

  FieldTemplate get template => _template as FieldTemplate;

  @override
  Iterable<RuleAction> get elementRuleActions => template.validationRule == null
      ? super.elementRuleActions
      : super
          .elementRuleActions
          .where((action) => action.action != RuleActionType.Error);

  @override
  bool get usesRuleErrorValidator =>
      template.validationRule != null || super.usesRuleErrorValidator;

  FieldElementState<T> get elementState =>
      _elementState as FieldElementState<T>;

  final Map<String, ValidationMessageFunction> validationMessages = {};

  String? _activeValidationRuleError;

  T? _retainedValue;
  Map<String, dynamic>? _dormantValidationErrors;

  String? get listName => template.listName;

  dynamic get defaultValue => template.defaultValue;

  List<String> get dependencies => {
        ...template.dependencies,
        ...?choiceFilter?.dependencies,
      }.toList();

  Object? _lastNotifiedControlValue = _uninitializedControlValue;
  static final Object _uninitializedControlValue = Object();

  @override
  T? reduceValue() => mountedControl?.value ?? _retainedValue;

  @override
  T? get retainedValue => mountedControl?.value ?? _retainedValue;

  @override
  Map<String, dynamic> _collectErrors(_FormValidationPass validationPass) {
    if (hidden) {
      return const {};
    }

    final controlErrors =
        mountedControl?.errors ?? _validateDormantValue(validationPass);
    return <String, dynamic>{...controlErrors, ...ruleErrors};
  }

  @override
  FormControl<T>? get mountedControl {
    final control = super.mountedControl;
    return control is FormControl<T> ? control : null;
  }

  @override
  FormControl<T> get elementControl =>
      mountedControl ?? (throw FormControlNotFoundException());

  @override
  void updateValue(T? value,
      {bool updateParent = true, bool emitEvent = true}) {
    if (_sameValue(value, retainedValue)) {
      return;
    }

    _retainedValue = _copyRetainedValue(value);
    _invalidateDormantValidation();
    mountedControl?.updateValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    _notifyControlValueChanged(value, emitEvent: emitEvent);
  }

  void handleControlValueChanged(T? value) {
    _retainedValue = _copyRetainedValue(value);
    _invalidateDormantValidation();
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
  void captureMountedValues() {
    final control = mountedControl;
    if (control != null) {
      final value = control.value;
      _retainedValue = _copyRetainedValue(value);
      _invalidateDormantValidation();
    }
  }

  @override
  void onValidationStateChanged() => _invalidateDormantValidation();

  void _invalidateDormantValidation() {
    _dormantValidationErrors = null;
  }

  T? _copyRetainedValue(T? value) {
    if (template.type == ValueType.SelectMulti && value is Iterable) {
      return value.cast<String>().toList() as T;
    }
    return value;
  }

  Map<String, dynamic> _validateDormantValue(
    _FormValidationPass validationPass,
  ) {
    final cached = _dormantValidationErrors;
    if (cached != null) {
      return cached;
    }

    return _dormantValidationErrors = validationPass.validateDormantField(
      template,
      _retainedValue,
      mandatory: mandatory,
    );
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
    _evaluateValidationRule(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    if (choiceFilter?.hasFilters == true) {
      _applyChoiceFilter(updateParent: updateParent, emitEvent: emitEvent);
    }
  }

  @override
  void restoreVisibilityAfterParentShown({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    super.restoreVisibilityAfterParentShown(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    _evaluateValidationRule(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    if (choiceFilter?.hasFilters == true) {
      _applyChoiceFilter(updateParent: updateParent, emitEvent: emitEvent);
    }
  }

  void _evaluateValidationRule({
    required bool updateParent,
    required bool emitEvent,
  }) {
    final validationRule = template.validationRule;
    if (validationRule == null) {
      return;
    }

    final error = validationRule.displayMessage;
    if (_activeValidationRuleError != null &&
        _activeValidationRuleError != error) {
      removeRuleError(
        _activeValidationRuleError!,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }

    if (visible && validationRule.evaluate(evalContext)) {
      _activeValidationRuleError = error;
      setRuleError(
        error,
        error,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      removeRuleError(
        error,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
      _activeValidationRuleError = null;
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

    if (hidden) {
      return;
    }

    final retainedValue = _retainValueFromVisibleOptions(visibleOptions);
    if (!_sameValue(this.retainedValue, retainedValue)) {
      updateValue(
        retainedValue,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  T? _retainValueFromVisibleOptions(List<FormOption> visibleOptions) {
    final currentValue = retainedValue;
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

class ReferenceFieldInstance extends FieldInstance<String> {
  ReferenceFieldInstance({
    required super.elementProperties,
    required super.form,
    required super.template,
    super.initialValue,
  });

  bool Function(ReferenceFieldInstance field)? _duplicateLookup;
  void Function()? _referenceStateChanged;
  FormControl<String>? _duplicateValidationControl;
  late final Validator<String> _duplicateValidator =
      _ReferenceDuplicateValidator(() => hasDuplicateValue);

  bool get hasDuplicateValue => _duplicateLookup?.call(this) ?? false;

  void configureReferenceValidation({
    required bool Function(ReferenceFieldInstance field) duplicateLookup,
    required void Function() onReferenceStateChanged,
  }) {
    _duplicateLookup = duplicateLookup;
    _referenceStateChanged = onReferenceStateChanged;
    _bindDuplicateValidator();
  }

  @override
  Map<String, dynamic> _collectErrors(_FormValidationPass validationPass) {
    final errors =
        Map<String, dynamic>.of(super._collectErrors(validationPass));
    if (visible && hasDuplicateValue) {
      errors[ReferenceValidationMessage.duplicate] = true;
    }
    return errors;
  }

  @override
  void bindControlReferences() {
    super.bindControlReferences();
    _bindDuplicateValidator();
  }

  void _bindDuplicateValidator() {
    final control = mountedControl;
    if (control != null && !identical(control, _duplicateValidationControl)) {
      _duplicateValidationControl = control;
      control.setValidators(
        [...control.validators, _duplicateValidator],
        autoValidate: true,
        updateParent: false,
        emitEvent: false,
      );
    }
  }

  @override
  void releaseControlReferences() {
    _duplicateValidationControl = null;
    super.releaseControlReferences();
  }

  @override
  void handleControlValueChanged(String? value) {
    final changed = _retainedValue != value;
    super.handleControlValueChanged(value);
    if (changed) {
      _referenceStateChanged?.call();
    }
  }

  @override
  void updateValue(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    final changed = retainedValue != value;
    super.updateValue(
      value,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    if (changed) {
      _referenceStateChanged?.call();
    }
  }

  @override
  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    final wasVisible = visible;
    super.markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
    if (wasVisible && hidden) {
      _referenceStateChanged?.call();
    }
  }

  @override
  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    final wasHidden = hidden;
    super.markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
    if (wasHidden && visible) {
      _referenceStateChanged?.call();
    }
  }

  void refreshReferenceValidation() {
    onValidationStateChanged();
    mountedControl?.updateValueAndValidity(
      updateParent: false,
      emitEvent: true,
    );
  }
}

class _ReferenceDuplicateValidator extends Validator<String> {
  _ReferenceDuplicateValidator(this._hasDuplicate);

  final bool Function() _hasDuplicate;

  @override
  Map<String, dynamic>? validate(AbstractControl<String> control) {
    if (control.value == null || !_hasDuplicate()) {
      return null;
    }
    return const <String, dynamic>{
      ReferenceValidationMessage.duplicate: true,
    };
  }
}

class CalculatedFieldInstance<T> extends FieldInstance<T> {
  CalculatedFieldInstance({
    required super.elementProperties,
    required super.form,
    required super.template,
    super.initialValue,
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
