import 'dart:async';
import 'dart:io';

import 'package:datarunmobile/data_run/screens/form/element/form_instance.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form/element/service/device_info_service.dart';
import 'package:datarunmobile/data_run/screens/form/element/service/form_instance_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  throw UnimplementedError();
  // final DataSubmission submission = await DSdk.db.managers.dataSubmissions
  //     .filter((s) => s.id(formMetadata.submission))
  //     .getSingle();
  //
  // final Map<String, dynamic>? initialFormValue = submission.formData;
  //
  // final formInstanceService = await ref
  //     .watch(formInstanceServiceProvider(formMetadata: formMetadata).future);
  //
  // final formFlatTemplate = await ref
  //     .watch(formFlatTemplateProvider(formMetadata: formMetadata).future);
  //
  // final form = FormGroup(FormElementControlBuilder.formDataControls(
  //     formFlatTemplate, initialFormValue));
  //
  // final elements = FormElementBuilder.buildFormElements(form, formFlatTemplate,
  //     initialFormValue: initialFormValue);
  //
  // final _formSection = Section(
  //     template: formFlatTemplate.rootElementTemplate,
  //     elements: elements,
  //     form: form)
  //   ..resolveDependencies()
  //   ..evaluate();
  // final attributeMap =
  //     await formInstanceService.formAttributesControls(initialFormValue);
  //
  // return FormInstance(ref,
  //     enabled: submission.status != InstanceSyncStatus.synced,
  //     initialValue: {...?initialFormValue, ...attributeMap},
  //     elements: elements,
  //     formMetadata: formMetadata,
  //     assignmentStatus: submission.progressStatus,
  //     form: form,
  //     rootSection: _formSection,
  //     formFlatTemplate: formFlatTemplate);
}
