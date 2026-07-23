import 'dart:async';

import 'package:datarunmobile/core/code_generator.dart';
import 'package:datarunmobile/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/form/rule/action.dart';
import 'package:datarunmobile/core/form/rule/calculated_Expression.dart';
import 'package:datarunmobile/core/form/rule/choice_filter.dart';
import 'package:datarunmobile/core/form/rule/rule_action.dart';
import 'package:datarunmobile/core/form/rule/rule_parse_extension.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_exception.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/rule.extension.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/age/age_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

part 'element_dependency.extension.dart';
part 'field_instance.dart';
part 'gs1_scanned_item.dart';
part 'repeat_section.dart';
part 'repeat_item_instance.dart';
part 'section_element.dart';
part 'section_instance.dart';

sealed class FormElementInstance<T> {
  FormElementInstance(
      {required this.form,
      required Template template,
      required FormElementState<T> elementState})
      : _elementState = elementState,
        _template = template;

  Stream<FormElementState<T>>
      get propertiesChanged => (propertiesChangedSubject ??=
              BehaviorSubject<FormElementState<T>>.seeded(_elementState))
          as Stream<FormElementState<T>>;

  @protected
  BehaviorSubject<FormElementState<T>?>? propertiesChangedSubject;

  final Template _template;

  Template get template => _template;

  ValueType? get type => template.type;

  FormGroup form;

  bool _isEvaluating = false;

  RuleErrorsValidator? _ruleErrorsValidator;

  Iterable<RuleAction> get elementRuleActions => _template.ruleActions();

  bool get usesRuleErrorValidator => elementRuleActions.any(
        (ruleAction) => ruleAction.action == RuleActionType.Error,
      );

  final Set<FormElementInstance<dynamic>> _dependents = Set();
  final Set<FormElementInstance<dynamic>> _resolvedDependencies = Set();

  Set<FormElementInstance<dynamic>> get dependents =>
      Set.unmodifiable(_dependents);

  Set<FormElementInstance<dynamic>> get resolvedDependencies =>
      Set.unmodifiable(_resolvedDependencies);

  String? get name => template.name;

  String get label =>
      '${getItemLocalString(template.label.unlockView, defaultString: name)}${mandatory ? ' *' : ''}';

  SectionElement<dynamic>? _parentSection;

  SectionElement<dynamic>? get parentSection => _parentSection;

  set parentSection(SectionElement<dynamic>? parent) {
    if (mandatory) {}

    _parentSection = parent;
  }

  FormElementState<T> _elementState;

  FormElementState<T> get elementState => _elementState;

  Map<String, dynamic> get ruleErrors => _elementState.errors;

  Map<String, dynamic> get errors => ruleErrors;

  bool get hasErrors => errors.isNotEmpty;

  bool get hidden => _elementState.hidden;

  bool get visible => !hidden;

  bool get mandatory => _elementState.mandatory;

  String? get elementPath => name == null ? null : pathBuilder(name!);

  String pathBuilder(String pathItem) =>
      [parentSection?.elementPath, pathItem].whereType<String>().join('.');

  T? get value => reduceValue();

  /// The current editing value, including values temporarily hidden by rules.
  ///
  /// [value] is the save projection and may omit hidden descendants. Repeat
  /// rows use this projection when swapping dormant snapshots and edit controls.
  T? get retainedValue => value;

  Object? getError(String errorCode, [String? path]) {
    final control = path != null ? findElement(path) : this;
    return control!.errors[errorCode];
  }

  T? reduceValue();

  AbstractControl<dynamic>? get mountedControl {
    final path = elementPath;
    if (path == null) {
      return null;
    }

    try {
      return form.control(path);
    } on FormControlNotFoundException {
      return null;
    }
  }

  AbstractControl<dynamic>? get elementControl => mountedControl;

  bool get controlExist => mountedControl != null;

  void updateValue(T? value, {bool updateParent = true, bool emitEvent = true});

  @protected
  void forEachChild(
      void Function(FormElementInstance<dynamic> element) callback);

  @protected
  FormElementInstance<dynamic>? findElement(String path);

  void bindControlReferences() {
    final control = mountedControl;
    if (control != null) {
      if (_ruleErrorsValidator == null && usesRuleErrorValidator) {
        final validator = RuleErrorsValidator(() => ruleErrors);
        _ruleErrorsValidator = validator;
        control.setValidators(
          [...control.validators, validator],
          autoValidate: true,
          updateParent: false,
          emitEvent: false,
        );
      }
      _syncRequiredValidator(
        mandatory,
        updateParent: false,
        emitEvent: false,
      );
      if (hidden && control.enabled) {
        control.markAsDisabled(updateParent: false, emitEvent: false);
      }
    }
    forEachChild((element) => element.bindControlReferences());
  }

  void releaseControlReferences() {
    _ruleErrorsValidator = null;
    forEachChild((element) => element.releaseControlReferences());
  }

  // void validate({bool updateParent = true, bool emitEvent = true}) {}

  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    logDebugLazy(() => '1.${elementPath}, markAsHidden: ${_getDebugState()}.');
    if (hidden) {
      logDebugLazy(
          () => '_.${elementPath}, markAsHidden, return: already hidden.');
      return;
    }
    updateStatus(
        _elementState.copyWith(
            hidden: true, errors: {}, mandatory: false, warning: ''),
        emitEvent: emitEvent);
    _syncRequiredValidator(
      false,
      updateParent: false,
      emitEvent: false,
    );
    // Visibility is temporary editing state. The visible-value projection
    // excludes this control when saving; disabling must not destroy its value.
    mountedControl?.markAsDisabled(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    onValidationStateChanged();

    logDebugLazy(
        () => '2.${elementPath}, markAsHidden, marked: ${_getDebugState()}.');

    // updateValueAndValidity(updateParent: true, emitEvent: false);
    // updateValueAndValidity(updateParent: updateParent, emitEvent: emitEvent);
  }

  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    logDebugLazy(() => '1.${elementPath}, markAsVisible: ${_getDebugState()}.');
    if (parentSection?.hidden == true) {
      logDebugLazy(() =>
          '_.${elementPath}, markAsVisible, return: parent section is hidden.');
      return;
    }
    if (visible) {
      logDebugLazy(
          () => '_.${elementPath}, markAsVisible, return: already visible.');
      return;
    }

    final templateMandatory = _template.mandatory;
    updateStatus(
        _elementState.copyWith(hidden: false, mandatory: templateMandatory),
        emitEvent: emitEvent);
    _syncRequiredValidator(
      templateMandatory,
      updateParent: false,
      emitEvent: false,
    );
    mountedControl?.markAsEnabled(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    onValidationStateChanged();
    logDebugLazy(
        () => '2.${elementPath}, markAsVisible, marked: ${_getDebugState()}.');
  }

  void markAsMandatory({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.${elementPath}, markAsMandatory: ${_getDebugState()}.');
    if (mandatory && _hasRequiredValidator) {
      logDebug('_.${elementPath}, markAsMandatory, return: already mandatory.');
      return;
    }
    updateStatus(_elementState.copyWith(mandatory: true), emitEvent: emitEvent);
    _syncRequiredValidator(
      true,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    onValidationStateChanged();
    logDebug('2.${elementPath}, markAsMandatory, marked: ${_getDebugState()}.');
  }

  void markAsUnMandatory({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.${elementPath}, markAsUnMandatory: ${_getDebugState()}.');
    if (!mandatory && !_hasRequiredValidator) {
      logDebug(
          '_.${elementPath}, markAsUnMandatory, return: already un-mandatory.');
      return;
    }
    updateStatus(_elementState.copyWith(mandatory: false),
        emitEvent: emitEvent);
    _syncRequiredValidator(
      false,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
    onValidationStateChanged();
    logDebug(
        '2.${elementPath}, markAsUnMandatory, marked: ${_getDebugState()}.');
  }

  bool get _hasRequiredValidator =>
      mountedControl?.validators
          .any((validator) => validator is RequiredValidator) ??
      mandatory;

  void _syncRequiredValidator(
    bool required, {
    required bool updateParent,
    required bool emitEvent,
  }) {
    final control = mountedControl;
    if (control == null) {
      return;
    }
    final validators = control.validators
        .where((validator) => validator is! RequiredValidator)
        .toList();
    if (required) {
      validators.add(const RequiredFieldValidator());
    }
    control.setValidators(
      validators,
      autoValidate: true,
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void setRuleError(
    String key,
    dynamic value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (ruleErrors[key] == value) {
      return;
    }
    _updateRuleErrors(
      {...ruleErrors, key: value},
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void removeRuleError(
    String key, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (!ruleErrors.containsKey(key)) {
      return;
    }
    _updateRuleErrors(
      {...ruleErrors}..remove(key),
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void _updateRuleErrors(
    Map<String, dynamic> errors, {
    required bool updateParent,
    required bool emitEvent,
  }) {
    updateStatus(
      _elementState.copyWith(errors: errors),
      emitEvent: emitEvent,
    );
    mountedControl?.updateValueAndValidity(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  void evaluate(
      {String? changedDependency,
      bool updateParent = true,
      bool emitEvent = true}) {
    final ruleActions = elementRuleActions;
    if (ruleActions.isEmpty) {
      return;
    }
    logDebugLazy(() =>
        '1/4.${elementPath ?? 'root'}, evaluate: due to $changedDependency.');
    logDebugLazy(() =>
        '2/4.${elementPath ?? 'root'}, evaluate, start: ${_getDebugState()}, context(${evalContext}).');
    // if (hidden) {
    //   logDebug('_.${elementPath}, evaluate, return,no eval: is hidden.');
    //   return;
    // }
    if (_isEvaluating) {
      logDebugLazy(
          () => '_.${elementPath}, evaluate, return, no eval: _isEvaluating.');
      return;
    }

    try {
      _isEvaluating = true;
      _evaluateRuleActions(
        ruleActions,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } catch (e) {
      logError('_.${elementPath ?? 'root'}, evaluate, error: $e.');
    } finally {
      _isEvaluating = false;
    }
  }

  String _getDebugState([FormElementState<T>? state]) =>
      'state(${(state ?? _elementState).hidden ? 'Hidden' : 'Visible'}), mandatory($mandatory)';

  void restoreVisibilityAfterParentShown({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    final visibilityActions = elementRuleActions
        .where((ruleAction) => ruleAction.action.isVisibility)
        .toList();
    if (visibilityActions.isEmpty) {
      markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
      return;
    }

    if (_isEvaluating) {
      return;
    }

    try {
      _isEvaluating = true;
      _evaluateRuleActions(
        visibilityActions,
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } catch (e) {
      logError(
          '_.${elementPath ?? 'root'}, restoreVisibilityAfterParentShown, error: $e.');
    } finally {
      _isEvaluating = false;
    }
  }

  void _evaluateRuleActions(
    Iterable<RuleAction> ruleActions, {
    required bool updateParent,
    required bool emitEvent,
  }) {
    for (final ruleAction in ruleActions) {
      logDebugLazy(() =>
          '3/4.$elementPath, evaluate, expression: ${ruleAction.expression}.');
      final applies = ruleAction.evaluate(evalContext);
      logDebugLazy(() => '4/4.$elementPath, evaluate, result: $applies.');
      applies
          ? ruleAction.apply(
              this,
              emitEvent: emitEvent,
              updateParent: updateParent,
            )
          : ruleAction.reset(
              this,
              emitEvent: emitEvent,
              updateParent: updateParent,
            );
    }
  }

  List<String> get dependencies => template.dependencies;

  @protected
  void onValidationStateChanged() {}

  void captureMountedValues() {
    forEachChild((element) => element.captureMountedValues());
  }

  List<String> get resolvedDependencyNames =>
      _resolvedDependencies.map((dependency) => dependency.name!).toList();

  void resolveDependencies() {
    if (dependencies.isEmpty) {
      logDebug(
          '1/2.${elementPath ?? 'root'}, resolveDependencies: no dependencies to resolve.');
      return;
    }

    logDebug('2/2.$elementPath, resolveDependencies: $dependencies.');

    for (final dependencyName in dependencies) {
      final dependency = findElementInParentSection(dependencyName);
      if (dependency != null) {
        _resolvedDependencies.add(dependency);
        dependency._addDependent(this);
      }
    }

    final unresolvedDependencies = dependencies
        .where((dependency) => !resolvedDependencyNames.contains(dependency))
        .toList();

    if (unresolvedDependencies.isNotEmpty) {
      logWarning(
          '_.$elementPath, resolveDependencies: Could not resolve some dependencies $unresolvedDependencies.');
    }

    if (resolvedDependencies.isNotEmpty) {
      logDebug(
          '_.$elementPath, resolveDependencies, resolved: $resolvedDependencyNames.');
    }
  }

  void dispose() {
    logDebug('${elementPath ?? 'root'} disposeMethod.');
    for (final dependency in _resolvedDependencies) {
      logDebug(
          '${elementPath ?? 'root'}: unsubscribing from ${dependency.name ?? 'root'}.');
      dependency._dependents.remove(this);
    }
    for (final dependent in _dependents) {
      dependent._resolvedDependencies.remove(this);
    }
    _resolvedDependencies.clear();
    _dependents.clear();

    final subject = propertiesChangedSubject;
    propertiesChangedSubject = null;
    if (subject != null) {
      unawaited(subject.close());
    }
  }
}
