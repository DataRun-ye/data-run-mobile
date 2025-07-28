import 'dart:async';

import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/form_metadata_service.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_instance.provider.g.dart';

@riverpod
Future<FormTemplateRepository> latestFormTemplate(Ref ref,
    {required String formId}) async {
  final formTemplates = await DSdk.db.managers.formTemplates
      .filter((f) => f.id(formId))
      .getSingle();
  return FormTemplateRepository.create(versionUid: formTemplates.versionUid);
}

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
Future<FormInstance> formInstance(Ref ref,
    {required FormMetadata formMetadata}) async {
  final DataInstance submission = await DSdk.db.managers.dataInstances
      .filter((s) => s.id(formMetadata.submission))
      .getSingle();

  final Map<String, dynamic>? initialFormValue = submission.formData;

  final formMetadataService =
      appLocator<FormMetadataService>(param1: formMetadata);

  final formFlatTemplate = await ref
      .watch(formFlatTemplateProvider(formMetadata: formMetadata).future);

  final form = FormGroup(FormElementControlBuilder.formDataControls(
      formFlatTemplate, initialFormValue));
  FieldContextRegistry registry = appLocator<FieldContextRegistry>();

  final elements = FormElementBuilder.buildFormElements(form, formFlatTemplate,
      initialFormValue: initialFormValue);

  final _formSection = Section(
      template: formFlatTemplate.rootSection, elements: elements, form: form)
    ..resolveDependencies()
    // ..updateValueAndValidity(emitEvent: false);
    ..evaluate(emitEvent: false/*, updateParent: false*/);
  final attributeMap =
      await formMetadataService.formAttributesControls(initialFormValue);
  final bool submissionEditStatus = await ref
      .watch(submissionEditStatusProvider(formMetadata: formMetadata).future);

  return FormInstance(ref,
      entryStarted: submission.startEntryTime.toLocal(),
      enabled: submissionEditStatus,
      initialValue: {...?initialFormValue, ...attributeMap},
      elements: elements,
      formMetadata: formMetadata,
      fieldKeysRegistery: registry,
      form: form,
      rootSection: _formSection,
      formFlatTemplate: formFlatTemplate);
}
