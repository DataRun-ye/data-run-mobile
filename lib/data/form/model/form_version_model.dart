import 'package:d2_remote/modules/datarun/form/entities/form_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FormVersionModel extends DRunIdentifiable<FormVersion> {
  FormVersionModel._({
    required FormVersion identifiableEntity,
  }) : super(identifiableEntity: identifiableEntity);

  factory FormVersionModel.fromIdentifiable(
      {required FormVersion identifiableEntity}) {
    return FormVersionModel._(
      identifiableEntity: identifiableEntity,
    );
  }

  String get form =>
      identifiableEntity.formTemplate is FormTemplate
          ? identifiableEntity.formTemplate.id
          : identifiableEntity.formTemplate;

  int get version => identifiableEntity.version;

  @override
  FormVersionModel copyWith({
    FormVersion? identifiableEntity,
  }) {
    return FormVersionModel.fromIdentifiable(
      identifiableEntity: identifiableEntity ?? this.identifiableEntity,
    );
  }

  @override
  List<Object?> get props => super.props + [form, version];
}
