import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/shared/d_run_base.model.dart';
import 'package:meta/meta.dart';

@immutable
class IdentifiableModel extends DRunBaseModel {
  IdentifiableModel({
    required this.id,
    this.code,
    required this.name,
    this.description,
    Map<String, dynamic>? label,
    Map<String, dynamic>? properties,
  })  : this.label = label ?? {},
        this.properties = properties ?? {};

  final String id;
  final String? code;
  final String? description;
  final String name;
  final Map<String, dynamic> label;
  final Map<String, dynamic> properties;

  String get displayLabel => getItemLocalString(label, defaultString: name);

  IdentifiableModel copyWith({
    String? id,
    String? code,
    String? name,
    Map<String, dynamic>? label,
    Map<String, dynamic>? properties,
  }) {
    return IdentifiableModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      label: label ?? this.label,
      properties: label ?? this.properties,
    );
  }

  @override
  List<Object?> get props => super.props + [code, name, description];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'code': this.code,
      'description': this.description,
      'name': this.name,
      'label': this.label,
      'properties': this.properties,
    };
  }

  factory IdentifiableModel.fromMap(Map<String, dynamic> map) {
    return IdentifiableModel(
      id: map['id'] as String,
      code: map['code'] as String,
      description: map['description'],
      name: map['name'],
      label: {map['label'] ?? {}} as Map<String, dynamic>,
      properties: (map['properties'] ?? {}) as Map<String, dynamic>,
    );
  }
}
