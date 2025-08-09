// import 'package:d_sdk/database/shared/shared.dart';
//
// class UserFormAccess {
//   final String user;
//   final String team;
//   final String form;
//   final List<FormPermission> permissions;
//   final DateTime? validFrom;
//   final DateTime? validTo;
//
//   UserFormAccess(
//       {required this.user,
//       required this.team,
//       required this.form,
//       required this.permissions,
//       this.validFrom,
//       this.validTo});
//
//   Map<String, dynamic> toJson() {
//     return {
//       'user': this.user,
//       'team': this.team,
//       'form': this.form,
//       'permissions': this.permissions,
//       'validFrom': this.validFrom?.toIso8601String(),
//       'validTo': this.validTo?.toIso8601String(),
//     };
//   }
//
//   factory UserFormAccess.fromJson(Map<String, dynamic> map) {
//     return UserFormAccess(
//       user: map['user'] as String,
//       team: map['team'] as String,
//       form: map['form'] as String,
//       permissions: map['permissions'] as List<FormPermission>,
//       validFrom: DateTime.tryParse(map['validFrom']),
//       validTo: DateTime.tryParse(map['validTo']),
//     );
//   }
// }
