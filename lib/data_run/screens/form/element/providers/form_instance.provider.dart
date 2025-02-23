import 'dart:async';
import 'dart:io';

import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:d2_remote/shared/utilities/sort_order.util.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:datarun/data_run/form/form_element_factories/form_element_builder.dart';
import 'package:datarun/data_run/form/form_element_factories/form_element_control_builder.dart';
import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
import 'package:datarun/data_run/screens/form/element/service/device_info_service.dart';
import 'package:datarun/data_run/screens/form/element/form_instance.dart';
import 'package:datarun/data_run/screens/form/element/service/form_instance_service.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_instance.provider.g.dart';

@riverpod
Future<AndroidDeviceInfoService> userDeviceInfoService(
    UserDeviceInfoServiceRef ref) async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo =
      Platform.isAndroid ? await deviceInfoPlugin.androidInfo : null;
  final deviceService = AndroidDeviceInfoService(deviceInfo: deviceInfo);
  return deviceService;
}

@riverpod
Future<FormVersion> latestFormTemplate(LatestFormTemplateRef ref,
    {required String formId}) async {
  final formTemplates = await D2Remote.formModule.formTemplateV
      .where(attribute: 'formTemplate', value: formId)
      .orderBy(attribute: 'version', order: SortOrder.DESC)
      .get();
  return formTemplates.first;
}

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
@riverpod
Future<FormVersion> submissionVersionFormTemplate(
    SubmissionVersionFormTemplateRef ref,
    {required String formId}) async {
  /// try to get form versions by the specific form version Ids
  /// It would retrieve the specific versions of formTemplate
  final formTemplate = await D2Remote.formModule.formTemplateV
      .byId(formId)
      .orderBy(attribute: 'version', order: SortOrder.DESC)
      .getOne();

  if (formTemplate != null) {
    return formTemplate;
  } else {
    /// try to get form versions by form template Ids
    /// if more than one value for the same formTemplate, take latest version
    final FormVersion? formTemplate = await D2Remote.formModule.formTemplateV
        .where(attribute: 'formTemplate', value: formId)
        .orderBy(attribute: 'version', order: SortOrder.DESC)
        .getOne();

    return formTemplate!;
  }
}

@riverpod
Future<FormFlatTemplate> formFlatTemplate(
  FormFlatTemplateRef ref, {
  required FormMetadata formMetadata,
}) async {
  if (formMetadata.submission != null) {
    final DataFormSubmission submission = await D2Remote
        .formSubmissionModule.formSubmission
        .byId(formMetadata.submission!)
        .getOne();
    final FormVersion formVersion = await ref.watch(
        submissionVersionFormTemplateProvider(formId: submission.formVersion)
            .future);
    return FormFlatTemplate.fromTemplate(formVersion);
  }

  final FormVersion formVersion = await ref.watch(
      submissionVersionFormTemplateProvider(formId: formMetadata.formId)
          .future);
  return FormFlatTemplate.fromTemplate(formVersion);
}

@riverpod
Future<FormInstanceService> formInstanceService(FormInstanceServiceRef ref,
    {required FormMetadata formMetadata}) async {
  final userDeviceService =
      await ref.watch(userDeviceInfoServiceProvider.future);

  return FormInstanceService(
      formMetadata: formMetadata, deviceInfoService: userDeviceService);
}

@riverpod
Future<FormInstance> formInstance(FormInstanceRef ref,
    {required FormMetadata formMetadata}) async {
  final enabled = await D2Remote.formSubmissionModule.formSubmission
      .byId(formMetadata.submission!)
      .canEdit();

  final submission = await D2Remote.formSubmissionModule.formSubmission
      .byId(formMetadata.submission!)
      .getOne();

  final Map<String, dynamic>? initialFormValue = submission.formData;

  final formInstanceService = await ref
      .watch(formInstanceServiceProvider(formMetadata: formMetadata).future);

  final formFlatTemplate = await ref
      .watch(formFlatTemplateProvider(formMetadata: formMetadata).future);

  final form = FormGroup(FormElementControlBuilder.formDataControls(
      formFlatTemplate, initialFormValue));

  final elements = FormElementBuilder.buildFormElements(form, formFlatTemplate,
      initialFormValue: initialFormValue);

  final _formSection = Section(
      template: SectionTemplate(type: ValueType.Unknown, path: null),
      elements: elements,
      form: form)
    ..resolveDependencies()
    ..evaluate();
  final attributeMap =
      await formInstanceService.formAttributesControls(initialFormValue);

  return FormInstance(ref,
      enabled: enabled,
      initialValue: {...?initialFormValue, ...attributeMap},
      elements: elements,
      formMetadata: formMetadata,
      assignmentStatus: submission.status,
      form: form,
      rootSection: _formSection,
      formFlatTemplate: formFlatTemplate);
}
