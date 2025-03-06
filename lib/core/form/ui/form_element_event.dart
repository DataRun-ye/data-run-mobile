// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// abstract class FormElementEvent with EquatableMixin {}
//
// @immutable
// class ChangeValueEvent<T> extends FormElementEvent {
//   ChangeValueEvent({
//     required this.elementId,
//     required this.value,
//     this.ignoreLastChange = false,
//   });
//
//   final T value;
//   final String elementId;
//   final bool ignoreLastChange;
//
//   @override
//   List<Object?> get props => [elementId, value, ignoreLastChange];
// }
//
// @immutable
// class ChangeMultipleValuesEvent extends FormElementEvent {
//   ChangeMultipleValuesEvent(this.changeValueEvents);
//
//   final List<ChangeValueEvent<dynamic>> changeValueEvents;
//
//   @override
//   List<Object?> get props => [changeValueEvents];
// }
