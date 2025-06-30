import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/core/form/model/action_type.dart';
import 'package:equatable/equatable.dart';

/// data class that encapsulates a processed form action
/// with additional context and includes:
/// - the details of an action performed on a specific form field.
/// - Serves as an intermediate representation between the user intent
/// and the actual data processing.
class FormCommand with EquatableMixin {
  FormCommand(
      {required this.uid,
      this.value,
      this.requiresExactMatch = false,
      this.optionCode,
      this.optionName,
      this.extraData,
      this.error,
      required this.type,
      this.valueType});

  final String uid;
  final String? value;
  final bool requiresExactMatch;
  final String? optionCode;
  final String? optionName;
  final String? extraData;
  final DException? error;
  final CommandType type;
  final ValueType? valueType;

  @override
  List<Object?> get props => [
        uid,
        value,
        requiresExactMatch,
        optionCode,
        optionName,
        extraData,
        error,
        type,
        valueType
      ];

  @override
  bool? get stringify => true;

  FormCommand copyWith({
    String? uid,
    String? value,
    bool? requiresExactMatch,
    String? optionCode,
    String? optionName,
    String? extraData,
    DException? error,
    CommandType? actionType,
    ValueType? valueType,
  }) {
    return FormCommand(
      uid: uid ?? this.uid,
      value: value ?? this.value,
      requiresExactMatch: requiresExactMatch ?? this.requiresExactMatch,
      optionCode: optionCode ?? this.optionCode,
      optionName: optionName ?? this.optionName,
      extraData: extraData ?? this.extraData,
      error: error ?? this.error,
      type: actionType ?? this.type,
      valueType: valueType ?? this.valueType,
    );
  }
}
