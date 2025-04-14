// import 'package:d2_remote/d2_remote.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/core/element_instance/data_value_repository.dart';
// import 'package:datarunmobile/core/element_instance/field_state/field_state.dart';
// import 'package:datarunmobile/core/element_instance/form_state.data.dart';
// import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_row_state.dart';
// import 'package:datarunmobile/core/element_instance/repeat_instance/repeat_state.dart';
// import 'package:datarunmobile/core/element_instance/sction_instance/section_state.dart';
// import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'form_state.provider.g.dart';
//
// @riverpod
// String submissionId(SubmissionIdRef ref) {
//   throw UnimplementedError();
// }
//
// @Riverpod(dependencies: [submissionId])
// Future<FormFlatTemplate> submissionFormTemplateFetcher(
//     SubmissionFormTemplateFetcherRef ref) async {
//   String submissionId = ref.watch(submissionIdProvider);
//   final DataSubmission? submission = await D2Remote
//       .formSubmissionModule.formSubmission
//       .byId(submissionId)
//       .getOne();
//
//   final FormVersion formTemplate = await D2Remote.formModule.formTemplateV
//       .byId(submission!.formVersion)
//       .getOne();
//
//   return FormFlatTemplate.fromTemplate(formTemplate);
// }
//
// @riverpod
// FormFlatTemplate submissionFormFlatTemplate(SubmissionFormFlatTemplateRef ref) {
//   throw UnimplementedError();
// }
//
// @Riverpod(dependencies: [submissionFormFlatTemplate])
// class FormStateNotifier extends _$FormStateNotifier {
//   @override
//   Future<FormState> build() async {
//     // final FormVersion formTemplate =
//     //     await ref.watch(submissionFormTemplateProvider.future);
//     final FormFlatTemplate formTemplate =
//         ref.watch(submissionFormFlatTemplateProvider);
//     return FormState.fromTemplate(formTemplate);
//   }
//
//   Future<void> loadForm(String submissionUid) async {
//     // Load FormSubmission, DataValues, and RepeatInstances from SQLite.
//     // Construct SectionState instances from SectionConf and associated DataValues.
//     // Initialize dependency manager (see below) for the entire form.
//   }
//
// // Methods to update global validity, etc.
// }
//
// @Riverpod(dependencies: [submissionFormFlatTemplate])
// class SectionStateNotifier extends _$SectionStateNotifier {
//   @override
//   Future<SectionState> build(String path) async {
//     final FormFlatTemplate formTemplate =
//         ref.watch(submissionFormFlatTemplateProvider);
//
//     return SectionState.fromTemplate(
//         formTemplate.flatFields[path] as SectionElementTemplate);
//   }
// }
//
// @Riverpod(dependencies: [submissionFormFlatTemplate])
// class RepeatStateNotifier extends _$RepeatStateNotifier {
//   @override
//   Future<RepeatState> build(String path) async {
//     final FormFlatTemplate formTemplate =
//         ref.watch(submissionFormFlatTemplateProvider);
//
//     return RepeatState.fromTemplate(
//         formTemplate.flatFields[path] as SectionElementTemplate);
//   }
// }
//
// @Riverpod(dependencies: [submissionFormFlatTemplate])
// class RepeatRowStateNotifier extends _$RepeatRowStateNotifier {
//   @override
//   Future<RowState> build(String path, String repeatUid) async {
//     // final RowState? closestRepeatParent =
//     //     ref.watch<RowState?>(parentElementProvider());
//     final FormFlatTemplate formTemplate =
//         ref.watch(submissionFormFlatTemplateProvider);
//
//     return RowState.fromTemplate(
//         formTemplate.flatFields[path] as SectionElementTemplate,
//         rowId: repeatUid,
//         repeatIndex: 0);
//   }
// }
//
// @Riverpod(dependencies: [submissionFormFlatTemplate])
// class FieldStateNotifier extends _$FieldStateNotifier {
//   @override
//   Future<FieldState> build(String path) async {
//     final FormFlatTemplate formTemplate =
//         ref.watch(submissionFormFlatTemplateProvider);
//
//     return FieldState.fromTemplate(
//         formTemplate.flatFields[path] as FormElementTemplate);
//   }
//
//   Future<void> loadValue() async {
//     final previousState = await future;
//
//     final value = await DataValueRepository.get(
//         submissionId: ref.read(submissionIdProvider),
//         path: path
//     );
//   }
//
//   Future<void> saveValue() async {
//     final previousState = await future;
//
//     await DataValueRepository.save(
//         submissionId: ref.read(submissionIdProvider),
//         path: path,
//         value: previousState.value,
//     );
//
//     state = AsyncData(newState);
//   }
// }
//
// // final fieldStateProvider =
// //     StateProvider.family<FieldState, String>((ref, path) {
// //   final formState = ref.watch(formStateProvider);
// //   return formState.fields[path]!;
// // });
// //
// // void updateFieldInRiverpod(String path, dynamic value, WidgetRef ref) {
// //   ref
// //       .read(fieldStateProvider(path).notifier)
// //       .update((state) => state.copyWith(value: value));
// // }
