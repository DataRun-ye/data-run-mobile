// import 'dart:async';
//
// import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
// import 'package:datarunmobile/data_run/form/form_template/template.provider.dart';
// import 'package:datarunmobile/data_run/screens/form/element/form_instance.dart';
// import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
// import 'package:datarunmobile/data_run/screens/form/element/providers/form_instance.provider.dart';
// import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/ou_picker_data_source.provider.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node_data_source.dart';
// import 'package:datarunmobile/data_run/screens/project_activity_detail/model/project_activities.provider.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'submission_creation_model.provider.g.dart';
//
// @riverpod
// Future<SubmissionCreationModel> submissionCreationModel(
//     SubmissionCreationModelRef ref,
//     {required FormMetadata formMetadata}) async {
//   final FormVersion? template = await ref.watch(submissionVersionFormTemplateProvider(
//           formId: formMetadata.assignmentForm.formId)
//       .future);
//
//   final FormGroup formGroup = FormGroup({
//     '_${orgUnitControlName}': FormControl<String>(
//         /* value: template?.orgUnits.length == 1 ? template?.orgUnits.first : null,*/
//         validators: [Validators.required])
//   });
//
//   final team = await ref
//       .watch(activityTeamProvider(activity: formMetadata.activity).future);
//
//   final TreeNodeDataSource dataSource = await ref
//       .watch(ouPickerDataSourceProvider(formMetadata: formMetadata).future);
//
//   return SubmissionCreationModel(
//     dataSource: dataSource,
//     form: formGroup,
//     team: team!.uid!,
//   );
// }
//
// class SubmissionCreationModel {
//   SubmissionCreationModel(
//       {required this.form, required this.dataSource, required this.team});
//
//   final FormGroup form;
//   final TreeNodeDataSource dataSource;
//   final String team;
// }
