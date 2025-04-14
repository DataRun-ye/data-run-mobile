import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/data/form/form_instance.provider.dart';
import 'package:datarunmobile/data/form_submission/submission_list.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:drift/drift.dart';
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
  FormInstance(FormInstanceRef ref,
      {required this.form,
      required this.formFlatTemplate,
      required this.formMetadata,
      AssignmentStatus? assignmentStatus,
      Map<String, Object?> initialValue = const {},
      required Section rootSection,
      Map<String, FormElementInstance<dynamic>> elements = const {},
      required this.enabled})
      : _ref = ref,
        _formSection = rootSection,
        _assignmentStatus = assignmentStatus {
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

  final FormGroup form;
  final FormFlatTemplate formFlatTemplate;
  final bool enabled;

  final FormInstanceRef _ref;
  final Map<String, FormElementInstance<dynamic>> _forElementMap = {};
  final Section _formSection;
  AssignmentStatus? _assignmentStatus;

  Map<String, FormElementInstance<dynamic>> get forElementMap =>
      Map.unmodifiable(_forElementMap);

  Section get formSection => _formSection;

  FormSubmissions get formSubmissionList => _ref.read(
      formSubmissionsProvider(formMetadata.formId.split('_').first).notifier);

  final FormMetadata formMetadata;

  String? get submissionUid => formMetadata.submission;

  Future<void> saveFormData() async {
    final formSubmission =
        await formSubmissionList.getSubmission(submissionUid!);

    return _saveSubmission(formSubmission!);
  }

  Future<void> _saveSubmission(DataSubmission formSubmission) async {
    final formValue = formSection.value;
    formValue.forEach((key, value) {
      _initialValue.update(
        key,
        (_) => value,
        ifAbsent: () => value,
      );
    });

    formSubmission = formSubmission.copyWith(
        progressStatus: Value(_assignmentStatus),
        formData: Value(formSubmission.formData
          ?..removeWhere((k, v) => !metadata.contains(k))
          ..['_status'] = _assignmentStatus?.name
          ..addAll(formValue)));
    // formSubmission.status = _assignmentStatus;
    // formSubmission.formData
    //   ?..removeWhere((k, v) => !metadata.contains(k))
    //   ..['_status'] = _assignmentStatus?.name
    //   ..addAll(formValue);

    return formSubmissionList.updateSubmission(formSubmission);
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
      parent.template,
    );
    parent..add(itemInstance);
    // ..resolveDependencies()
    // ..evaluateDependencies();
    // itemInstance.resolveDependencies();
    // itemInstance.evaluateDependencies();
    parent.elementControl.markAsDirty();
    return itemInstance;
  }

  RepeatItemInstance onRemoveRepeatedItem(int index, RepeatSection parent) {
    final removedItem = parent.removeAt(index);
    parent.elementControl.removeAt(index);
    parent.evaluateDependencies();
    return removedItem;
  }

  RepeatItemInstance? onRemoveLastItem(RepeatSection parent) {
    try {
      final parentArray = form.control(parent.elementPath!) as FormArray;
      final lastParentItem = parent.elements.last;
      final itemFormGroup = form.control(lastParentItem.elementPath!);
      parent.remove(lastParentItem);
      parent.evaluateDependencies();
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
