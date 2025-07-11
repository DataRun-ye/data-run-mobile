// part of 'form_element.dart';
//
// class FieldReferenceInstance<T> extends FormElementInstance<T>
//     with ElementAttributesMixin {
//   FieldReferenceInstance(
//       {required FieldElementState<T> elementProperties,
//       required super.form,
//       required super.template,
//       MetadataSubmissionUpdate? reference})
//       : _reference = reference,
//         super(elementState: elementProperties) {
//     this.validationMessages.addAll(validationMessages);
//   }
//
//   FieldTemplate get template => _template as FieldTemplate;
//   MetadataSubmissionUpdate? _reference;
//
//   MetadataSubmissionUpdate? get reference => _reference;
//
//   FieldElementState<T> get elementState =>
//       _elementState as FieldElementState<MetadataSubmissionUpdate>;
//
//   final Map<String, ValidationMessageFunction> validationMessages = {};
//
//   @override
//   T? reduceValue() => elementState.value;
//
//   @override
//   FormControl<T> get elementControl =>
//       form.control(elementPath!) as FormControl<T>;
//
//   @override
//   void updateValue(T? value,
//       {bool updateParent = true, bool emitEvent = true}) {
//     if (value == this.value) {
//       return;
//     }
//     updateStatus(elementState.reset(value: value));
//     // _elementState = elementState.reset(value: value);
//     // evaluate();
//     elementControl.updateValue(
//       value,
//       updateParent: updateParent,
//       emitEvent: emitEvent,
//     );
//     // updateValueAndValidity(
//     //   updateParent: updateParent,
//     //   emitEvent: emitEvent,
//     // );
//     // elementControl?.markAsDirty();
//   }
//
//   @override
//   FormElementInstance<dynamic>? findElement(String path) => this;
//
//   @override
//   void forEachChild(
//           void Function(FormElementInstance<dynamic> element) callback) =>
//       <FormElementInstance<dynamic>>[];
//
//   @override
//   void reset({T? value}) {
//     updateStatus(elementState.reset(value: value));
//     elementControl.reset(value: template.defaultValue);
//   }
//
//   List<DataOption> get visibleOption => elementState.visibleOptions;
//
//   // FieldElementState<dynamic> calculateState() {
//   //   FieldElementState<T> newCommonState =
//   //       super.calculateState() as FieldElementState<T>;
//   //
//   //   if (choiceFilter?.expression != null) {
//   //     final visibleOptionsUpdate = choiceFilter!.evaluate(evalContext);
//   //
//   //     final oldState = elementState.copyWith();
//   //     newCommonState = newCommonState.resetValueFromVisibleOptions(
//   //         visibleOptions: visibleOptionsUpdate);
//   //     logDebug(
//   //         '$name, option changed: ${oldState.value != newCommonState.value},  ${oldState.value} => ${newCommonState.value}');
//   //
//   //     // updateStatus(newState /* notify: oldState.value != newState.value*/);
//   //     // elementControl.updateValue(newState.value);
//   //   }
//   //
//   //   return newCommonState;
//   // }
//
//   @override
//   void evaluate(
//       {String? changedDependency,
//       bool updateParent = true,
//       bool emitEvent = true}) {
//     super.evaluate(updateParent: updateParent, emitEvent: emitEvent);
//     if (choiceFilter?.expression != null) {
//       final visibleOptionsUpdate = choiceFilter!.evaluate(evalContext);
//       logDebug(
//           'all field options: ${choiceFilter!.options.map((o) => o.name)}');
//       logDebug(
//           'only visibleOptionsUpdate: ${visibleOptionsUpdate.map((o) => o.name)}');
//       final oldState = elementState.copyWith(); // clone
//       final newState = elementState.resetValueFromVisibleOptions(
//           visibleOptions: visibleOptionsUpdate);
//       logDebug(
//           '$name, option changed: ${oldState.value != newState.value},  ${oldState.value} => ${newState.value}');
//       updateStatus(newState /* notify: oldState.value != newState.value*/);
//       elementControl.updateValue(newState.value);
//     }
//   }
// }
//
// // class ScannedFieldInstance<T> extends FieldInstance<T>
// //     with ElementAttributesMixin {
// //   ScannedFieldInstance({
// //     required super.elementProperties,
// //     required super.form,
// //     required super.template,
// //   });
// //
// //   FieldTemplate get template => _template as FieldTemplate;
// //
// //   FieldElementState<T> get elementState =>
// //       _elementState as FieldElementState<T>;
// //
// //   @override
// //   void evaluate(
// //       {String? changedDependency,
// //         bool updateParent = true,
// //         bool emitEvent = true}) {
// //     super.evaluate(updateParent: updateParent, emitEvent: emitEvent);
// //     if (choiceFilter?.expression != null) {
// //       final visibleOptionsUpdate = choiceFilter!.evaluate(evalContext);
// //       logDebug(
// //           'all field options: ${choiceFilter!.options.map((o) => o.name)}');
// //       logDebug(
// //           'only visibleOptionsUpdate: ${visibleOptionsUpdate.map((o) => o.name)}');
// //       final oldState = elementState.copyWith(); // clone
// //       final newState = elementState.resetValueFromVisibleOptions(
// //           visibleOptions: visibleOptionsUpdate);
// //       logDebug(
// //           '$name, option changed: ${oldState.value != newState.value},  ${oldState.value} => ${newState.value}');
// //       updateStatus(newState /* notify: oldState.value != newState.value*/);
// //       elementControl.updateValue(newState.value);
// //     }
// //   }
// // }
//
// //
// // class FieldWithOptionsInstance<T> extends FieldInstance<T> {
// //   FieldWithOptionsInstance({
// //     required FieldElementWithOptionsState<T> elementProperties,
// //     required super.form,
// //     super.validationMessages,
// //     required super.template,
// //     super.choiceFilter,
// //   }) : super(elementProperties: elementProperties);
// //
// //   @override
// //   void evaluate([String? changedDependency]) {
// //     super.evaluate();
// //     final visibleOptions =
// //         choiceFilter?.evaluate(evalContext) ?? template.options;
// //     logInfo(info: 'all field options: ${template.options.map((o) => o.name)}');
// //     logInfo(info: 'only visibleOptions: ${visibleOptions.map((o) => o.name)}');
// //   }
// // }
// extension FormFieldModelExtensions<T> on FieldInstance<T> {
//   TextInputType? get inputType {
//     return switch (type) {
//       ValueType.Text => TextInputType.text,
//       ValueType.LongText => TextInputType.multiline,
//       ValueType.Letter => TextInputType.text,
//       ValueType.Number =>
//         const TextInputType.numberWithOptions(decimal: true, signed: true),
//       ValueType.UnitInterval =>
//         const TextInputType.numberWithOptions(decimal: true),
//       ValueType.Percentage => TextInputType.number,
//       ValueType.IntegerNegative ||
//       ValueType.Integer =>
//         const TextInputType.numberWithOptions(signed: true),
//       ValueType.IntegerPositive ||
//       ValueType.IntegerZeroOrPositive =>
//         TextInputType.number,
//       ValueType.PhoneNumber => TextInputType.phone,
//       ValueType.Email => TextInputType.emailAddress,
//       ValueType.URL => TextInputType.url,
//       _ => TextInputType.text
//     };
//   }
//
//   TextInputAction? get inputAction {
//     return TextInputAction.none;
//     // return when(
//     //     keyboardActionType, <KeyboardActionType, TextInputAction Function()>{
//     //   KeyboardActionType.NEXT: () => TextInputAction.next,
//     //   KeyboardActionType.DONE: () => TextInputAction.done,
//     //   KeyboardActionType.ENTER: () => TextInputAction.none,
//     // });
//   }
//
//   int? get maxLength {
//     switch (type) {
//       case ValueType.Text:
//         return 255;
//       case ValueType.LongText:
//       case ValueType.Letter:
//         return 500;
//       default:
//         return null;
//     }
//   }
//
//   int get maxLines {
//     switch (type) {
//       case ValueType.LongText:
//       case ValueType.Letter:
//         return 2;
//       default:
//         return 1;
//     }
//   }
//
//   //
//   TextInputAction? get textInputAction {
//     // if (keyboardActionType != null) {
//     //   return when(
//     //       keyboardActionType, <KeyboardActionType, TextInputAction Function()>{
//     //     KeyboardActionType.NEXT: () => TextInputAction.next,
//     //     KeyboardActionType.DONE: () => TextInputAction.done,
//     //     KeyboardActionType.ENTER: () => TextInputAction.none
//     //   });
//     // }
//     return null;
//   }
// }
