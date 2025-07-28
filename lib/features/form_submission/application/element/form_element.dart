import 'dart:async';

import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/rule/action.dart';
import 'package:d_sdk/core/form/rule/calculated_Expression.dart';
import 'package:d_sdk/core/form/rule/choice_filter.dart';
import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_exception.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/rule.extension.dart';
import 'package:datarunmobile/features/form_submission/application/element/rule_effect_state_factory.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/age/age_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

part 'element_dependency.extension.dart';
part 'field_instance.dart';
part 'gs1_scanned_item.dart';
part 'repeat_instance.dart';
part 'repeat_item_instance.dart';
part 'section_element.dart';
part 'section_instance.dart';

typedef ElementControl<T> = AbstractControl<T>? Function(String path);

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
  RuleEffectStateFactory ruleEffectStateFactory =
      appLocator<RuleEffectStateFactory>();

  Iterable<RuleAction> get elementRuleActions => _template.ruleActions();

  List<RuleAction> get inEffectRuleActions => elementRuleActions
      .where((ruleAction) => ruleAction.evaluate(evalContext))
      .toList();

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

  Map<String, dynamic> get errors => _elementState.errors;

  bool get hasErrors => errors.isNotEmpty;

  bool get hidden => _elementState.hidden;

  bool get visible => !hidden;

  bool get mandatory => _elementState.mandatory;

  String? get elementPath => name == null ? null : pathBuilder(name!);

  String pathBuilder(String pathItem) =>
      [parentSection?.elementPath, pathItem].whereType<String>().join('.');

  T? get value => reduceValue();

  Object? getError(String errorCode, [String? path]) {
    final control = path != null ? findElement(path) : this;
    return control!.errors[errorCode];
  }

  T? reduceValue();

  AbstractControl<dynamic>? get elementControl =>
      elementPath != null ? form.control(elementPath!) : null;

  bool get controlExist {
    try {
      form.control(elementPath!);
      return true;
    } catch (e) {
      return false;
    }
  }

  void updateValue(T? value, {bool updateParent = true, bool emitEvent = true});

  @protected
  bool allElementsHidden() => hidden;

  @protected
  void forEachChild(
      void Function(FormElementInstance<dynamic> element) callback);

  @protected
  FormElementInstance<dynamic>? findElement(String path);

  // void validate({bool updateParent = true, bool emitEvent = true}) {}

  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.${elementPath}, markAsHidden: ${_getDebugState()}.');
    if (hidden) {
      logDebug('_.${elementPath}, markAsHidden, return: already hidden.');
      return;
    }
    updateStatus(
        _elementState.copyWith(
            hidden: true, errors: {}, mandatory: false, warning: ''),
        emitEvent: emitEvent);
    elementControl!.reset(
        disabled: true, updateParent: updateParent, emitEvent: emitEvent);

    logDebug('2.${elementPath}, markAsHidden, marked: ${_getDebugState()}.');

    // updateValueAndValidity(updateParent: true, emitEvent: false);
    // updateValueAndValidity(updateParent: updateParent, emitEvent: emitEvent);
  }

  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.${elementPath}, markAsVisible: ${_getDebugState()}.');
    if (visible) {
      logDebug('_.${elementPath}, markAsVisible, return: already visible.');
      return;
    }

    updateStatus(
        _elementState.copyWith(hidden: false, mandatory: _template.mandatory),
        emitEvent: emitEvent);
    elementControl!
        .markAsEnabled(updateParent: updateParent, emitEvent: emitEvent);
    logDebug('2.${elementPath}, markAsVisible, marked: ${_getDebugState()}.');
  }

  void markAsMandatory({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.${elementPath}, markAsMandatory: ${_getDebugState()}.');
    if (mandatory) {
      logDebug('_.${elementPath}, markAsMandatory, return: already mandatory.');
      return;
    }
    updateStatus(_elementState.copyWith(mandatory: true), emitEvent: emitEvent);

    final elementValidators = [
      ...elementControl!.validators,
      Validators.required
    ];
    elementControl!.setValidators(elementValidators, autoValidate: true);
    logDebug('2.${elementPath}, markAsMandatory, marked: ${_getDebugState()}.');
  }

  void markAsUnMandatory({bool updateParent = true, bool emitEvent = true}) {
    logDebug('1.${elementPath}, markAsUnMandatory: ${_getDebugState()}.');
    updateStatus(_elementState.copyWith(mandatory: false),
        emitEvent: emitEvent);
    if (!mandatory) {
      logDebug(
          '_.${elementPath}, markAsUnMandatory, return: already un-mandatory.');
      return;
    }
    final elementValidators = [
      ...elementControl!.validators,
    ]..remove(Validators.required);

    elementControl!.setValidators(elementValidators,
        autoValidate: true, updateParent: updateParent, emitEvent: emitEvent);
    logDebug(
        '2.${elementPath}, markAsUnMandatory, marked: ${_getDebugState()}.');
  }

  void setErrors(Map<String, dynamic> errors, {bool markAsDirty = true}) {
    // if (visible) {
    updateStatus(_elementState.copyWith(errors: errors));
    // _updateControlsErrors();
    elementControl?.setErrors(errors, markAsDirty: markAsDirty);
    // }
  }

  void removeError(String key,
      {bool updateParent = true, bool emitEvent = true}) {
    // if (visible) {
    updateStatus(_elementState.copyWith(errors: {...errors}..remove(key)),
        emitEvent: emitEvent);
    // _updateControlsErrors();
    elementControl?.removeError(key);
    // }
  }

  static final Set<String> _evaluationStack = {};

  List<RuleAction> get effectiveRuleEffects {
    final rules = elementRuleActions;
    final effectiveRules = elementRuleActions
        .map((ruleAction) =>
            ruleAction.copyWith(applyEffect: ruleAction.evaluate(evalContext)))
        .toList();
    return effectiveRules;
  }

  void evaluate(
      {String? changedDependency,
      bool updateParent = true,
      bool emitEvent = true}) {
    logDebug(
        '1/4.${elementPath ?? 'root'}, evaluate: due to $changedDependency.');
    logDebug(
        '2/4.${elementPath ?? 'root'}, evaluate, start: ${_getDebugState()}, context(${evalContext}).');
    // if (hidden) {
    //   logDebug('_.${elementPath}, evaluate, return,no eval: is hidden.');
    //   return;
    // }
    if (_isEvaluating) {
      logDebug('_.${elementPath}, evaluate, return, no eval: _isEvaluating.');
      return;
    }

    _isEvaluating = true;

    if (_evaluationStack.contains(name)) {
      logError(
          '_.${elementPath ?? 'root'}, evaluate, error: Circular dependency detected on.');
      return;
    }

    _evaluationStack.add(name ?? 'root'); // Track current element

    try {
      // final previousState = elementState;
      for (var ruleAction in elementRuleActions) {
        logDebug(
            '3/4.$elementPath, evaluate, expression: ${ruleAction.expression}.');
        logDebug(
            '4/4.$elementPath, evaluate, result: ${ruleAction.evaluate(evalContext)}.');
        ruleAction.evaluate(evalContext)
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
    } catch (e) {
      logError('_.${elementPath ?? 'root'}, evaluate, error: $e.');
    } finally {
      _isEvaluating = false;
      _evaluationStack.remove(name); // Remove from stack after evaluation
    }
  }

  FormElementState<T> _calculateStatus() {
    logDebug('1/2.$elementPath, _calculateStatus: ${_getDebugState()}.');
    // if (allElementsHidden()) {
    //   logDebug('2/2.$elementPath, _calculateStatus, all hidden.');
    //   return _elementState.copyWith(
    //       hidden: true, errors: {}, mandatory: false, warning: '');
    // }

    final state = ruleEffectStateFactory.applyRuleEffects(
        elementState: elementState, calcResult: effectiveRuleEffects);
    return state;
  }

  String _getDebugState([FormElementState<T>? state]) =>
      'state(${(state ?? _elementState).hidden ? 'Hidden' : 'Visible'}), mandatory($mandatory)';

  void _setInitialStatus() {
    logDebug('1/2.$elementPath, _setInitialStatus: ${_getDebugState()}.');
    if (allElementsHidden()) {
      _elementState = _elementState.copyWith(
        hidden: true,
        errors: {},
        mandatory: false,
        warning: '',
      );
    } else {
      _elementState = _elementState.copyWith(
        hidden: false,
        mandatory: _template.mandatory,
      );
    }
    logDebug('2/2.$elementPath, _setInitialStatus: ${_getDebugState()}.');
  }

  void _updateAncestors(bool updateParent) {
    if (updateParent) {
      parentSection?.decideState(updateParent: updateParent);
    }
  }

  bool hasVisibilityRules() {
    return effectiveRuleEffects.any((rule) => rule.action.isVisibility);
  }

  void decideState({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    logDebug('1/3.$elementPath, updateValueAndValidity: ${_getDebugState()}.');
    // _setInitialStatus();
    if (hasVisibilityRules()) {
      final state = _calculateStatus();
      if (state.hidden) {
        logDebug('3/3.$elementPath, updateValueAndValidity, Hide.');
        markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
        elementControl!.reset(
            disabled: true, updateParent: false, emitEvent: false);
      } else {
        logDebug('3/3.$elementPath, updateValueAndValidity, Show.');
        markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
      }
    } else {
      markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
    }
    // if (visible) {
    //   logDebug(
    //       '2/3.$elementPath, updateValueAndValidity, calculated: ${_getDebugState(state)}.');
    //   markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
    //   // if (state.hidden) {
    //   //   logDebug('3/3.$elementPath, updateValueAndValidity, Hide.');
    //   //   markAsHidden(updateParent: updateParent, emitEvent: emitEvent);
    //   // } else {
    //   //   logDebug('3/3.$elementPath, updateValueAndValidity, Show.');
    //   //   markAsVisible(updateParent: updateParent, emitEvent: emitEvent);
    //   // }
    // }
    //
    // logDebug('2.$elementPath, updateValueAndValidity: ${_getDebugState()}.');
    //
    // if after `_calculateStatus()` it's became hidden
    // (this fix the initial status of an element when loading the form
    // if (hidden) {
    //   _elementState = _elementState.copyWith(mandatory: false);
    //   elementControl!.reset(disabled: true, emitEvent: emitEvent);
    // } else {
    //   // if after `_calculateStatus()` is still visible
    //   _elementState = _elementState.copyWith(mandatory: _template.mandatory);
    //   elementControl?.markAsEnabled(
    //       emitEvent: emitEvent, updateParent: updateParent);
    // }

    // updateStatus(_elementState, emitEvent: emitEvent);
    // _updateAncestors(state);
  }

  List<String> get dependencies => template.dependencies;

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
    // elementControl?.dispose();
    logDebug('${elementPath ?? 'root'} disposeMethod.');
    if (_resolvedDependencies.isNotEmpty)
      // propertiesChangedSubject?.close();
      _resolvedDependencies.forEach((FormElementInstance<dynamic> d) {
        logDebug(
            '${elementPath ?? 'root'}: unsubscribing from ${d.name ?? 'root'}.');
        d._dependents.remove(this);
      });
    _resolvedDependencies.clear();
  }
}
