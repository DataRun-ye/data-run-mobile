// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:datarunmobile/commons/query/order_by.dart';
// import 'package:datarunmobile/commons/query/query_model.dart';
//
// class AssignmentQueryModel extends QueryModel {
//   AssignmentQueryModel(
//       {this.activity,
//       this.orgUnit,
//       this.team,
//       this.form,
//       this.date,
//       this.scope,
//       this.status,
//       super.limit,
//       super.offset,
//       super.orderBy});
//
//   final String? activity;
//   final String? orgUnit;
//   final String? team;
//   final String? form;
//   final String? date;
//   final EntityScope? scope;
//   final AssignmentStatus? status;
//
//   @override
//   List<Object?> get props =>
//       super.props + [activity, orgUnit, team, date, scope, status];
//
//   @override
//   Map<String, dynamic> toMap() {
//     final map = {
//       'activity': this.activity,
//       'orgUnit': this.orgUnit,
//       'team': this.team,
//       'form': this.form,
//       'date': this.date,
//       'scope': this.scope?.name,
//       'status': this.status?.name,
//       ...super.toMap()
//     };
//     return map..removeWhere((_, v) => v == null);
//   }
// }
