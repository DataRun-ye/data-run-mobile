import 'package:d_sdk/core/exception/d_exception.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/form_metadata_service.dart';
import 'package:drift/drift.dart';
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

  final _db = DSdk.db;

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
        dataInstance =
            await _db.dataInstances.findById(submissionId).getSingle();
      }

      if (appLocator.currentScopeName?.startsWith('template_') == true) {
        await appLocator.popScope();
      }
      await appLocator.pushNewScopeAsync(
          scopeName: 'template_${dataInstance.id}',
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
      final scopeName = formId ?? dataInstance?.formTemplate;
      if (scopeName != null) {
        await appLocator.popScopesTill(scopeName);
      }
      setError(e);
      rethrow;
    }
  }

  Future<FormInstance> _formInstance(GetIt getIt,
      {required DataInstance instance,
      required FormTemplateRepository templateRepository}) async {
    final Map<String, dynamic>? initialFormValue = instance.formData;

    final formMetadata = FormMetadata(
      formId: instance.formTemplate,
      versionUid: instance.templateVersion,
      submission: instance.id,
      assignmentId: instance.assignment,
    );
    final formMetadataService =
        appLocator<FormMetadataService>(param1: formMetadata);

    final form = FormGroup(FormElementControlBuilder.formDataControls(
        templateRepository, initialFormValue));
    FieldContextRegistry registry = appLocator<FieldContextRegistry>();

    final elements = FormElementBuilder.buildFormElements(
        form, templateRepository,
        initialFormValue: initialFormValue);

    final _formSection = Section(
        template: templateRepository.rootSection,
        elements: elements,
        form: form)
      ..resolveDependencies()
      ..evaluate(emitEvent: false /*, updateParent: false*/);
    final attributeMap = await formMetadataService
        .formAttributesControls(initialFormValue ?? {});
    final bool editStatus =
        await submissionEditStatus(submissionId: instance.id);

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
