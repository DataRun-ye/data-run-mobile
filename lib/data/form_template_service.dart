import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/data/option_set_service.dart';
import 'package:datarunmobile/features/form/application/form_list_filter.dart';
import 'package:datarunmobile/features/form/application/form_template_model.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormTemplateService {
  FormTemplateService({required this.optionSetService});

  final OptionSetService optionSetService;

  Future<List<Pair<AssignmentForm, bool>>> userAvailableForms(
      String assignment) async {
    List<AssignmentForm> assignmentForms =
        await fetchAssignmentForms(assignment);
    final List<String> userForms = assignmentForms.map((a) => a.form).toList();

    final List<FormTemplate> availableFormTemplates = await DSdk
        .db.managers.formTemplates
        .filter((f) => f.id.isIn(userForms))
        .get();

    final List<String> availableForms =
        availableFormTemplates.map((f) => f.id).toList();

    final availableAssignedForms = assignmentForms
        .map((fp) => Pair(fp, availableForms.contains(fp.form)))
        .toList();

    return availableAssignedForms;
  }

  Future<List<AssignmentForm>> fetchAssignmentForms(String assignmentId) async {
    final db = appLocator<DbManager>().db;
    final userForms = appLocator<User>().userFormsUIDs;

    return db.managers.assignmentForms
        .filter((f) => f.assignment.id(assignmentId))
        .get();
  }

  Future<List<FormTemplate>> fetchByAssignment(assignmentId) async {
    final db = appLocator<DbManager>().db;
    final userForms = appLocator<User>().userFormsUIDs;

    final query = db.managers.assignmentForms
        .filter((f) => f.assignment.id(assignmentId));

    // access
    final assignmentFormsWithRefs = await query
        .filter((f) => f.form.id.isIn(userForms) & f.canAddSubmissions(true))
        .withReferences((prefetch) => prefetch(form: true))
        .get();

    final List<FormTemplate> assignmentFormTemplates =
        assignmentFormsWithRefs.map((assignmentWithRef) {
      final (assignmentForm, ref) = assignmentWithRef;
      return ref.form.prefetchedData!.first;
    }).toList();

    return assignmentFormTemplates;
  }

  Future<List<FormTemplateModel>> fetchByFilter(FormListFilter filter) async {
    final db = appLocator<DbManager>().db;
    final query = db.formTemplateVersionsDao
        .selectFormTemplatesWithRefs(assignmentId: filter.assignment);

    final List<(FormTemplate, FormTemplateVersion)> formTemplateWithRefs =
        await query.get();
    // final (templateVersion, refs) = formTemplateWithRefs;

    return formTemplateWithRefs.map((withRef) {
      final (t, v) = withRef;

      return FormTemplateModel(
        id: t.id,
        name: t.name,
        versionUid: v.id,
        label: t.label,
        description: t.description,
        versionNumber: v.versionNumber,
        fields: v.fields.build(),
        sections: v.sections.build(),
      );
    }).toList();
  }

  Future<FormTemplateModel> getTemplateByVersionOrLatest(
      {String? templateId, String? versionId}) async {
    assert(templateId != null || versionId != null);

    /// try to get form versions by the specific form version Ids
    /// It would retrieve the specific versions of formTemplate
    try {
      var query = DSdk.db.managers.formTemplateVersions
          // .filter((f) => f.template.formAssignments((fs) => fs.assignment.id("")))
          .withReferences((prefetch) => prefetch(template: true));

      if (versionId != null) {
        query = query.filter((f) => f.id(versionId));
      } else {
        query =  query.filter((f) => f.template.id(templateId))
          ..orderBy((o) => o.versionNumber.desc()).limit(1);
      }

      final List<(FormTemplateVersion, $$FormTemplateVersionsTableReferences)>
          formTemplateWithRefs = await query.get();
      final (templateVersion, refs) = formTemplateWithRefs.first;

      final formTemplate = refs.template.prefetchedData!.first;

      return FormTemplateModel(
        id: formTemplate.id,
        name: formTemplate.name,
        versionUid: templateVersion.id,
        label: formTemplate.label,
        description: formTemplate.description,
        versionNumber: templateVersion.versionNumber,
        fields: templateVersion.fields.build(),
        sections: templateVersion.sections.build(),
      );
    } catch (e) {
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
  }
}
