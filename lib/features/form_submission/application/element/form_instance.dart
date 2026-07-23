import 'dart:convert';

import 'package:datarunmobile/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_exception.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// const formUid = 'formDataUid';
const orgUnitControlName = 'orgUnit';
const formAttributesGroupName = 'attributes';
const formDataGroupName = 'formData';

const formControlName = 'formData';
const activityControlName = 'formData';
const teamControlName = 'formData';
const versionControlName = 'formData';

class FormInstance {
  FormInstance(
      {required this.form,
      required this.formFlatTemplate,
      required this.formMetadata,
      required this.entryStarted,
      required this.fieldKeysRegistery,
      required this.submissionId,
      // AssignmentStatus? assignmentStatus,
      Map<String, Object?> initialValue = const {},
      required Section rootSection,
      required this.enabled})
      : _formSection = rootSection {
    _initialValue.addAll({...initialValue});
    if (!enabled) {
      form.markAsDisabled();
    }
  }

  Map<String, Object?> _initialValue = {};
  final DateTime entryStarted;

  final String submissionId;

  // final Object _formDataUid;
  final FormGroup form;
  final FormTemplateRepository formFlatTemplate;
  final bool enabled;

  // final Ref _ref;
  final Section _formSection;
  final FieldContextRegistry fieldKeysRegistery;

  final _db = appLocator<AppDatabase>();
  bool _disposed = false;

  // final FormConfiguration formConfiguration;

  Section get formSection => _formSection;

  final FormMetadata formMetadata;

  // String? get submissionUid => formMetadata.submission;

  Future<void> saveFormData() async {
    final totalWatch = Stopwatch()..start();
    final loadWatch = Stopwatch()..start();
    final formSubmission = await _db.dataInstancesDao.getById(submissionId);
    loadWatch.stop();

    final reduceWatch = Stopwatch()..start();
    final formValue = RepeatMetadataNormalizer.normalizeFormData(
      Map<String, dynamic>.from(formSection.value),
      submissionUid: submissionId,
    );
    reduceWatch.stop();
    // final formErrors = form.errors;
    // logDebug('formValid: ${form.valid},formErrors: ${formErrors.toString()}');
    formValue.forEach((key, value) {
      _initialValue.update(
        key,
        (_) => value,
        ifAbsent: () => value,
      );
    });

    // formSubmission.status = _assignmentStatus;
    final mergeWatch = Stopwatch()..start();
    final formData = (formSubmission!.formData ?? {})
      ..removeWhere((k, v) => !metadata.contains(k))
      ..addAll(formValue);
    mergeWatch.stop();

    final updateWatch = Stopwatch()..start();
    await _db.dataInstancesDao.updateData(submissionId, data: formData);
    updateWatch.stop();
    totalWatch.stop();

    if (kDebugMode) {
      logInfo('form save metrics', data: {
        'submissionId': submissionId,
        'totalMs': totalWatch.elapsedMilliseconds,
        'loadMs': loadWatch.elapsedMilliseconds,
        'reduceMs': reduceWatch.elapsedMilliseconds,
        'mergeMs': mergeWatch.elapsedMilliseconds,
        'dbUpdateMs': updateWatch.elapsedMilliseconds,
        'topLevelKeys': formData.length,
        'repeatRowCount': _countRepeatRows(formData),
        'jsonBytes': _jsonByteLengthOrNull(formData),
      });
    }

    // return updatedSubmission;
  }

  // Future<DataInstance> saveSubmission() async {
  //   final formValue = formSection.value;
  //   final formErrors = form.errors;
  //   logDebug('formValid: ${form.valid},formErrors: ${formErrors.toString()}');
  //   formValue.forEach((key, value) {
  //     _initialValue.update(
  //       key,
  //       (_) => value,
  //       ifAbsent: () => value,
  //     );
  //   });
  //
  //   // formSubmission.status = _assignmentStatus;
  //   formSubmission.formData ?? {}
  //     ..removeWhere((k, v) => !metadata.contains(k))
  //     ..addAll(formValue);
  //
  //   final updatedSubmission =
  //       await formSubmissionList.updateSubmission(formSubmission);
  //   return updatedSubmission;
  // }

  RepeatItemInstance onAddRepeatedItem(RepeatSection parent) {
    parent.elementControl.add(
      FormControl<Map<String, Object?>>(value: const {}),
      emitEvent: false,
    );

    final itemInstance = FormElementBuilder.buildRepeatItem(
        form, formFlatTemplate, parent.template);
    parent.add(itemInstance);
    itemInstance.bindControlReferences();
    itemInstance.resolveDependencies();
    itemInstance.evaluate(emitEvent: false);
    parent.elementControl.markAsDirty();
    return itemInstance;
  }

  void materializeRepeatItem(RepeatItemInstance item) {
    final parent = item.parentSection as RepeatSection;
    final index =
        parent.sectionIndexWhere((element) => identical(element, item));
    if (index < 0) {
      throw StateError('Cannot materialize a repeat row outside its parent');
    }
    final array = parent.mountedControl;
    if (array == null) {
      throw StateError('Cannot materialize a row while its parent is dormant');
    }
    if (array.controls[index] is FormGroup) {
      return;
    }

    final dormantControl = array.removeAt(
      index,
      emitEvent: false,
      updateParent: false,
    );
    final itemFormGroup = FormElementControlBuilder.createSectionFormGroup(
      formFlatTemplate,
      parent.template,
      initialValue: item.retainedValue,
    );
    if (dormantControl.dirty) {
      itemFormGroup.markAsDirty(updateParent: false, emitEvent: false);
    }
    if (dormantControl.touched) {
      itemFormGroup.markAsTouched(updateParent: false, emitEvent: false);
    }
    array.insert(
      index,
      itemFormGroup,
      emitEvent: false,
      updateParent: true,
    );
    dormantControl.dispose();

    item.bindControlReferences();
    item.evaluate(emitEvent: false);
  }

  void dematerializeRepeatItem(RepeatItemInstance item) {
    final parent = item.parentSection;
    if (parent is! RepeatSection) {
      return;
    }
    final index =
        parent.sectionIndexWhere((element) => identical(element, item));
    final array = parent.mountedControl;
    if (index < 0 || array == null || index >= array.controls.length) {
      return;
    }
    final itemControl = array.controls[index];
    if (itemControl is! FormGroup) {
      return;
    }

    item.captureMountedValues();
    item.releaseControlReferences();
    final dormantControl = FormControl<Map<String, Object?>>(
      value: item.retainedValue,
      disabled: item.hidden,
    );
    if (itemControl.dirty) {
      dormantControl.markAsDirty(updateParent: false, emitEvent: false);
    }
    if (itemControl.touched) {
      dormantControl.markAsTouched(updateParent: false, emitEvent: false);
    }
    array.removeAt(index, emitEvent: false, updateParent: false);
    array.insert(
      index,
      dormantControl,
      emitEvent: false,
      updateParent: true,
    );
    itemControl.dispose();
  }

  RepeatItemInstance onRemoveRepeatedItem(int index, RepeatSection parent) {
    return removeRepeatedItems([parent.elements[index]], parent).single;
  }

  RepeatItemInstance removeRepeatedItem(
    RepeatItemInstance item,
    RepeatSection parent,
  ) {
    return removeRepeatedItems([item], parent).single;
  }

  List<RepeatItemInstance> removeRepeatedItems(
    Iterable<RepeatItemInstance> items,
    RepeatSection parent,
  ) {
    final uniqueItems = Set<RepeatItemInstance>.identity()..addAll(items);
    if (uniqueItems.isEmpty) {
      return const [];
    }

    final indexedItems = uniqueItems.map((item) {
      final index =
          parent.sectionIndexWhere((element) => identical(element, item));
      if (index < 0) {
        throw StateError('Cannot remove a repeat row outside its parent');
      }
      return (index: index, item: item);
    }).toList();

    if (parent.elementControl.controls.length != parent.elements.length) {
      throw StateError('Repeat rows and controls are out of sync');
    }

    indexedItems.sort((left, right) => right.index.compareTo(left.index));
    for (var position = 0; position < indexedItems.length; position++) {
      final indexedItem = indexedItems[position];
      indexedItem.item.dispose();
      final removedControl = parent.elementControl.removeAt(
        indexedItem.index,
        emitEvent: false,
        updateParent: false,
      );
      final removedItem = parent.removeAt(
        indexedItem.index,
        emitEvent: position == indexedItems.length - 1,
        updateParent: false,
      );
      assert(identical(removedItem, indexedItem.item));
      removedControl.dispose();
    }

    parent.elementControl.updateValueAndValidity();
    parent.elementControl.markAsDirty();
    parent.evaluate(emitEvent: true);
    return indexedItems.map((entry) => entry.item).toList(growable: false);
  }

  RepeatItemInstance restoreRepeatedItem(
    RepeatItemInstance item,
    RepeatSection parent,
    Map<String, Object?> value, {
    required bool dirty,
    required bool touched,
  }) {
    final index =
        parent.sectionIndexWhere((element) => identical(element, item));
    if (index < 0) {
      throw StateError('Cannot restore a repeat row outside its parent');
    }

    item.dispose();
    final removedControl = parent.elementControl.removeAt(
      index,
      emitEvent: false,
      updateParent: false,
    );
    removedControl.dispose();
    parent.removeAt(index, emitEvent: false, updateParent: false);

    final restoredItem = FormElementBuilder.buildRepeatItem(
      form,
      formFlatTemplate,
      parent.template,
      initialFormValue: value,
    );
    parent.insert(
      index,
      restoredItem,
      emitEvent: false,
      updateParent: false,
    );
    final restoredControl = FormControl<Map<String, Object?>>(
      value: value,
    );
    if (dirty) {
      restoredControl.markAsDirty(updateParent: false, emitEvent: false);
    }
    if (touched) {
      restoredControl.markAsTouched(updateParent: false, emitEvent: false);
    }
    parent.elementControl.insert(
      index,
      restoredControl,
      emitEvent: false,
      updateParent: true,
    );

    restoredItem.bindControlReferences();
    _formSection.resolveDependencies();
    _formSection.evaluate(emitEvent: true);
    parent.elementControl.updateValueAndValidity();
    return restoredItem;
  }

  Future<void> markSubmissionAsFinal() {
    return _db.dataInstancesDao.markFinal(submissionId);
  }

  TextInputAction fieldInputAction(String elementPath) {
    return _hasFocusableFieldNext(elementPath)
        ? TextInputAction.next
        : TextInputAction.done;
  }

  /// when user hits the keyboard action…
  Future<void> moveToNextElement(String elementPath) async {
    // 3) ask FormInstance for the next visible field’s path
    final nextElement = _getNextVisibleField(elementPath);

    if (nextElement == null) {
      form.unfocus(); // just blur if there’s no next
      return;
    }

    final nextPath = nextElement.elementPath!;

    if (nextElement.type?.isText == true) {
      // reactive_forms will focus its hidden FocusNode, and keyboard stays up
      form.focus(nextPath);
    } else {
      // hide the keyboard
      form.unfocus();
      // // ensure the widget is in view
      final key = fieldKeysRegistery.getKey(nextPath);
      if (key?.currentContext != null) {
        await Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      }

      // 3) finally, give it focus (if you want the focus ring / styling)
      form.focus(nextPath);
    }
  }

  bool _hasFocusableFieldNext(String elementPath) {
    // 3) ask FormInstance for the next visible field’s path
    final nextElement = _getNextVisibleField(elementPath);

    return nextElement?.type?.isText == true;
  }

  /// Returns the elementPath of the next visible FieldInstance, or null if none.
  FormElementInstance<dynamic>? _getNextVisibleField(String currentPath) {
    final allFields =
        getFormElementIterator<FieldInstance<dynamic>>(_formSection)
            .where((e) => e.elementPath != null)
            .where((e) => !e.hidden)
            .toList();

    final idx =
        allFields.indexWhere((element) => element.elementPath == currentPath);
    if (idx == -1 || idx + 1 >= allFields.length) return null;
    final nextElement = allFields[idx + 1];

    return nextElement;
  }

  void onErrorTap(String elementPath) {
    try {
      final SectionElement<dynamic>? elementParent =
          formSection.element(elementPath).parentSection;

      final parentIsRepeat = elementParent is RepeatItemInstance;
      final elementPathToScrollTo = parentIsRepeat
          ? elementParent.parentSection!.elementPath!
          : elementPath;
      final key = fieldKeysRegistery.getKey(elementPathToScrollTo);
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 300),
          alignment: 0.2,
          curve: Curves.easeInOut,
        );
      }
    } on FormElementNotFoundException catch (e, st) {
      logError('Element With Path: $elementPath, not found: $e',
          stackTrace: st);
    }
  }

  void markElementAsTouched(String elementPath) {
    final element = formSection.element(elementPath);
    final control = element.mountedControl;
    if (control != null) {
      control.markAsTouched();
      return;
    }

    SectionElement<dynamic>? parent = element.parentSection;
    while (parent != null && parent is! RepeatItemInstance) {
      parent = parent.parentSection;
    }
    parent?.parentSection?.mountedControl?.markAsTouched();
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;

    _formSection.dispose();
    form.dispose();
  }
}

const List<String> metadata = [
  '_deleted',
  '_submissionUid',
  '_form',
  '_deviceId',
  '_orgUnit',
  '_orgUnitName',
  '_assignment',
  '_activity',
  '_orgUnitCode',
  '_teamOld',
  '_version',
  '_username',
  '_workDay',
  '_status',
  '_team',
  '_teamCode',
  '_serialNumber'
];

int _countRepeatRows(Object? value) {
  if (value is List) {
    var total = 0;
    for (final item in value) {
      if (item is Map) {
        total++;
      }
      total += _countRepeatRows(item);
    }
    return total;
  }

  if (value is Map) {
    return value.values.fold<int>(
      0,
      (total, child) => total + _countRepeatRows(child),
    );
  }

  return 0;
}

int? _jsonByteLengthOrNull(Object? value) {
  try {
    return utf8.encode(jsonEncode(value)).length;
  } catch (_) {
    return null;
  }
}
