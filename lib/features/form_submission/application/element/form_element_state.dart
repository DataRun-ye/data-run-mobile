import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FormElementState<T> with EquatableMixin {
  FormElementState({
    this.hidden = false,
    this.readOnly = false,
    this.mandatory = false,
    this.warning = '',
    // this.error = '',
    this.errors = const {},
  });

  final bool hidden;
  final bool readOnly;
  final bool mandatory;
  final String warning;
  final Type? type = T;

  // final String error;
  final Map<String, dynamic> errors;

  bool get hasErrors => errors.isNotEmpty;

  bool get isVisible => !hidden;

  FormElementState<T> setWarning(String warning) => copyWith(warning: warning);

  FormElementState<T> resetWarning(String warning) =>
      copyWith(warning: warning);

  FormElementState<T> setError(String error) =>
      copyWith(errors: Map<String, dynamic>.of(errors)..addAll({error: error}));

  FormElementState<T> resetError(String error) =>
      copyWith(errors: Map<String, dynamic>.of(errors)..remove(error));

  FormElementState<T> AddError(MapEntry<String, dynamic> newErrors) => copyWith(
      errors: Map<String, dynamic>.of(errors)..addEntries([newErrors]));

  FormElementState<T> mergeErrors(Map<String, dynamic> newErrors) => copyWith(
      errors: Map<String, dynamic>.of(errors).lock.addMap(newErrors).unlock);

  FormElementState<T> setErrors(Map<String, dynamic> newErrors) =>
      copyWith(errors: newErrors);

  FormElementState<T> copyWith({
    bool? hidden,
    bool? readOnly,
    bool? mandatory,
    String? warning,
    Map<String, dynamic>? errors,
    T? value,
  }) {
    return FormElementState(
      hidden: hidden ?? this.hidden,
      readOnly: readOnly ?? this.readOnly,
      mandatory: mandatory ?? this.mandatory,
      errors: errors ?? this.errors,
      warning: warning ?? this.warning,
      // error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [hidden, mandatory, readOnly, warning];
}

class FieldElementState<T> extends FormElementState<T> {
  FieldElementState({
    super.hidden,
    super.readOnly,
    super.mandatory,
    super.warning,
    // super.error,
    super.errors,
    this.visibleOptions = const [],
    this.value,
  });

  final T? value;
  final List<DataOption> visibleOptions;

  // Map<String, dynamic>? validationErrors() {
  //   final error = <String, dynamic>{};
  //   if (value == null || (value as String).trim().isEmpty) {
  //     error.addAll({'required': true});
  //   }
  //   if (errors.isNotEmpty) {
  //     error.addAll(errors);
  //   }
  //   return null;
  // }

  @override
  FieldElementState<T> copyWith(
      {bool? hidden,
      bool? readOnly,
      bool? mandatory,
      String? warning,
      Map<String, dynamic>? errors,
      T? value,
      List<DataOption>? visibleOptions}) {
    return FieldElementState<T>(
      hidden: hidden ?? this.hidden,
      mandatory: mandatory ?? this.mandatory,
      readOnly: readOnly ?? this.readOnly,
      errors: errors ?? this.errors,
      warning: warning ?? this.warning,
      value: value ?? this.value,
      visibleOptions: visibleOptions ?? this.visibleOptions,
    );
  }

  FieldElementState<T> reset({T? value}) {
    return FieldElementState<T>(
      hidden: this.hidden,
      mandatory: this.mandatory,
      errors: this.errors,
      warning: this.warning,
      // error: this.error,
      value: value,
      visibleOptions: this.visibleOptions,
    );
  }

  FieldElementState<T> resetValueFromVisibleOptions(
      {required List<DataOption> visibleOptions}) {
    if (!const DeepCollectionEquality.unordered()
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
  List<Object?> get props => super.props..addAll([...visibleOptions, value]);
}
