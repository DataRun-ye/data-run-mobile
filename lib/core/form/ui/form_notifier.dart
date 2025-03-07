import 'package:datarun/core/form/data/form_repository.dart';
import 'package:datarun/core/form/form_state/form_state.dart';
import 'package:datarun/core/form/ui/intent/form_intent_sealed.dart';
import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_notifier.g.dart';

@riverpod
FormRepository formRepository(FormRepositoryRef ref) {
  throw UnimplementedError();
}

@riverpod
FormFlatTemplate submissionFormFlatTemplate(SubmissionFormFlatTemplateRef ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [submissionFormFlatTemplate])
class FormNotifier extends _$FormNotifier {
  @override
  Future<FormState> build() async {
    // final FormVersion formTemplate =
    //     await ref.watch(submissionFormTemplateProvider.future);
    final FormFlatTemplate formTemplate =
        ref.watch(submissionFormFlatTemplateProvider);
    // return FormState.fromTemplate(formTemplate);
    throw UnimplementedError();
  }

  Future<void> handleIntent(FormIntent intent) async {
    final previousState = await future;

    state = AsyncData(previousState.copyWith(isLoading: true));

    try {
      await switch (intent) {
        OnSave() => throw UnimplementedError(), //_handleSave(intent)
        OnFocus() => throw UnimplementedError(), //_handleFocus(intent),
        OnTextChange() =>
          throw UnimplementedError(), //_handleTextChange(intent),
        OnFinish() => throw UnimplementedError(), //_handleFinish(),
        // ... other intents
        // TODO: Handle this case.
        OnNext() => throw UnimplementedError(),
        // TODO: Handle this case.
        ClearValue() => throw UnimplementedError(),
        // TODO: Handle this case.
        OnClear() => throw UnimplementedError(),
        // TODO: Handle this case.
        OnQrCodeScanned() => throw UnimplementedError(),
        // TODO: Handle this case.
        OnSaveDate() => throw UnimplementedError(),
        // TODO: Handle this case.
        OnSection() => throw UnimplementedError(),
        // TODO: Handle this case.
        FetchOptions() => throw UnimplementedError(),
      };

      _postProcess();
    } finally {
      final previousState = await future;

      state = AsyncData(previousState.copyWith(isLoading: false));
    }
  }

  FormRepository get _repository => ref.watch(formRepositoryProvider);

  Future<void> _handleSave(OnSave intent) async {
    // final validationResult = _validateField(intent);
    // if (validationResult.isValid) {
    //   final saveResult = await _repository.saveField(
    //     intent.uid,
    //     intent.value,
    //     intent.valueType,
    //   );
    //   state = state.copyWith(
    //     fields: _updateFieldInState(intent.uid, saveResult),
    //   );
    // }
  }

  void _postProcess() {
    // _updateCompletionPercentage();
    // _checkDataIntegrity();
    // _checkCalculationLoop();
    // _updateConfigurationErrors();
  }

// ... other handlers
}
