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
// part 'field_reference_instance.dart';

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
      required FormElementState elementState})
      : _elementState = elementState,
        _template = template;

  Stream<FormElementState> get propertiesChanged =>
      (propertiesChangedSubject ??=
              BehaviorSubject<FormElementState>.seeded(_elementState))
          as Stream<FormElementState>;

  @protected
  BehaviorSubject<FormElementState?>? propertiesChangedSubject;

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

  FormElementState _elementState;

  FormElementState get elementState => _elementState;

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
    logDebug('${name}, mark as Hidden');
    if (hidden) {
      return;
    }
    updateStatus(_elementState.copyWith(hidden: true, errors: {}),
        emitEvent: emitEvent);
    elementControl!.reset(
        disabled: true, updateParent: updateParent, emitEvent: emitEvent);

    // updateValueAndValidity(updateParent: true, emitEvent: false);
    // updateValueAndValidity(updateParent: updateParent, emitEvent: emitEvent);
  }

  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    logDebug('${name}, mark as visible');
    if (template is FieldTemplate && (template as FieldTemplate).mandatory) {
      markAsMandatory(emitEvent: false);
    }
    if (!hidden) {
      return;
    }

    updateStatus(_elementState.copyWith(hidden: false), emitEvent: emitEvent);
    elementControl!
        .markAsEnabled(updateParent: updateParent, emitEvent: emitEvent);
    updateValueAndValidity(updateParent: true, emitEvent: false);
    // updateValueAndValidity(updateParent: updateParent, emitEvent: emitEvent);
  }

  void markAsMandatory({bool updateParent = true, bool emitEvent = true}) {
    // logDebug('${name}, markAsMandatory');
    if (mandatory) {
      return;
    }
    updateStatus(_elementState.copyWith(mandatory: true), emitEvent: emitEvent);

    final elementValidators = [
      ...elementControl!.validators,
      Validators.required
    ];
    elementControl!.setValidators(elementValidators, autoValidate: true);
  }

  void markAsUnMandatory({bool updateParent = true, bool emitEvent = true}) {
    updateStatus(_elementState.copyWith(mandatory: false),
        emitEvent: emitEvent);
    final elementValidators = [
      ...elementControl!.validators,
    ]..remove(Validators.required);

    elementControl!.setValidators(elementValidators,
        autoValidate: true, updateParent: updateParent, emitEvent: emitEvent);
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

  void reset({T? value});

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
    if (_isEvaluating) {
      return;
    }

    _isEvaluating = true;

    logDebug(
        'Evaluating ${name ?? 'root'} due to change in $changedDependency');
    logDebug('Evaluation Context for ${name ?? 'root'}: ${evalContext}');

    if (_evaluationStack.contains(name)) {
      logError('Circular dependency detected on: ${name ?? 'root'}');
      return;
    }

    _evaluationStack.add(name ?? 'root'); // Track current element

    try {
      // final previousState = elementState;
      for (var ruleAction in elementRuleActions) {
        logDebug('Expression: ${ruleAction.expression}');
        logDebug('Evaluation Result: ${ruleAction.evaluate(evalContext)}');
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
      logError('Error Evaluating: ${name ?? 'root'}');
    } finally {
      _isEvaluating = false;
      _evaluationStack.remove(name); // Remove from stack after evaluation
    }
  }

  FormElementState _calculateStatus() {
    if (allElementsHidden()) {
      return _elementState.copyWith(
          hidden: true, errors: {}, mandatory: false, error: '', warning: '');
    }

    final state = ruleEffectStateFactory.applyRuleEffects(
        elementState: elementState, calcResult: effectiveRuleEffects);
    // if (state.isVisible) {
    //   elementControl!.markAsEnabled(emitEvent: false);
    // }
    logDebug(
        '_calculateStatus: $name, result: ${state.hidden ? 'Hidden' : 'Visible'}');
    return state;
  }

  void _setInitialStatus() {
    if (allElementsHidden()) {
      _elementState = _elementState.copyWith(
        hidden: true,
        errors: {},
        mandatory: false,
        error: '',
        warning: '',
      );
      // elementControl!.reset(disabled: true, emitEvent: false);
    } else {
      _elementState =
          _elementState.copyWith(hidden: false, mandatory: mandatory);
    }
    logDebug('I am:$name, setting: ${hidden ? 'Hidden' : 'Visible'}');
  }

  void _updateAncestors(bool updateParent) {
    if (updateParent) {
      parentSection?.updateValueAndValidity(updateParent: updateParent);
    }
  }

  void updateValueAndValidity({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    logDebug(
        'updateValueAndValidity: $name, current: ${hidden ? 'Hidden' : 'Visible'}, updateParent: $updateParent, emitEvent: $emitEvent');
    _setInitialStatus();
    if (visible) {
      _elementState = _calculateStatus();
    }

    // if after `_calculateStatus()` it's became hidden
    // (this fix the initial status of an element when loading the form
    if (hidden) {
      _elementState = _elementState.copyWith(mandatory: false);
      elementControl!.reset(disabled: true, emitEvent: false);
    } else {
      // if after `_calculateStatus()` is still visible
      _elementState = _elementState.copyWith(mandatory: _template.mandatory);
      elementControl?.markAsEnabled(emitEvent: emitEvent, updateParent: true);
    }

    updateStatus(_elementState, emitEvent: emitEvent);
    _updateAncestors(updateParent);
    elementControl!.updateValueAndValidity(
      updateParent: updateParent,
      emitEvent: emitEvent,
    );
  }

  List<String> get dependencies => template.dependencies;

  List<String> get resolvedDependencyNames =>
      _resolvedDependencies.map((dependency) => dependency.name!).toList();

  void resolveDependencies() {
    if (dependencies.isEmpty) {
      logDebug('${name ?? 'root'} has no dependencies to resolve.');
      return;
    }

    logDebug('Resolving dependencies', data: {
      'element': name ?? 'root',
      'dependencies': dependencies,
    });

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
      logWarning('Could not resolve some dependencies', data: {
        'element': name ?? 'root',
        'unresolved_dependencies': unresolvedDependencies,
      });
    }

    if (resolvedDependencies.isNotEmpty) {
      logDebug('Resolved dependencies', data: {
        'element': name ?? 'root',
        'resolved_dependencies': resolvedDependencyNames,
      });
    }
  }

  //
  // void resolveDependencies() {
  //   if (dependencies.length > 0) {
  //     logDebug('$name, resolving dependencies: $dependencies');
  //   }
  //
  //   for (final dependencyName in dependencies) {
  //     final dependency = findElementInParentSection(dependencyName);
  //     if (dependency != null) {
  //       _resolvedDependencies.add(dependency);
  //       dependency._addDependent(this);
  //     }
  //   }
  //
  //   if (resolvedDependencies.length != dependencies.length) {
  //     logDebug(
  //         info:
  //             '$name, could not resolve dependencies: ${dependencies..where((dependency) => !resolvedDependencyNames.contains(dependency))}');
  //   }
  //
  //   if (resolvedDependencies.length > 0) {
  //     logDebug(
  //         info:
  //         '$name, resolve dependencies: $resolvedDependencyNames');
  //   }
  // }

  void dispose() {
    // elementControl?.dispose();
    logDebug('element: ${name ?? 'root'}, disposeMethod');
    if (_resolvedDependencies.isNotEmpty)
      // propertiesChangedSubject?.close();
      _resolvedDependencies.forEach((FormElementInstance<dynamic> d) {
        logDebug('${name ?? 'root'}, unsubscribing from: ${d.name ?? 'root'}');
        d._dependents.remove(this);
      });
    _resolvedDependencies.clear();
  }
}
