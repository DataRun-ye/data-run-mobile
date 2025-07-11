// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
// import 'package:datarunmobile/data_run/form/form_submission/submission_list.provider.dart';
// import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
// import 'package:datarunmobile/data_run/screens/form_submission_list/model/submission_creation_model.provider.dart';
// import 'package:datarunmobile/generated/l10n.dart';
//
// class SubmissionCreationDialog extends ConsumerStatefulWidget {
//   const SubmissionCreationDialog({super.key});
//
//   @override
//   SubmissionCreationDialogState createState() =>
//       SubmissionCreationDialogState();
// }
//
// class SubmissionCreationDialogState
//     extends ConsumerState<SubmissionCreationDialog> {
//   bool _isLoading = false;
//
//   Future<String?> _createEntity(
//       BuildContext context, SubmissionCreationModel model) async {
//     final formMetadata = FormMetadataWidget.of(context);
//     final submissionInitialRepository =
//         ref.read(formSubmissionsProvider(formMetadata.form).notifier);
//
//     final submission = await submissionInitialRepository.createNewSubmission(
//       assignment: FormMetadataWidget.of(context).activity,
//       // orgUnit: model.form.control('_${orgUnitControlName}').value,
//       teamUid: model.team,
//       version: FormMetadataWidget.of(context).version,
//     );
//     return submission.uid;
//   }
//
//   Future<void> createAndPopupWithResult(
//       BuildContext context, SubmissionCreationModel model) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String? syncableId;
//     try {
//       // if (model.form.valid) {
//       syncableId = await _createEntity(context, model);
//
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).pop(syncableId);
//       });
//       // } else {
//       // model.form.
//       setState(() {
//         _isLoading = false;
//       });
//       // }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('${S.of(context).errorOpeningNewForm}: $e')),
//       );
//       rethrow;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final formMetadata = FormMetadataWidget.of(context);
//     final templateAsyncValue =
//         ref.watch(submissionCreationModelProvider(formMetadata: formMetadata));
//     return AsyncValueWidget(
//       value: templateAsyncValue,
//       valueBuilder: (SubmissionCreationModel model) => AlertDialog(
//         surfaceTintColor: Theme.of(context).colorScheme.primary,
//         shadowColor: Theme.of(context).colorScheme.shadow,
//         title: Column(
//           children: [
//             Text('${S.of(context).openNewForm}:',
//                 style: Theme.of(context).textTheme.titleMedium),
//             Text(formMetadata.formLabel,
//                 style: Theme.of(context).textTheme.titleLarge)
//           ],
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               if (_isLoading)
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text(S.of(context).cancel),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             onPressed: _isLoading
//                 ? null
//                 : () => createAndPopupWithResult(context, model),
//             child: Text(S.of(context).open),
//           ),
//         ],
//       ),
//     );
//   }
// }
