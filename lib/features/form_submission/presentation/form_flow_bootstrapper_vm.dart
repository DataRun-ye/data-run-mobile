import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/exception/d_exception.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_iterator/form_element_iterator.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/form_metadata_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FormFlowBootstrapperVm extends BaseViewModel {
  FormFlowBootstrapperVm({
    this.formId,
    this.versionId,
    this.assignmentId,
  });

  final String? formId;
  final String? versionId;
  final String? assignmentId;

  AppDatabase get _db => DSdk.db;

  final NavigationService _navigationService = appLocator<NavigationService>();

  Future<void> bootstrapFlow(String? submissionId) async {
    DataInstance? dataInstance;
    // pass either submission id or at least form id for new ones
    try {
      if (submissionId == null) {
        if (formId == null) {
          setError(DException('You need to pass form id for new submissions'));
          return;
        }

        // draft
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
        await appLocator.dropScope(dataInstance.id);
      }
      await appLocator.pushNewScopeAsync(
          scopeName: dataInstance.id,
          init: (getIt) async {
            final formFlatTemplate =
                getIt.registerSingleton<FormTemplateRepository>(
                    await FormTemplateRepository.create(
                        versionUid: dataInstance!.templateVersion));

            getIt.registerSingleton<FormInstance>(await _formInstance(getIt,
                instance: dataInstance, templateRepository: formFlatTemplate));
          });

      _navigationService.replaceWithFormSubmissionScreen(
        submissionId: dataInstance.id,
        formId: dataInstance.formTemplate,
        versionId: dataInstance.templateVersion,
        assignmentId: dataInstance.assignment,
        currentPageIndex: assignmentId != null ? 1 : 0,
      );
    } catch (e) {
      if (dataInstance?.id != null &&
          appLocator.currentScopeName == dataInstance!.id) {
        await appLocator.dropScope(dataInstance.id);
      }
      setError(e);
      rethrow;
    }
  }

  Future<FormInstance> _formInstance(GetIt getIt,
      {required DataInstance instance,
      required FormTemplateRepository templateRepository}) async {
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
    final form = FormGroup(FormElementControlBuilder.formDataControls(
        templateRepository, initialFormValue));
    controlWatch.stop();
    FieldContextRegistry registry = appLocator<FieldContextRegistry>();

    final elementsWatch = Stopwatch()..start();
    final elements = FormElementBuilder.buildFormElements(
        form, templateRepository,
        initialFormValue: initialFormValue);
    elementsWatch.stop();

    final evaluateWatch = Stopwatch()..start();
    final _formSection = Section(
        template: templateRepository.rootSection,
        elements: elements,
        form: form)
      ..resolveDependencies()
      ..evaluate(emitEvent: false /*, updateParent: false*/);
    evaluateWatch.stop();

    final attributeMap = await formMetadataService
        .formAttributesControls(initialFormValue ?? {});
    final bool editStatus =
        await submissionEditStatus(submissionId: instance.id);

    totalWatch.stop();
    if (kDebugMode) {
      final allElements =
          getFormElementIterator<FormElementInstance<dynamic>>(_formSection)
              .toList(growable: false);
      final repeatSections = allElements.whereType<RepeatSection>();
      final repeatRows = repeatSections.fold<int>(
          0, (total, repeat) => total + repeat.elements.length);

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
        fieldKeysRegistery: registry,
        form: form,
        rootSection: _formSection,
        formFlatTemplate: templateRepository);
  }

  Future<bool> submissionEditStatus({required String submissionId}) async {
    final db = DSdk.db;

    final submission = await db.managers.dataInstances
        .filter((f) => f.id(submissionId))
        .getSingleOrNull();

    if (submission == null) return false;

    final isSynced = submission.syncState.isSynced == true;

    final assignmentForm = await db.managers.assignmentForms
        .filter((f) =>
            f.assignment.id(submission.assignment) &
            f.form.id(submission.formTemplate))
        .getSingleOrNull();
    if (assignmentForm == null) return false;
    final editable = assignmentForm.canEditSubmissions == true || !isSynced;
    return editable;
  }
}
