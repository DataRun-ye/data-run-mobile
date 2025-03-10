import 'package:d2_remote/modules/datarun/form/shared/rule/choice_filter.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarun/data_run/screens/form/element/exceptions/form_element_exception.dart';
import 'package:datarun/data_run/screens/form_module/form/code_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

part 'field_element_model.dart';

part 'form_collection_element.dart';

part 'section_element_model.dart';

part 'repeat_element_model.dart';

part 'repeat_item_element_model.dart';

// part 'element_dependency.extension.dart';

enum ElementStatus {
  /// The element has passed all validation checks.
  valid,

  /// The element has failed at least one validation check.
  invalid,

  /// This element is exempt from validation checks.
  hidden,
}

sealed class FormElementModel<T> {
  FormElementModel({
    this.templatePath,
    T? value,
    bool valid = true,
    bool hidden = false,
    bool dirty = false,
  })  : _value = value,
        _status = hidden ? ElementStatus.hidden : ElementStatus.valid,
        _dirty = dirty;
  Stream<ElementStatus> get propertiesChanged => (_statusChanges ??=
      BehaviorSubject<ElementStatus>.seeded(status)) as Stream<ElementStatus>;

  @protected
  BehaviorSubject<ElementStatus?>? _statusChanges;

  String? get name => templatePath?.split('.').last;

  final String? templatePath;
  CollectionElementModel<dynamic>? _parent;

  T? _value;

  ElementStatus _status;

  bool _dirty;

  final Map<String, dynamic> _errors = {};

  CollectionElementModel<dynamic>? get parent => _parent;

  T? get value => reduceValue();

  ElementStatus get status => _status;

  bool get hidden => status == ElementStatus.hidden;

  bool get visible => !hidden;

  bool get valid => status == ElementStatus.valid;

  bool get invalid => status == ElementStatus.invalid;

  bool get dirty => _dirty;

  Map<String, Object> get errors => Map.unmodifiable(_errors);

  bool get hasErrors => errors.isNotEmpty;

  void _updateValue() {
    _value = reduceValue();
  }

  set parent(CollectionElementModel<dynamic>? parent) {
    _parent = parent;
  }

  String? get elementPath => name == null ? null : pathBuilder(name);

  String pathBuilder(String? pathItem) =>
      [parent?.elementPath, pathItem].whereType<String>().join('.');

  ElementStatus _calculateStatus() {
    if (allElementsHidden()) {
      return ElementStatus.hidden;
    } else if (errors.isNotEmpty) {
      return ElementStatus.invalid;
    } else if (anyElementsHaveStatus(ElementStatus.invalid)) {
      return ElementStatus.invalid;
    }

    return ElementStatus.valid;
  }

  void updateValue(T? value, {bool updateParent = true, bool emitEvent = true});

  void markAsDirty({bool updateParent = true, bool emitEvent = true}) {
    _dirty = true;
    if (updateParent) {
      parent?.markAsDirty(updateParent: updateParent);
    }
  }

  void markAsHidden({bool updateParent = true, bool emitEvent = true}) {
    if (hidden) {
      return;
    }

    _errors.clear();
    _status = ElementStatus.hidden;
    // if (emitEvent) {
    //   _statusChanges.add(_status);
    // }
    _updateAncestors(updateParent);
  }

  void markAsVisible({bool updateParent = true, bool emitEvent = true}) {
    if (visible) {
      return;
    }
    _status = ElementStatus.valid;
    updateValueAndValidity(updateParent: true, emitEvent: emitEvent);
    _updateAncestors(updateParent);
  }

  void updateValueAndValidity({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    _updateValue();
    if (visible) {
      _status = _calculateStatus();
    }

    if (emitEvent) {
      // _valueChanges.add(value);
      _statusChanges?.add(_status);
    }

    _updateAncestors(updateParent);
  }

  void _updateAncestors(bool updateParent) {
    if (updateParent) {
      parent?.updateValueAndValidity(updateParent: updateParent);
    }
  }

  void _updateElementsErrors() {
    _status = _calculateStatus();
    _statusChanges?.add(_status);

    parent?._updateElementsErrors();
  }

  void setErrors(Map<String, dynamic> errors, {bool markAsDirty = true}) {
    _errors.clear();
    _errors.addAll(errors);

    _updateElementsErrors();

    if (markAsDirty) {
      this.markAsDirty(emitEvent: false);
    }
  }

  void removeError(String key, {bool markAsDirty = false}) {
    _errors.removeWhere((errorKey, dynamic value) => errorKey == key);
    _updateElementsErrors();

    if (markAsDirty) {
      this.markAsDirty(emitEvent: false);
    }
  }

  @protected
  bool allElementsHidden() => hidden;

  @protected
  bool anyElementsHaveStatus(ElementStatus status) => false;

  bool anyElements(bool Function(FormElementModel<dynamic>) condition);

  @protected
  void forEachChild(void Function(FormElementModel<dynamic> element) callback);

  @protected
  FormElementModel<dynamic>? findElement(String path);

  T? reduceValue();

  /// Sometimes, we might need to consider only certain elements or sections based
  /// on context, such as when gathering data for form submission (only values
  /// of fields without sections) vs. dependency resolution (where sections
  /// are relevant).
  ///
  /// **Example:**
  ///
  /// - When exporting data, use:
  ///
  /// ```dart
  /// // to collect only field values.
  /// traverse(filter: (element) => element is FieldElementModel)
  /// ```
  /// - When resolving dependencies, use:
  ///
  /// ```dart
  /// // to include relevant scopes.
  /// traverse(filter: (element) => element is SectionElementModel || element is RepeatElementModel)
  /// ```
  Iterable<E> traverse<E extends FormElementModel<dynamic>>(
      {bool Function(FormElementModel<dynamic> element)? filter}) sync* {
    if (filter == null || filter(this)) yield this as E;
    if (this is SectionElementModel) {
      for (final child in (this as SectionElementModel).elements.values) {
        yield* child.traverse(filter: filter);
      }
    }

    if (this is RepeatElementModel) {
      for (final child in (this as RepeatElementModel).elements) {
        yield* child.traverse(filter: filter);
      }
    }
  }

  TFormElement? getFirstParentOfType<
      TFormElement extends CollectionElementModel<dynamic>>() {
    var currentParent = parent;
    while (currentParent != null) {
      if (currentParent is TFormElement) {
        return currentParent;
      }
      currentParent = currentParent.parent;
    }
    return null;
  }

  @mustCallSuper
  void evaluate([String? changedDependency]) {
    logDebug('$name, dependencyChanged');
    // if (_isEvaluating) {
    //   return;
    // }

    // _isEvaluating = true;

    // try {
    //   elementRuleActions.forEach((ruleAction) {
    //     logDebug(
    //         info:
    //             '$name\'s Evaluating: ${ruleAction.expression}, action: ${ruleAction.action}');
    //     ruleAction.evaluate(evalContext)
    //         ? ruleAction.apply(this)
    //         : ruleAction.reset(this);
    //   });
    // } catch (e) {
    //   logError('Error Evaluating: ');
    // } finally {
    //   _isEvaluating = false;
    // }
  }

  FormElementModel<dynamic> getInstance();

  FormElementModel<dynamic> clone(CollectionElementModel<dynamic>? parent);
}
