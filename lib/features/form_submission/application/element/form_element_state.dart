import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:equatable/equatable.dart';

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

  FormElementState<T> setErrors(Map<String, dynamic> newErrors) =>
      copyWith(errors: newErrors);

  FormElementState<T> copyWith({
    bool? hidden,
    bool? readOnly,
    bool? mandatory,
    String? warning,
    Map<String, dynamic>? errors,
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
  });

  final List<FormOption> visibleOptions;

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
      List<FormOption>? visibleOptions}) {
    return FieldElementState<T>(
      hidden: hidden ?? this.hidden,
      mandatory: mandatory ?? this.mandatory,
      readOnly: readOnly ?? this.readOnly,
      errors: errors ?? this.errors,
      warning: warning ?? this.warning,
      visibleOptions: visibleOptions ?? this.visibleOptions,
    );
  }

  @override
  List<Object?> get props => super.props..addAll(visibleOptions);
}
