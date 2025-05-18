import 'dart:async';
import 'dart:io';

import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_instance.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form/element/service/device_info_service.dart';
import 'package:datarunmobile/data_run/screens/form/element/service/form_instance_service.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/util_methods.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_instance.provider.g.dart';

@riverpod
Future<AndroidDeviceInfoService> userDeviceInfoService(Ref ref) async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo =
      Platform.isAndroid ? await deviceInfoPlugin.androidInfo : null;
  final deviceService = AndroidDeviceInfoService(deviceInfo: deviceInfo);
  return deviceService;
}

@riverpod
Future<IMap<String, IList<FormOption>>> formTemplateOptions(Ref ref,
    {required String formId}) async {
  final formTemplate = await getTemplateByVersionOrLatest(formId);

  return getOptionSets(formTemplate);
}

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
@riverpod
Future<FormTemplateVersion> submissionVersionFormTemplate(Ref ref,
    {required String formId}) async {
  return getTemplateByVersionOrLatest(formId);
}

@riverpod
Future<FormFlatTemplate> formTemplateModel(
  Ref ref, {
  required String versionIdOrFormId,
}) async {
  final flatTemplate =
      await FormFlatTemplate.fromTemplate(templateId: versionIdOrFormId);
  return flatTemplate;
}

@riverpod
Future<FormFlatTemplate> formFlatTemplate(
  Ref ref, {
  required FormMetadata formMetadata,
}) async {
  if (formMetadata.submission != null) {
    final DataSubmission submission = await DSdk.db.managers.dataSubmissions
        .filter((s) => s.id(formMetadata.submission))
        .getSingle();
    final flatTemplate =
        await FormFlatTemplate.fromTemplate(templateId: submission.form);
    return flatTemplate;
  }

  return await appLocator.getAsync<FormFlatTemplate>(
      param1: formMetadata.formId);
}

@riverpod
Future<FormInstanceService> formInstanceService(Ref ref,
    {required FormMetadata formMetadata}) async {
  final userDeviceService =
      await ref.watch(userDeviceInfoServiceProvider.future);

  return FormInstanceService(
      formMetadata: formMetadata, deviceInfoService: userDeviceService);
}

@riverpod
Future<FormInstance> formInstance(Ref ref,
    {required FormMetadata formMetadata}) async {
  final DataSubmission submission = await DSdk.db.managers.dataSubmissions
      .filter((s) => s.id(formMetadata.submission))
      .getSingle();

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
      template: formFlatTemplate.rootElementTemplate,
      elements: elements,
      form: form)
    ..resolveDependencies()
    ..evaluate();
  final attributeMap =
      await formInstanceService.formAttributesControls(initialFormValue);

  return FormInstance(ref,
      enabled: submission.status != SubmissionStatus.synced,
      initialValue: {...?initialFormValue, ...attributeMap},
      elements: elements,
      formMetadata: formMetadata,
      assignmentStatus: submission.progressStatus,
      form: form,
      rootSection: _formSection,
      formFlatTemplate: formFlatTemplate);
}
