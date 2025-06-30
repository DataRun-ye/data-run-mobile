// import 'package:d2_remote/core/datarun/exception/d_exception.dart';
// import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
// import 'package:datarunmobile/core/form/model/action_type.dart';
// import 'package:equatable/equatable.dart';
//
// /// data class that encapsulates a processed form action
// /// with additional context and includes:
// /// - the details of an action performed on a specific form field.
// /// - Serves as an intermediate representation between the user intent
// /// and the actual data processing.
// class Command with EquatableMixin {
//   Command(
//       {required this.uid,
//       this.value,
//       this.optionName,
//       this.extraData,
//       this.error,
//       required this.type,
//       this.valueType});
//
//   final String uid;
//   final String? value;
//   final String? optionName;
//   final String? extraData;
//   final DException? error;
//
//   final CommandType type;
//   final ValueType? valueType;
//
//
//   @override
//   List<Object?> get props => [
//         uid,
//         value,
//         optionName,
//         extraData,
//         error,
//         type,
//         valueType
//       ];
//
//   @override
//   bool? get stringify => true;
//
//   Command copyWith({
//     String? uid,
//     String? value,
//     String? optionName,
//     String? extraData,
//     DException? error,
//     CommandType? type,
//     ValueType? valueType,
//   }) {
//     return Command(
//       uid: uid ?? this.uid,
//       value: value ?? this.value,
//       optionName: optionName ?? this.optionName,
//       extraData: extraData ?? this.extraData,
//       error: error ?? this.error,
//       type: type ?? this.type,
//       valueType: valueType ?? this.valueType,
//     );
//   }
// }
