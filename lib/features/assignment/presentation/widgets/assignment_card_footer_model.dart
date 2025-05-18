// import 'package:d_sdk/database/database.dart';
// import 'package:datarunmobile/app_routes/app_router.dart';
// import 'package:datarunmobile/di/app.bottomsheets.dart';
// import 'package:datarunmobile/di/injection.dart';
// import 'package:datarunmobile/features/bottom_sheet/application/bottom_sheet_service.dart';
// import 'package:datarunmobile/features/shared/domain/form_selection_response.dart';
// import 'package:stacked/stacked.dart';
//
// class AssignmentCardFooterModel extends BaseViewModel {
//   final BottomSheetService _sheet = appLocator<BottomSheetService>();
//   final _router = appLocator<AppRouter>();
//   final _db = appLocator<DbManager>().db;
//
//   Future<void> openNewSubmission({required String assignment}) async {
//     final result = await _sheet.showCustomSheet<FormSelectionResponse, String>(
//       variant: BottomSheetType.createSubmission,
//       data: assignment,
//       isScrollControlled: true,
//     );
//     if (result?.data != null) {
//       final formId = result!.data!.formVersion;
//       final aid = result.data!.assignment;
//
//       final newSubmission = await _db.createSubmission(
//         formId: formId,
//         assignmentId: aid,
//       ); // perform submission creation
//       _router.navigateToSubmissionView(id: newSubmission.id);
//     }
//   }
// }
