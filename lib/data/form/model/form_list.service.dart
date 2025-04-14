// import 'dart:async';
//
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d2_remote/shared/utilities/sort_order.util.dart';
// import 'package:datarunmobile/commons/d_run_base_service.dart';
// import 'package:datarunmobile/commons/identifiable.repository.dart';
// import 'package:datarunmobile/commons/query/order_by.dart';
// import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
// import 'package:datarunmobile/data/form/form.dart';
// import 'package:datarunmobile/data/form/model/form_version_model.dart';
// import 'package:datarunmobile/data/team/repository/d_team_local.repository.dart';
// import 'package:injectable/injectable.dart';
//
// // @lazySingleton
// class FormListService extends DRunBaseService<FormVersion, FormVersionModel> {
//   FormListService(
//     super.repository,
//     this._teamRepository,
//   );
//
//   final DRunBaseRepository<Team> _teamRepository;
//
//   Future<List<FormVersionModel>> getLinkedToAssignment(
//       AssignmentModelNew assignment) async {
//     final teamAssignedForms = await (_teamRepository as DTeamLocalRepository)
//         .getTeamAssignedForms(assignment.team.id);
//
//     final assignmentAssignedForms =
//         assignment.forms.where((t) => teamAssignedForms.contains(t));
//
//     List<FormVersionModel> models = [];
//
//     for (final form in assignmentAssignedForms) {
//       final formVersion = await getLatestVersion(form);
//       models.add(formVersion);
//     }
//
//     return models;
//   }
//
//   Future<FormVersionModel> getLatestVersion(String formId) async {
//     final formTemplates = await repository.get(
//         query: FormVersionQueryModel(
//             formTemplate: formId,
//             orderBy: OrderBy(attribute: 'version', sortOrder: SortOrder.DESC)));
//     return createModel(formTemplates.first);
//   }
//
//   @override
//   FutureOr<FormVersionModel> createModel(FormVersion identifiable) {
//     return FormVersionModel.fromIdentifiable(identifiableEntity: identifiable);
//   }
// }
