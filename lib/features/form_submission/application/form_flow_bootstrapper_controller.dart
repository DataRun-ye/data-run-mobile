import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/form_metadata_service.dart';
import 'package:datarunmobile/features/form_submission/application/form_scope.dart';
import 'package:datarunmobile/features/form_submission/application/submission_edit_access.dart';
import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

class FormFlowBootstrapperController {
  FormFlowBootstrapperController({
    this.formId,
    this.versionId,
    this.assignmentId,
  });

  final String? formId;
  final String? versionId;
  final String? assignmentId;

  AppDatabase get _db => appLocator<AppDatabase>();

  NavigationService get _navigationService => appLocator<NavigationService>();

  Future<void> bootstrapFlow(String? submissionId) async {
    DataInstance? dataInstance;
    try {
      if (submissionId == null) {
        if (formId == null) {
          throw const DException(
            'You need to pass form id for new submissions',
          );
        }

        dataInstance = await _db.dataInstancesDao.createDraft(
          templateId: formId!,
          templateVersionId: versionId,
          assignmentId: assignmentId,
        );
      } else {
        dataInstance = await _db.dataInstancesDao.getById(submissionId);
        if (dataInstance == null) {
          throw StateError('Submission not found: $submissionId');
        }
      }

      if (appLocator.currentScopeName == dataInstance.id) {
        await closeFormScope(dataInstance.id);
      }
      await appLocator.pushNewScopeAsync(
        scopeName: dataInstance.id,
        init: (getIt) async {
          final fieldContextRegistry =
              getIt.registerSingleton<FieldContextRegistry>(
            FieldContextRegistry(),
            dispose: (registry) => registry.dispose(),
          );
          final templateRepository =
              getIt.registerSingleton<FormTemplateRepository>(
            await FormTemplateRepository.create(
              versionUid: dataInstance!.templateVersion,
            ),
          );

          getIt.registerSingleton<FormInstance>(
            await _buildFormInstance(
              instance: dataInstance,
              templateRepository: templateRepository,
              fieldContextRegistry: fieldContextRegistry,
            ),
            dispose: (instance) => instance.dispose(),
          );
        },
      );

      _navigationService.replaceWithFormSubmissionScreen(
        submissionId: dataInstance.id,
        formId: dataInstance.formTemplate,
        versionId: dataInstance.templateVersion,
        assignmentId: dataInstance.assignment,
        currentPageIndex: assignmentId != null ? 1 : 0,
      );
    } catch (_) {
      if (dataInstance?.id != null &&
          appLocator.currentScopeName == dataInstance!.id) {
        await closeFormScope(dataInstance.id);
      }
      rethrow;
    }
  }

  Future<FormInstance> _buildFormInstance({
    required DataInstance instance,
    required FormTemplateRepository templateRepository,
    required FieldContextRegistry fieldContextRegistry,
  }) async {
    final totalWatch = Stopwatch()..start();
    final Map<String, dynamic>? initialFormValue = instance.formData;

    final formMetadata = FormMetadata(
      formId: instance.formTemplate,
      versionUid: instance.templateVersion,
      submission: instance.id,
      assignmentId: instance.assignment,
    );
    final formMetadataService =
        appLocator<FormMetadataService>(param1: formMetadata);

    final controlWatch = Stopwatch()..start();
    final form = FormGroup(
      FormElementControlBuilder.formDataControls(
        templateRepository,
        initialFormValue,
      ),
    );
    controlWatch.stop();
    final elementsWatch = Stopwatch()..start();
    final elements = FormElementBuilder.buildFormElements(
      form,
      templateRepository,
      initialFormValue: initialFormValue,
    );
    elementsWatch.stop();

    final evaluateWatch = Stopwatch()..start();
    final formSection = Section(
      template: templateRepository.rootSection,
      elements: elements,
      form: form,
    )
      ..resolveDependencies()
      ..evaluate(emitEvent: false);
    evaluateWatch.stop();

    final attributeMap = await formMetadataService.formAttributesControls(
      initialFormValue ?? {},
    );
    final editStatus = await canEditSubmission(
      _db,
      submissionId: instance.id,
    );

    totalWatch.stop();
    if (kDebugMode) {
      final allElements =
          getFormElementIterator<FormElementInstance<dynamic>>(formSection)
              .toList(growable: false);
      final repeatSections = allElements.whereType<RepeatSection>();
      final repeatRows = repeatSections.fold<int>(
        0,
        (total, repeat) => total + repeat.elements.length,
      );

      logInfo('form bootstrap metrics', data: {
        'submissionId': instance.id,
        'templateId': instance.formTemplate,
        'totalMs': totalWatch.elapsedMilliseconds,
        'controlBuildMs': controlWatch.elapsedMilliseconds,
        'elementBuildMs': elementsWatch.elapsedMilliseconds,
        'dependencyEvaluateMs': evaluateWatch.elapsedMilliseconds,
        'elementCount': allElements.length,
        'fieldCount': allElements.whereType<FieldInstance<dynamic>>().length,
        'repeatSectionCount': allElements.whereType<RepeatSection>().length,
        'repeatRowCount': repeatRows,
      });
    }

    return FormInstance(
      submissionId: instance.id,
      entryStarted: instance.startEntryTime.toLocal(),
      enabled: editStatus,
      initialValue: {...?initialFormValue, ...attributeMap},
      elements: elements,
      formMetadata: formMetadata,
      fieldKeysRegistery: fieldContextRegistry,
      form: form,
      rootSection: formSection,
      formFlatTemplate: templateRepository,
    );
  }
}
