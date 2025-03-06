import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarun/core/form/model/action_type.dart';
import 'package:equatable/equatable.dart';

/// data class that encapsulates a processed form action
/// with additional context and includes:
/// - the details of an action performed on a specific form field.
/// - Serves as an intermediate representation between the user intent
/// and the actual data processing.
class RowAction with EquatableMixin {
  RowAction(
      {required this.uid,
      this.value,
      this.requiresExactMatch = false,
      this.optionCode,
      this.optionName,
      this.extraData,
      this.error,
      required this.actionType,
      this.valueType});

  final String uid;
  final String? value;
  final bool requiresExactMatch;
  final String? optionCode;
  final String? optionName;
  final String? extraData;
  final DException? error;
  final ActionType actionType;
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
        actionType,
        valueType
      ];

  @override
  bool? get stringify => true;
}
