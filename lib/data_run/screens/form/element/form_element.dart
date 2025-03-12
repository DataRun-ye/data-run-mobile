import 'dart:async';

import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/action.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/choice_filter.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/calculated_expression.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:datarunmobile/data_run/screens/form/element/exceptions/form_element_exception.dart';
import 'package:datarunmobile/data_run/screens/form/element/extension/rule.extension.dart';
import 'package:datarunmobile/data_run/screens/form/element/members/form_element_state.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

part 'extension/element_dependency.extension.dart';

part 'field_instance.dart';

part 'repeat_instance.dart';

part 'repeat_item_instance.dart';

part 'section_element.dart';

part 'section_instance.dart';

// part 'field_reference_instance.dart';

part 'gs1_scanned_item.dart';

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

  // void _updateControlsErrors() {
  //   _elementState = _calculateStatus();
  //   // _statusChanges.add(_status);
  //
  //   _parentSection?._updateControlsErrors();
  // }

  // FormElementState _calculateStatus() {
  //   if (allElementsHidden()) {
  //     return _elementState.copyWith(hidden: true);
  //   } else if (hasErrors) {
  //     return _elementState.copyWith(errors: errors);
  //   }
  //
  //   return _elementState;
  // }

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
    // elementControl!.updateValueAndValidity(
    //     updateParent: updateParent, emitEvent: emitEvent);
    // _updateAncestors(updateParent);
    // elementControl!.markAsDisabled();
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
    // updateValueAndValidity(updateParent: true, emitEvent: emitEvent);
    // _updateAncestors(updateParent);
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

  void evaluate(
      {String? changedDependency,
      bool updateParent = true,
      bool emitEvent = true}) {
    if (_isEvaluating) {
      return;
    }

    _isEvaluating = true;

    // if(hidden) {
    //   return;
    // }
    // if (dependencies.length == 0 || !dependencies.contains(changedDependency)) {
    //   return;
    // }

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
            ? ruleAction.apply(this)
            : ruleAction.reset(this);
      }
      // FormElementState newState = calculateState();

      // if (newState != previousState) {
      //   updateStatus(newState, emitEvent: emitEvent);
      // }
    } catch (e) {
      logError('Error Evaluating: ${name ?? 'root'}');
    } finally {
      _isEvaluating = false;
      _evaluationStack.remove(name); // Remove from stack after evaluation
    }
  }

  // FormElementState calculateState() {
  //   FormElementState newState = elementState.copyWith();
  //
  //   ///
  //   for (var ruleAction in elementRuleActions) {
  //     logDebug('Expression: ${ruleAction.expression}');
  //     logDebug('Evaluation Result: ${ruleAction.evaluate(evalContext)}');
  //     newState = ruleAction.evaluate(evalContext)
  //         ? ruleAction.apply(this)
  //         : ruleAction.reset(this);
  //   }
  //   return newState;
  // }
  //
  // void _updateAncestors(bool updateParent) {
  //   if (updateParent) {
  //     _parentSection?.updateValueAndValidity(updateParent: updateParent);
  //   }
  // }

  // FormElementState _calculateStatus() {
  //   if (allElementsHidden()) {
  //     elementControl?.markAsDisabled();
  //     return _elementState.copyWith(hidden: true, errors: {});
  //   } else if (elementControl?.hasErrors == true) {
  //     return _elementState.copyWith(errors: elementControl!.errors);
  //   }
  //
  //   elementControl?.markAsDisabled();
  //   return _elementState.copyWith(hidden: false, errors: {});
  // }

  void updateValueAndValidity({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    // if (visible) {
    //   _elementState = _calculateStatus();
    // }

    // if (emitEvent) {
    //   updateStatus(_elementState);
    // }

    // _updateAncestors(updateParent);
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
