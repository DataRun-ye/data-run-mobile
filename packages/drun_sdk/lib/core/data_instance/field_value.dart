import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class FieldValue extends IdentifiableModel {
  FieldValue({
    required super.id,
    required super.name,
    super.label,
    required this.valueType,
    Iterable<String>? appearance,
    super.properties,
    this.value,
    this.optionSet,
    this.showInSummary = false,
    this.createdAt,
  }) : this.appearance = IList.orNull(appearance) ?? const IList.empty();

  final String? optionSet;
  final ValueType valueType;
  final IList<String> appearance;
  final Object? value;
  final bool showInSummary;
  final DateTime? createdAt;

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
    Iterable<String>? appearance,
    DateTime? createdAt,
  }) {
    return FieldValue(
      id: id ?? this.id,
      name: name ?? this.name,
      label: label ?? this.label,
      value: value ?? this.value,
      valueType: valueType ?? this.valueType,
      optionSet: optionSet ?? this.optionSet,
      showInSummary: showInSummary ?? this.showInSummary,
      appearance: IList.orNull(appearance) ?? this.appearance,
      properties: properties ?? this.properties,
      createdAt: createdAt ?? this.createdAt,
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
        appearance,
        properties,
        createdAt,
      ];
}
