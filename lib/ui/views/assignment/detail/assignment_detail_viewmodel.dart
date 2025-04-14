// import 'package:datarunmobile/app/app.bottomsheets.dart';
// import 'package:datarunmobile/app/app.locator.dart';
// import 'package:datarunmobile/data/assignment/assignment.dart';
// import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
// import 'package:datarunmobile/data/form/form.dart';
// import 'package:datarunmobile/data/form_submission/model/form_submission_list.service.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// class AssignmentDetailViewModel extends ReactiveViewModel {
//   AssignmentDetailViewModel(this.id);
//
//   final AssignmentListService _assignmentService =
//       appLocator<AssignmentListService>();
//   final FormListService _formService = appLocator<FormListService>();
//
//   final _bottomSheetService = appLocator<BottomSheetService>();
//   final _navigationSheetService = appLocator<NavigationService>();
//   final _submissionService = appLocator<FormSubmissionListService>();
//
//   final String id;
//   AssignmentModelNew? assignment;
//   List<FormVersionModel> linkedForms = [];
//
//   Future<void> load() async {
//     try {
//       setBusy(true);
//       notifyListeners();
//       assignment = await _assignmentService.getById(id);
//       linkedForms = await _formService.getLinkedToAssignment(assignment!);
//       setBusy(false);
//       // timelineData =
//       //     await _timelineService.getTimelineForAssignment(assignmentId);
//     } catch (e) {
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   Future<String> showBasicBottomSheet() async {
//     final assignment = await _assignmentService.getById(id);
//     final assignedForms = await _formService.getLinkedToAssignment(assignment!);
//
//     final selectedFormVersionId = await _bottomSheetService.showCustomSheet<
//             FormVersionModel, AssignmentModelNew>(
//         variant: BottomSheetType.createSubmission,
//         title: '(${S.current.form(assignedForms.length)})',
//         description:
//             'Use this bottom sheet function to show something to the user. It\'s better than the standard alert dialog in terms of UI quality.',
//         data: assignment);
//     final submission = await _submissionService.createEntity(
//         formVersion: selectedFormVersionId,
//         assignmentId: id,
//         team: assignment.team.id,
//         form: selectedFormVersionId!.data!.form,
//         version: selectedFormVersionId.data!.version);
//
//     final createdSubmission = await _submissionService.save(submission);
//     // TODO navigate to submission view
//     // _navigationSheetService.rep
//     return submission.id;
//   }
// }
