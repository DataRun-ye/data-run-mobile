import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:datarun/core/sync_manager/nmc_worker/sync_status_controller.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:datarun/commons/extensions/list_extensions.dart';

class FormElementState with EquatableMixin {
  final bool hidden;
  final bool readOnly;
  final bool mandatory;
  final Map<String, dynamic> errors;

  bool get hasErrors => errors.isNotEmpty;

  bool get isVisible => !hidden;

  const FormElementState({
    this.hidden = false,
    this.readOnly = false,
    this.mandatory = false,
    this.errors = const {},
  });

  FormElementState AddError(MapEntry<String, dynamic> newErrors) => copyWith(
      errors: Map<String, dynamic>.of(errors)..addEntries([newErrors]));

  FormElementState mergeErrors(Map<String, dynamic> newErrors) => copyWith(
      errors: Map<String, dynamic>.of(errors).lock.addMap(newErrors).unlock);

  FormElementState setErrors(Map<String, dynamic> newErrors) =>
      copyWith(errors: newErrors);

  FormElementState copyWith({
    bool? hidden,
    bool? readOnly,
    bool? mandatory,
    Map<String, dynamic>? errors,
  }) {
    return FormElementState(
      hidden: hidden ?? this.hidden,
      readOnly: readOnly ?? this.readOnly,
      mandatory: mandatory ?? this.mandatory,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [hidden, mandatory, readOnly, ...errors.values];
}

class FieldElementState<T> extends FormElementState {
  final T? value;
  List<FormOption> visibleOptions;

  FieldElementState({
    super.hidden,
    super.readOnly,
    super.mandatory,
    super.errors,
    this.visibleOptions = const [],
    this.value,
  });

  @override
  FieldElementState<T> copyWith(
      {bool? hidden,
      bool? readOnly,
      bool? mandatory,
      Map<String, dynamic>? errors,
      T? value,
      List<FormOption>? visibleOptions}) {
    return FieldElementState<T>(
      hidden: hidden ?? this.hidden,
      mandatory: mandatory ?? this.mandatory,
      readOnly: readOnly ?? this.readOnly,
      errors: errors ?? this.errors,
      value: value ?? this.value,
      visibleOptions: visibleOptions ?? this.visibleOptions,
    );
  }

  FieldElementState<T> reset({T? value}) {
    return FieldElementState<T>(
      hidden: this.hidden,
      mandatory: this.mandatory,
      errors: this.errors,
      value: value,
      visibleOptions: this.visibleOptions,
    );
  }

  FieldElementState<T> resetValueFromVisibleOptions(
      {required List<FormOption> visibleOptions}) {
    if (!DeepCollectionEquality.unordered()
        .equals(this.visibleOptions, visibleOptions)) {
      if (T is List<String>) {
        final selectedValues = (value as List<String>)
            .where((selectedValue) => visibleOptions.contains(selectedValue))
            .toList();
        visibleOptions.where((option) => option.name == this.value).toList();
        return copyWith(visibleOptions: visibleOptions)
            .reset(value: selectedValues as T);
      } else {
        final String? newValue = visibleOptions
            .firstOrNullWhere((option) => option.name == this.value)
            ?.name;

        return copyWith(visibleOptions: visibleOptions)
            .reset(value: newValue as T?);
      }
    }
    return this;
  }

  @override
  List<Object?> get props => super.props..addAll([visibleOptions, value]);
}

// class SectionElementState extends FormElementState {
//   const SectionElementState({
//     super.hidden,
//     super.readOnly,
//     super.mandatory,
//     super.errors,
//   });
//
//   @override
//   SectionElementState copyWith(
//       {bool? hidden,
//       bool? readOnly,
//       bool? mandatory,
//       Map<String, dynamic>? errors}) {
//     return SectionElementState(
//       hidden: hidden ?? this.hidden,
//       mandatory: mandatory ?? this.mandatory,
//       readOnly: readOnly ?? this.readOnly,
//       errors: errors ?? this.errors,
//     );
//   }
// }

// class RepeatInstanceState extends SectionElementState {
//   // element <name, state>..
//   final List<FieldElementState<dynamic>> columnsStates;
//
//   RepeatInstanceState({
//     super.hidden,
//     super.mandatory,
//     super.errors,
//     super.readOnly,
//     this.columnsStates = const [],
//   });
//
//   // RepeatInstanceState<T> applyRule(FieldElementState<dynamic> state) {
//   //   return copyWith(columnsStates: [...columnsStates, state].toSet().toList());
//   // }
//
//   @override
//   RepeatInstanceState copyWith({
//     bool? hidden,
//     bool? readOnly,
//     bool? mandatory,
//     Map<String, dynamic>? errors,
//     List<FieldElementState<dynamic>>? columnsStates,
//   }) {
//     return RepeatInstanceState(
//       hidden: hidden ?? this.hidden,
//       mandatory: mandatory ?? this.mandatory,
//       readOnly: readOnly ?? this.readOnly,
//       errors: errors ?? this.errors,
//       columnsStates: columnsStates ?? this.columnsStates,
//     );
//   }
//
//   @override
//   List<Object?> get props => super.props..addAll([columnsStates]);
// }
