import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/core/util/string_extension.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/data/option_set_service.dart';
import 'package:datarunmobile/features/form/application/form_list_filter.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormTemplateListService {
  FormTemplateListService({required this.optionSetService});

  final OptionSetService optionSetService;

  Future<List<Pair<AssignmentForm, bool>>> userAvailableForms(
      {String? assignment}) async {
    List<AssignmentForm> assignmentForms = [];
    if (assignment.isNotNullOrEmpty) {
      assignmentForms.addAll(await DSdk.db.managers.assignmentForms
          .filter((f) => f.assignment.id(assignment))
          .get());
    } else {
      assignmentForms.addAll(await DSdk.db.managers.assignmentForms.get());
    }

    final userForm = assignmentForms.map((a) => a.form);
    final List<FormTemplate> availableFormTemplates = await DSdk
        .db.managers.formTemplates
        .filter((f) => f.id.isIn(userForm))
        .get();

    final List<String> availableForms =
        availableFormTemplates.map((f) => f.id).toList();

    final availableAssignedForms = assignmentForms
        .map((fp) => Pair(fp, availableForms.contains(fp.form)))
        .toList();

    return availableAssignedForms;
  }

  // Future<List<Pair<AssignmentForm, bool>>> userAvailableForms(
  //     {String? assignment}) async {
  //   List<AssignmentForm> assignmentForms = [];
  //   var query = DSdk.db.managers.assignmentForms;
  //
  //   if (assignment.isNotNullOrEmpty) {
  //     query = query
  //       ..filter((f) =>
  //       f.assignment.id(assignment) & f.assignment.disabled.not(true));
  //   }
  //
  //   assignmentForms.addAll(await query.get());
  //
  //   final userForm = assignmentForms.map((a) => a.form);
  //   final List<FormTemplate> availableFormTemplates = await DSdk
  //       .db.managers.formTemplates
  //       .filter((f) => f.id.isIn(userForm))
  //       .get();
  //
  //   final List<String> availableForms =
  //   availableFormTemplates.map((f) => f.id).toList();
  //
  //   final availableAssignedForms = assignmentForms
  //       .map((fp) => Pair(fp, availableForms.contains(fp.form)))
  //       .toList();
  //
  //   return availableAssignedForms;
  // }

  // Future<List<Pair<AssignmentForm, bool>>> userAvailableForms(
  //     String assignment) async {
  //   List<AssignmentForm> assignmentForms =
  //       await _fetchAssignmentForms(assignment);
  //   final List<String> userForms = assignmentForms.map((a) => a.form).toList();
  //
  //   final List<FormTemplate> availableFormTemplates = await DSdk
  //       .db.managers.formTemplates
  //       .filter((f) => f.id.isIn(userForms))
  //       .get();
  //
  //   final List<String> availableForms =
  //       availableFormTemplates.map((f) => f.id).toList();
  //
  //   final availableAssignedForms = assignmentForms
  //       .map((fp) => Pair(fp, availableForms.contains(fp.form)))
  //       .toList();
  //
  //   return availableAssignedForms;
  // }

  Future<List<AssignmentForm>> _fetchAssignmentForms(
      String assignmentId) async {
    final db = appLocator<DbManager>().db;
    final userForms =
        appLocator<AuthManager>().activeUserSession?.userFormsUIDs ?? [];

    return db.managers.assignmentForms
        .filter((f) => f.assignment.id(assignmentId))
        .get();
  }

  Future<List<FormTemplate>> fetchByAssignment(assignmentId) async {
    final db = appLocator<DbManager>().db;
    final userForms =
        appLocator<AuthManager>().activeUserSession?.userFormsUIDs ?? [];

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

    final formTemplates = await query.get();

    return formTemplates;
  }

  Future<FormTemplateModel> getTemplateByVersionOrLatest(
      {String? templateId, String? versionId}) async {
    assert(templateId != null || versionId != null);

    /// try to get form versions by the specific form version Ids
    /// It would retrieve the specific versions of formTemplate
    try {
      var query = DSdk.db.managers.formTemplateVersions
          .withReferences((prefetch) => prefetch(template: true));

      if (versionId != null) {
        query = query.filter((f) => f.id(versionId));
      } else {
        query = query.filter((f) => f.template.id(templateId));
      }

      final List<(FormTemplateVersion, $$FormTemplateVersionsTableReferences)>
          formTemplateWithRefs =
          await query.orderBy((o) => o.versionNumber.desc()).limit(1).get();
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
