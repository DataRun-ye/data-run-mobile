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
      : _elementState = ValueNotifier(elementState),
        _template = template;

  // Stream<FormElementState> get propertiesChanged =>
  //     (propertiesChangedSubject ??=
  //             BehaviorSubject<FormElementState>.seeded(_elementState))
  //         as Stream<FormElementState>;

  @protected
  BehaviorSubject<FormElementState?>? propertiesChangedSubject;

  final Template _template;

  Template get template => _template;

  ValueType? get type => template.type;

  bool _isEvaluating = false;
  FormGroup form;

  Iterable<RuleAction> get elementRuleActions => _template.ruleActions();

  List<RuleAction> get inEffectRuleActions => elementRuleActions
      .where((ruleAction) => ruleAction.evaluate(elementContext))
      .toList();

  final Set<FormElementInstance<dynamic>> _dependents = Set();

  // final Set<FormElementInstance<dynamic>> _resolvedDependencies = Set();

  Set<FormElementInstance<dynamic>> get dependents =>
      Set.unmodifiable(_dependents);

  // Set<FormElementInstance<dynamic>> get resolvedDependencies =>
  //     Set.unmodifiable(_resolvedDependencies);

  String? get name => template.name;

  String get label =>
      '${getItemLocalString(template.label.unlockView, defaultString: name)}${mandatory ? ' *' : ''}';

  SectionElement<dynamic>? _parentSection;

  SectionElement<dynamic>? get parentSection => _parentSection;

  set parentSection(SectionElement<dynamic>? parent) {
    if (mandatory) {}

    _parentSection = parent;
  }

  ValueNotifier<FormElementState> _elementState;

  ValueNotifier<FormElementState> get elementState => _elementState;

  Map<String, dynamic> get errors => _elementState.value.errors;

  bool get hasErrors => errors.isNotEmpty;

  bool get hidden => _elementState.value.hidden;

  bool get visible => !hidden;

  bool get mandatory => _elementState.value.mandatory;

  String? get elementPath => name == null ? null : pathBuilder(name!);

  String pathBuilder(String pathItem) =>
      [parentSection?.elementPath, pathItem].whereType<String>().join('.');

  T? get value => reduceValue();

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

  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    if (hidden) return;

    _elementState.value = _elementState.value.copyWith(hidden: true);

    elementControl!.reset(
        disabled: true, updateParent: updateParent, emitEvent: emitEvent);
  }

  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    if (visible) return;

    _elementState.value = _elementState.value.copyWith(hidden: false);
    if (template.mandatory) {
      markAsMandatory(emitEvent: false);
    }
    elementControl!
        .markAsEnabled(updateParent: updateParent, emitEvent: emitEvent);
  }

  void markAsMandatory({bool updateParent = true, bool emitEvent = true}) {
    if (mandatory) return;

    _elementState.value = _elementState.value.copyWith(mandatory: true);

    final elementValidators = [
      ...elementControl!.validators,
      Validators.required
    ];
    elementControl!.setValidators(elementValidators, autoValidate: true);
  }

  void markAsUnMandatory({bool updateParent = true, bool emitEvent = true}) {
    if (!mandatory) return;

    _elementState.value = _elementState.value.copyWith(mandatory: false);

    final elementValidators = [
      ...elementControl!.validators,
    ]..remove(Validators.required);

    elementControl!.setValidators(elementValidators,
        autoValidate: true, updateParent: updateParent, emitEvent: emitEvent);
  }

  void addError(String error, {bool markAsDirty = true}) {
    if (elementState.value.errors.keys.contains(error)) return;
    _elementState.value = _elementState.value
        .copyWith(errors: {..._elementState.value.errors, error: error});
    elementControl?.setErrors(errors, markAsDirty: markAsDirty);
  }

  void removeError(String key, {bool updateParent = true}) {
    _elementState.value =
        _elementState.value.copyWith(errors: {...errors}..remove(key));
    elementControl?.removeError(key);
  }

  final Map<String, dynamic> _elementContext = {};

  Map<String, dynamic> get elementContext => Map.unmodifiable(_elementContext);

  void updateContext<T>({required String name, T? value}) {
    final oldValue = _elementContext[name];
    if (oldValue == value) return;
    _elementContext[name] = value;
  }

  void evaluateDependencies<T>() {
    for (var ruleAction in elementRuleActions) {
      logDebug('Expression: ${ruleAction.expression}, of: $name');
      logDebug('Evaluation Context: $elementContext, of: $name');
      logDebug(
          'Evaluation Result: ${ruleAction.evaluate(elementContext)}, of: $name');
      ruleAction.evaluate(elementContext)
          ? ruleAction.apply(this)
          : ruleAction.reset(this);
    }
  }

  List<String> get dependencies => template.dependencies;

  void dispose() {
    // elementControl?.dispose();
    logDebug('element: ${name ?? 'root'}, disposeMethod');
    //   if (_resolvedDependencies.isNotEmpty)
    //     // propertiesChangedSubject?.close();
    //     _resolvedDependencies.forEach((FormElementInstance<dynamic> d) {
    //       logDebug('${name ?? 'root'}, unsubscribing from: ${d.name ?? 'root'}');
    //       d._dependents.remove(this);
    //     });
    //   _resolvedDependencies.clear();
    // }
  }
}
