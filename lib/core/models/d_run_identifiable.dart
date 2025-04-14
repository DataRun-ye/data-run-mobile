// import 'package:datarunmobile/core/models/d_run_base_model.dart';
// import 'package:flutter/cupertino.dart';
//
// @immutable
// class DRunIdentifiable extends DRunBaseModel {
//   DRunIdentifiable({
//     required super.id,
//     this.code,
//     this.name,
//     this.displayName,
//   });
//
//   final String? code;
//   final String? name;
//   final String? displayName;
//
//   @override
//   List<Object?> get props => [id, code, name, displayName];
//
//   DRunIdentifiable copyWith({
//     String? id,
//     String? code,
//     String? name,
//     String? displayName,
//   }) {
//     return DRunIdentifiable(
//       id: id ?? this.id,
//       code: code ?? this.code,
//       name: name ?? this.name,
//       displayName: displayName ?? this.displayName,
//     );
//   }
//
//   factory DRunIdentifiable.fromMap(Map<String, dynamic> map) {
//     return DRunIdentifiable(
//       id: map['id'],
//       code: map['code'],
//       name: map['name'],
//       displayName: map['displayName'],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       ...super.toMap(),
//       'code': this.code,
//       'name': this.name,
//       'displayName': this.displayName,
//     };
//   }
// }
