import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/core/form/element_template/template.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';

class FormTemplateModel extends IdentifiableModel {
  FormTemplateModel({
    required super.id,
    required super.name,
    super.label,
    required this.formVersion,
    required this.versionNumber,
    this.description,
    required this.fields,
    required this.sections,
  });

  final String formVersion;
  final int versionNumber;
  final String? description;
  final BuiltList<Template> fields;
  final BuiltList<Template> sections;

  @override
  List<Object?> get props => super.props + [formVersion, versionNumber];
}
