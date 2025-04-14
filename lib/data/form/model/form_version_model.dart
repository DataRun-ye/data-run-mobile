// import 'package:d2_remote/modules/datarun/form/entities/form_template.entity.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/core/models/d_run_base_model.dart';
// import 'package:flutter/cupertino.dart';
//
// @immutable
// class FormVersionModel extends DRunBaseModel<FormVersion> {
//   FormVersionModel._({
//     required FormVersion baseEntity,
//     this.submissionCount = 0,
//   }) : super(baseEntity: baseEntity);
//
//   factory FormVersionModel.fromIdentifiable(
//       {required FormVersion identifiableEntity, int submissionCount = 0}) {
//     return FormVersionModel._(
//         baseEntity: identifiableEntity, submissionCount: submissionCount);
//   }
//
//   String get form => baseEntity.formTemplate is FormTemplate
//       ? baseEntity.formTemplate.id
//       : baseEntity.formTemplate;
//
//   final int submissionCount;
//
//   int get version => baseEntity.version;
//
//   String? get description => this.baseEntity.description;
//
//   @override
//   FormVersionModel copyWith({FormVersion? baseEntity, int? submissionCount}) {
//     return FormVersionModel.fromIdentifiable(
//       identifiableEntity: baseEntity ?? this.baseEntity,
//       submissionCount: submissionCount ?? this.submissionCount,
//     );
//   }
//
//   @override
//   List<Object?> get props => super.props + [form, version, submissionCount];
// }
