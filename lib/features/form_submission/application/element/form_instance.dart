import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_exception.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  FormInstance(Ref ref,
      {required this.form,
      required this.formFlatTemplate,
      required this.formMetadata,
      required this.entryStarted,
      required this.fieldKeysRegistery,
      // AssignmentStatus? assignmentStatus,
      Map<String, Object?> initialValue = const {},
      required Section rootSection,
      Map<String, FormElementInstance<dynamic>> elements = const {},
      required this.enabled})
      : _ref = ref,
        _formSection = rootSection {
    var formElementMap = {
      for (var x
          in getFormElementIterator<FormElementInstance<dynamic>>(rootSection)
              .where((e) => e.elementPath != null))
        x.elementPath!: x
    };
    _forElementMap.addAll(formElementMap);
    _initialValue.addAll({...initialValue});
    if (!enabled) {
      form.markAsDisabled();
    }
  }

  Map<String, Object?> _initialValue = {};
  final DateTime entryStarted;

  // final Object _formDataUid;
  final FormGroup form;
  final FormTemplateRepository formFlatTemplate;
  final bool enabled;

  final Ref _ref;
  final Map<String, FormElementInstance<dynamic>> _forElementMap = {};
  final Section _formSection;
  AssignmentStatus? _assignmentStatus;
  final FieldContextRegistry fieldKeysRegistery;

  // final FormConfiguration formConfiguration;

  Map<String, FormElementInstance<dynamic>> get forElementMap =>
      Map.unmodifiable(_forElementMap);

  Section get formSection => _formSection;

  FormSubmissions get formSubmissionList => _ref.read(
      formSubmissionsProvider(formMetadata.formId.split('_').first).notifier);

  final FormMetadata formMetadata;

  String? get submissionUid => formMetadata.submission;

  Future<DataInstance> saveFormData() async {
    final formSubmission =
        await formSubmissionList.getSubmission(submissionUid!);

    return _saveSubmission(formSubmission!);
  }

  Future<DataInstance> _saveSubmission(DataInstance formSubmission) async {
    final formValue = formSection.value;
    final formErrors = form.errors;
    logDebug('formValid: ${form.valid},formErrors: ${formErrors.toString()}');
    formValue.forEach((key, value) {
      _initialValue.update(
        key,
        (_) => value,
        ifAbsent: () => value,
      );
    });

    // formSubmission.status = _assignmentStatus;
    formSubmission.formData ?? {}
      ..removeWhere((k, v) => !metadata.contains(k))
      ..addAll(formValue);

    final updatedSubmission =
        await formSubmissionList.updateSubmission(formSubmission);
    return updatedSubmission;
  }

  void updateSubmissionStatus(AssignmentStatus? status) async {
    _assignmentStatus = status;
  }

  RepeatItemInstance onAddRepeatedItem(RepeatSection parent) {
    final itemFormGroup = FormElementControlBuilder.createSectionFormGroup(
        formFlatTemplate, parent.template);

    parent.elementControl.add(itemFormGroup, emitEvent: false);

    final itemInstance = FormElementBuilder.buildRepeatItem(
        form, formFlatTemplate, parent.template);
    parent..add(itemInstance);
    // ..resolveDependencies()
    // ..evaluate();
    itemInstance.resolveDependencies();
    itemInstance.evaluate(emitEvent: false);
    // parent.elementControl.markAsDirty(updateParent: false);
    // parent.updateValueAndValidity(emitEvent: false);
    return itemInstance;
  }

  RepeatItemInstance onRemoveRepeatedItem(int index, RepeatSection parent) {
    final removedItem = parent.removeAt(index);
    parent.elementControl.removeAt(index);
    parent.evaluate(emitEvent: true);
    return removedItem;
  }

  RepeatItemInstance? onRemoveLastItem(RepeatSection parent) {
    try {
      final parentArray = form.control(parent.elementPath!) as FormArray;
      final lastParentItem = parent.elements.last;
      final itemFormGroup = form.control(lastParentItem.elementPath!);
      parent.remove(lastParentItem);
      parent.evaluate();
      parentArray.remove(itemFormGroup);
      logDebug('last Item deleted');
      return lastParentItem;
    } catch (e) {
      logError('last Item not exist');
      return null;
    }
  }

  Future<void> markSubmissionAsFinal() {
    return formSubmissionList.markSubmissionAsFinal(submissionUid!);
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
    final registry = appLocator<FieldContextRegistry>();
    try {
      final SectionElement<dynamic>? elementParent =
          formSection.element(elementPath).parentSection;

      final parentIsRepeat = elementParent is RepeatItemInstance;
      final elementPathToScrollTo = parentIsRepeat
          ? elementParent.parentSection!.elementPath!
          : elementPath;
      final key = registry.getKey(elementPathToScrollTo);
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

///////////////

// void onAddRepeatedItem(RepeatInstance parentTableInstance) {
//   final elementFormGroupControl =
//   ElementControlBuilder.forSection(parentTableInstance.template);
//   final RepeatItemInstance elementInstance =
//   ElementInstanceBuilder.forRepeatItem(
//       forFlatTemplate, parentTableInstance.template);
//   final parentArray =
//   form.control(parentTableInstance.elementPath!) as FormArray;
//
//   parentArray.add(elementFormGroupControl, emitEvent: false);
//   parentTableInstance.add(elementInstance,
//       updateParent: true, emitEvent: false);
//   elementInstance
//     ..resolveDependencies()
//     ..evaluate(emitEvent: false);
// }

// bool onSaveRepeatedItem(
//     RepeatInstance parentTableInstance, RepeatItemInstance elementInstance) {
//   final parentArray =
//   form.control(parentTableInstance.elementPath!) as FormArray;
//   final elementFormGroupControl =
//   parentArray.control(elementInstance.name) as FormGroup;
//   if (elementFormGroupControl.valid) {
//     parentArray.markAsTouched();
//     return true;
//   } else {
//     return false;
//   }
// }

// bool onRepeatItemAddCancel(
//     RepeatInstance parentTableInstance, RepeatItemInstance elementInstance,
//     {required bool isNew}) {
//   final elementFormGroupControl = parentTableInstance.elementControl
//       .control(elementInstance.name) as FormGroup;
//   if (isNew) {
//     if (elementFormGroupControl.valid) {
//       parentTableInstance.elementControl.markAsTouched();
//       return true;
//     }
//     parentTableInstance.elementControl.markAsTouched();
//     return false;
//   } else if (elementFormGroupControl.dirty) {
//     if (elementFormGroupControl.valid) {
//       parentTableInstance.elementControl.markAsTouched();
//       return true;
//     }
//     parentTableInstance.elementControl.markAsTouched();
//     return false;
//   } else {
//     if (elementFormGroupControl.valid) {
//       return true;
//     }
//     return false;
//   }
// }

//
// ElementExtendedControl createNewItemExtendedControl(
//     RepeatInstance repeatInstance) {
//   final parentArrayControl =
//   form.control(repeatInstance.elementPath!) as FormArray;
//   final itemControl =
//   ElementControlBuilder.forSection(repeatInstance.template);
//   final itemInstance = ElementInstanceBuilder.forRepeatItem(
//       forFlatTemplate, repeatInstance.template);
//   parentArrayControl.add(itemControl);
//   repeatInstance
//     ..add(itemInstance)
//     ..resolveDependencies()
//     ..evaluate();
//   return ElementExtendedControl(itemControl, itemInstance);
// }

// ElementExtendedControl getNextItemExtendedControl(
//     RepeatInstance repeatInstance,
//     {required int currentIndex}) {
//   final parentArrayControl =
//   form.control(repeatInstance.elementPath!) as FormArray;
//
//   final nextIndex = currentIndex + 1;
//   if (parentArrayControl.contains('$nextIndex') &&
//       repeatInstance.contains('$nextIndex')) {
//     final nextItemControl =
//     parentArrayControl.control('$nextIndex') as FormGroup;
//
//     final nextItemInstance =
//     repeatInstance.element('$nextIndex') as RepeatItemInstance;
//     return ElementExtendedControl(nextItemControl, nextItemInstance);
//   } else {
//     return createNewItemExtendedControl(
//         repeatInstance); // No more items to edit
//   }
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
