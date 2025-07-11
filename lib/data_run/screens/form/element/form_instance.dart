import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';
import 'package:datarunmobile/data/submission_list.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
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

    parent.elementControl.add(itemFormGroup);

    final itemInstance = FormElementBuilder.buildRepeatItem(
      form,
      formFlatTemplate,
      parent.template, /*parentUid: _formDataUid as String*/
    );
    parent
      ..add(itemInstance)
      ..resolveDependencies()
      ..evaluate();
    itemInstance.resolveDependencies();
    itemInstance.evaluate();
    parent.elementControl.markAsDirty();
    return itemInstance;
  }

  RepeatItemInstance onRemoveRepeatedItem(int index, RepeatSection parent) {
    final removedItem = parent.removeAt(index);
    parent.elementControl.removeAt(index);
    parent.evaluate();
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
