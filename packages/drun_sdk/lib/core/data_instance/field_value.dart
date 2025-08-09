import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:d_sdk/database/shared/value_type.dart';

class FieldValue extends IdentifiableModel {
  FieldValue({
    required super.id,
    required super.name,
    super.label,
    required this.valueType,
    this.value,
    this.optionSet,
    this.showInSummary = false,
  });

  final String? optionSet;
  final ValueType valueType;
  final Object? value;
  final bool showInSummary;

  @override
  FieldValue copyWith({
    String? id,
    String? code,
    String? name,
    Map<String, dynamic>? label,
    Map<String, dynamic>? properties,
    Object? value,
    ValueType? valueType,
    String? optionSet,
    bool? showInSummary,
  }) {
    return FieldValue(
      id: id ?? this.id,
      name: name ?? this.name,
      label: label ?? this.label,
      value: value ?? this.value,
      valueType: valueType ?? this.valueType,
      optionSet: optionSet ?? this.optionSet,
      showInSummary: showInSummary ?? this.showInSummary,
    );
  }

  @override
  List<Object?> get props =>
      super.props +
      [
        value,
        valueType,
        optionSet,
        showInSummary,
      ];
}
