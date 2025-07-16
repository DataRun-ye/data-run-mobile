import 'dart:async';
import 'dart:io';

import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/device_info_service.dart';
import 'package:datarunmobile/features/form_submission/application/instance_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
Future<FormTemplateRepository> latestFormTemplate(Ref ref,
    {required String formId}) async {
  final formTemplates = await DSdk.db.managers.formTemplates
      .filter((f) => f.id(formId))
      .getSingle();
  // final formTemplateVersions = await DSdk.db.managers.formTemplateVersions
  //     .filter((f) => f.template.id(formId))
  //     .orderBy((o) => o.versionNumber.desc())
  //     .get();

  // await D2Remote.formModule.formTemplateV
  //     .where(attribute: 'formTemplate', value: formId)
  //     .orderBy(attribute: 'version', order: SortOrder.DESC)
  //     .get();
  return FormTemplateRepository.create(versionUid: formTemplates.versionUid);
}

// /// form id could be on the format of formId-version or formId
// /// look for the latest version of the form template or the form template
// /// that matches the version
// @riverpod
// Future<FormTemplateVersion> submissionVersionFormTemplate(Ref ref,
//     {required String formId}) async {
//   return getTemplateByVersionOrLatest(formId);
// }

@riverpod
Future<FormTemplateRepository> formFlatTemplate(
  Ref ref, {
  required FormMetadata formMetadata,
}) async {
  if (formMetadata.submission != null) {
    final DataInstance submission = await DSdk.db.managers.dataInstances
        .filter((s) => s.id(formMetadata.submission))
        .getSingle();

    final flatTemplate = await FormTemplateRepository.create(
        versionUid: submission.templateVersion);
    return flatTemplate;
  }

  return await FormTemplateRepository.create(
      versionUid: formMetadata.versionUid);
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
  final DataInstance submission = await DSdk.db.managers.dataInstances
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
      template: formFlatTemplate.rootSection, elements: elements, form: form)
    ..resolveDependencies()
    ..evaluate();
  final attributeMap =
      await formInstanceService.formAttributesControls(initialFormValue);

  return FormInstance(ref,
      entryStarted: submission.startEntryTime.toLocal(),
      enabled: submission.syncState != InstanceSyncStatus.synced,
      initialValue: {...?initialFormValue, ...attributeMap},
      elements: elements,
      formMetadata: formMetadata,
      // assignmentStatus: submission.status,
      form: form,
      rootSection: _formSection,
      formFlatTemplate: formFlatTemplate);
}
