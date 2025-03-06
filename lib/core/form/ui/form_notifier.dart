import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class FormStateNotifier extends _$FormStateNotifier {
  @override
  Future<FormState> build() async {
    // final FormVersion formTemplate =
    //     await ref.watch(submissionFormTemplateProvider.future);
    final FormFlatTemplate formTemplate =
        ref.watch(submissionFormFlatTemplateProvider);
    return FormState.fromTemplate(formTemplate);
  }

  Future<void> loadForm(String submissionUid) async {
    // Load FormSubmission, DataValues, and RepeatInstances from SQLite.
    // Construct SectionState instances from SectionConf and associated DataValues.
    // Initialize dependency manager (see below) for the entire form.
  }

// Methods to update global validity, etc.
}
