// import 'package:datarunmobile/app/app.bottomsheets.dart';
// import 'package:datarunmobile/app/app.locator.dart';
// import 'package:datarunmobile/data/assignment/assignment.dart';
// import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
// import 'package:datarunmobile/data/form/form.dart';
// import 'package:datarunmobile/data/form_submission/form_submission.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// class CreateSubmissionSheetModel extends BaseViewModel {
//   final _bottomSheetService = appLocator<BottomSheetService>();
//   final _navigationSheetService = appLocator<NavigationService>();
//   final _assignmentService = appLocator<AssignmentListService>();
//   final _formService = appLocator<FormListService>();
//   final _submissionService = appLocator<FormSubmissionListService>();
//
//   List<FormVersionModel> assignedForms = [];
//   AssignmentModelNew? assignment;
//
//   Future<void> showBasicBottomSheet(String assignmentId) async {
//     assignment = await _assignmentService.getById(assignmentId);
//     assignedForms.addAll(await _formService.getLinkedToAssignment(assignment!));
//
//     final selectedFormVersionId = await _bottomSheetService.showCustomSheet<
//             FormVersionModel, AssignmentModelNew>(
//         variant: BottomSheetType.createSubmission,
//         title: '(${S.current.form(assignedForms.length)})',
//         description:
//             'Use this bottom sheet function to show something to the user. It\'s better than the standard alert dialog in terms of UI quality.',
//         data: assignment);
//     setBusy(true);
//     notifyListeners();
//     final submission = await _submissionService.createEntity(
//         formVersion: selectedFormVersionId,
//         assignmentId: assignmentId,
//         team: assignment!.team.id,
//         form: selectedFormVersionId!.data!.form,
//         version: selectedFormVersionId.data!.version);
//
//     await _submissionService.save(submission);
//     // TODO navigate to submission view
//     // _navigationSheetService.rep
//   }
//
// // FormVersionModel getLatest() {}
// }
