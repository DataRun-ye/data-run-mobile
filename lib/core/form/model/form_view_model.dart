// import 'package:datarunmobile/app/app.locator.dart';
// import 'package:datarunmobile/core/form/data/form_repository.dart';
// import 'package:datarunmobile/core/form/form_state/form_state.data.dart';
// import 'package:datarunmobile/core/form/data/form_command_handler.dart';
// import 'package:datarunmobile/core/form/ui/intent/command.dart';
// import 'package:datarunmobile/core/form/ui/intent/form_intent_sealed.dart';
//
// class FormViewModel {
//   FormState state = FormState.initial();
//   final FormRepository _repo = locator<FormRepository>();
//   final FormCommandHandler commandHandler = locator<FormCommandHandler>();
//
//   Future<void> commandFromIntent(FormIntent intent) async {
//     try {
//       await switch (intent) {
//         OnSave() => throw UnimplementedError(), //_handleSave(intent)
//         OnFocus() => throw UnimplementedError(), //_handleFocus(intent),
//         OnTextChange() =>
//           throw UnimplementedError(), //_handleTextChange(intent),
//         OnFinish() => throw UnimplementedError(), //_handleFinish(),
//         // ... other intents
//         // TODO: Handle this case.
//         OnNext() => throw UnimplementedError(),
//         // TODO: Handle this case.
//         ClearValue() => throw UnimplementedError(),
//         // TODO: Handle this case.
//         OnClear() => throw UnimplementedError(),
//         // TODO: Handle this case.
//         OnQrCodeScanned() => throw UnimplementedError(),
//         // TODO: Handle this case.
//         OnSaveDate() => throw UnimplementedError(),
//         // TODO: Handle this case.
//         OnSection() => throw UnimplementedError(),
//         // TODO: Handle this case.
//         FetchOptions() => throw UnimplementedError(),
//       };
//
//       // _postProcess();
//     } finally {
//       final previousState = await future;
//
//       state = AsyncData(previousState.copyWith(isLoading: false));
//     }
//   }
//
//   void handleIntentCommand(FormIntent intent) {
//     if (intent is UpdateFieldIntent) {
//       _execCommand(
//           ValidateAndUpdateFieldCommand(intent.fieldId, intent.newValue));
//     } else if (intent is SubmitFormIntent) {
//       _execCommand(SubmitFormCommand());
//     }
//   }
//
//   Future<void> _execCommand(Command cmd) async {
//     final events = await commandHandler.handleCommand(cmd);
//     for (var e in events) _applyEvent(e);
//     _notifyUI();
//   }
//
//   void _applyEvent(FormEvent e) {
//     if (e is FieldValueChangedEvent) {
//       final fs = (e.fieldId == 'age' ? state.age : state.guardianName)
//           .copyWith(value: e.newValue as String);
//       state = state.copyWith(
//           age: e.fieldId == 'age' ? fs : null,
//           guardianName: e.fieldId == 'guardianName' ? fs : null);
//     }
//     if (e is FieldValidationResultEvent) {
//       /* update valid/err */
//     }
//     if (e is FieldVisibilityChangedEvent) {
//       /* hide/show guardian */
//     }
//     if (e is FormSubmittedEvent) {
//       state = state.copyWith(isSubmitting: false, submitMessage: e.message);
//     }
//   }
//
//   void _notifyUI() {
//     // e.g. call setState, notifyListeners, etc.
//   }
// }
