import 'package:collection/collection.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/data/model/bottom_sheet_content_model.data.dart';
import 'package:datarunmobile/data/model/dialog_button_style.data.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_completion_dialog.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ConfigureFormCompletionDialog {
  const ConfigureFormCompletionDialog();

  FormCompletionDialog call(Section rootSection) {
    final FormCompletionButton mainButton = _getMainButton(rootSection);
    final FormCompletionButton secondaryButton =
    _getSecondaryButton(rootSection);

    final DialogContentModel bottomSheetDialogUiModel = DialogContentModel(
        title: rootSection.form.hasErrors
            ? S.current.formContainsSomeErrors
            : S.current.finalData,
        subtitle: rootSection.form.hasErrors
            ? S.current.fieldsWithErrorInfo
            : S.current.markAsFinalData,
        icon: rootSection.form.hasErrors ? Icons.error : Icons.check_circle,
        body: _getBody(rootSection));

    return FormCompletionDialog(
        bottomSheetContentModel: bottomSheetDialogUiModel,
        mainButton: mainButton,
        secondaryButton: secondaryButton);
  }

  FormCompletionButton _getMainButton(Section rootSection) {
    if (rootSection.form.hasErrors) {
      return FormCompletionButton(
          buttonStyle:
          DialogButtonStyle.mainButton(text: S.current.reviewFormData),
          action: FormBottomDialogActionType.CheckFields);
    } else {
      return FormCompletionButton(
          buttonStyle: DialogButtonStyle.finalizeButton(),
          action: FormBottomDialogActionType.MarkAsFinal);
    }
  }

  FormCompletionButton _getSecondaryButton(Section rootSection) {
    if (rootSection.form.hasErrors) {
      return FormCompletionButton(
          buttonStyle: DialogButtonStyle.secondaryButton(
              text: S.current.checkFieldsLater),
          action: FormBottomDialogActionType.NotNow);
    } else {
      return FormCompletionButton(
          buttonStyle:
          DialogButtonStyle.secondaryButton(text: S.current.notNow),
          action: FormBottomDialogActionType.NotNow);
    }
  }

  BottomSheetBodyModel _getBody(Section rootSection) {
    bool controlHasErrors = rootSection.form.hasErrors;
    // bool elementHasErrors = rootSection.elementState.errors.isNotEmpty;
    // final elementErrors =rootSection.elementState.errors;
    return controlHasErrors
        ? BottomSheetBodyModel.errorsBody(
        message: S.current.fieldsWithErrorInfo,
        fieldsWithIssues: _getFieldsWithIssues(rootSection))
        : BottomSheetBodyModel.messageBody(
        message: S.current.makeFormFinalOrSaveBody);
  }

  Map<String, dynamic> flattenErrorMap(Map<String, dynamic> errorMap,
      {String prefix = ''}) {
    Map<String, dynamic> flatMap = {};

    errorMap.forEach((key, value) {
      String newKey = prefix.isEmpty ? key : '$prefix.$key';

      if (value is Map<String, dynamic>) {
        // If the value is a map, recursively flatten it
        flatMap.addAll(flattenErrorMap(value, prefix: newKey));
      } else if (value is List) {
        // If the value is a list, iterate through each item and flatten
        for (int i = 0; i < value.length; i++) {
          flatMap.addAll(
              flattenErrorMap({i.toString(): value[i]}, prefix: '$newKey.$i'));
        }
      } else {
        // Otherwise, it's a leaf node (error value), add it to the flatMap
        flatMap[newKey] = value;
      }
    });

    return flatMap;
  }

  Map<String, List<FieldWithIssue>> _getFieldsWithIssues(Section rootSection) {
    // logDebug('formErrorsMap: $formErrors');
    // logDebug('formErrorsMapFlatt: $formErrorsFlatt');
    final Iterable<FieldInstance<dynamic>> fieldsWithErrors =
    getFormElementIterator<FieldInstance<dynamic>>(rootSection)
        .where((field) => field.elementControl.hasErrors && field.visible);
    final fieldsIssues = fieldsWithErrors.map((element) => FieldWithIssue(
        parent: element.parentSection?.label,
        fieldPath: element.elementPath,
        fieldUid: element.name!,
        fieldName: element.label,
        message: _getErrorMessage(element)));

    final fieldsErrors = fieldsIssues
        .groupListsBy((element) => element.parent ?? 'UnGroupedIssue');
    return fieldsErrors;
  }

  String _getErrorMessage(FieldInstance<dynamic> field) {
    final errorKey = field.elementControl.errors.keys.first;
    final validationMessage = _findValidationMessage(errorKey);

    return validationMessage != null
        ? validationMessage(field.elementControl.getError(errorKey)!)
        : errorKey;
  }

  ValidationMessageFunction? _findValidationMessage(String errorKey) {
    return validationMessages()[errorKey];
  }
}
