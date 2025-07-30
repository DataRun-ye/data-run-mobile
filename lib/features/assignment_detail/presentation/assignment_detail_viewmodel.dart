// import 'package:d_sdk/database/shared/assignment_model.dart';
// import 'package:datarunmobile/app/di/injection.dart';
// import 'package:datarunmobile/features/assignment/application/assignment_service.dart';
// import 'package:datarunmobile/features/form/application/form_list_item_model.dart';
// import 'package:datarunmobile/features/form/application/form_template_service.dart';
// import 'package:stacked/stacked.dart';
//
// class AssignmentDetailViewModel extends ReactiveViewModel {
//   AssignmentDetailViewModel(this.id);
//
//   final AssignmentService _assignmentService = appLocator<AssignmentService>();
//   final FormTemplateService _formTemplateService =
//       appLocator<FormTemplateService>();
//   final String id;
//   AssignmentModel? assignment;
//   List<FormListItemModel> linkedForms = [];
//
//   Future<void> run() async {
//     await runBusyFuture(load());
//   }
//
//   Future<void> load() async {
//     try {
//       assignment = await _assignmentService.fetchById(id);
//       linkedForms = await _formTemplateService.fetchByAssignment(id);
//     } catch (e) {
//       setError(e);
//       notifyListeners();
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   void navigateToFormSubmissionList(String formTemplateId) {
//     // _navigationService.navigateTo(
//     //   Routes.assignmentDetailPage,
//     //   arguments: AssignmentDetailPageArguments(assignment: assignment),
//     // );
//   }
// //
// // Future<String> showBasicBottomSheet() async {
// //   final assignment = await _assignmentService.fetchById(id);
// //   final assignedForms = await _formService.getLinkedToAssignment(assignment!);
// //
// //   final selectedFormVersionId = await _bottomSheetService.showCustomSheet<
// //           FormVersionModel, AssignmentModelNew>(
// //       variant: BottomSheetType.createSubmission,
// //       title: '(${S.current.form(assignedForms.length)})',
// //       description:
// //           'Use this bottom sheet function to show something to the user. It\'s better than the standard alert dialog in terms of UI quality.',
// //       data: assignment);
// //   final submission = await _submissionService.createEntity(
// //       formVersion: selectedFormVersionId,
// //       assignmentId: id,
// //       team: assignment.team.id,
// //       form: selectedFormVersionId!.data!.form,
// //       version: selectedFormVersionId.data!.version);
// //
// //   final createdSubmission = await _submissionService.save(submission);
// //   // TODO navigate to submission view
// //   // _navigationSheetService.rep
// //   return submission.id;
// // }
// }
