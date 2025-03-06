// import 'package:datarun/core/form/expression_evaluation/expression_type.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:xwidget_el/xwidget_el.dart';
//
// class ExpressionQuantum with EquatableMixin {
//   ExpressionQuantum(
//       {required this.sourceFieldId,
//       Iterable<String>? dependentFields,
//       required this.type,
//       DateTime? lastUpdated,
//       this.cachedValue})
//       : this.dependentFields = IList.orNull(dependentFields) ?? IList(),
//         this.lastUpdated = lastUpdated ?? DateTime.now();
//
//   final String sourceFieldId;
//   final IList<String> dependentFields;
//   final ExpressionType type;
//   final String expression;
//   final DateTime lastUpdated;
//   final dynamic cachedValue;
//
//   @override
//   List<Object?> get props => [sourceFieldId, type, dependentFields];
//
//   ExpressionQuantum copyWith({
//     String? sourceFieldId,
//     Iterable<String>? dependentFields,
//     ExpressionType? type,
//     DateTime? lastUpdated,
//     dynamic? cachedValue,
//   }) {
//     return ExpressionQuantum(
//       sourceFieldId: sourceFieldId ?? this.sourceFieldId,
//       dependentFields: IList.orNull(dependentFields) ?? this.dependentFields,
//       type: type ?? this.type,
//       lastUpdated: lastUpdated ?? this.lastUpdated,
//       cachedValue: cachedValue ?? this.cachedValue,
//     );
//   }
// }
