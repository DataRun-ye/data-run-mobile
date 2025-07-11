// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d_sdk/database/shared/assignment_status.dart';
// import 'package:datarunmobile/core/models/d_run_identifiable.dart';
// import 'package:flutter/cupertino.dart';
//
// @immutable
// class AssignmentDetail extends DRunIdentifiable<Assignment> {
//   AssignmentDetail({
//     required Assignment identifiableEntity,
//   }) : super(identifiableEntity: identifiableEntity);
//
//   factory AssignmentDetail.fromIdentifiable(
//       {required Assignment identifiableEntity}) {
//     return AssignmentDetail(identifiableEntity: identifiableEntity);
//   }
//
//   EntityScope? get scope => identifiableEntity.scope;
//
//   AssignmentStatus? get status => identifiableEntity.status;
//
//   @override
//   AssignmentDetail copyWith({
//     Assignment? identifiableEntity,
//   }) {
//     return AssignmentDetail(
//         identifiableEntity: identifiableEntity ?? this.identifiableEntity);
//   }
//
//   @override
//   List<Object?> get props => super.props + [scope, status];
// }
