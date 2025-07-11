// import 'package:d_sdk/modules/datarun/form/shared/attribute_type.dart';
// import 'package:equatable/equatable.dart';
//
// class FormAttributes with EquatableMixin {
//   const FormAttributes({
//     this.uuid,
//     this.username,
//     this.userInfo,
//     this.deviceId,
//     this.deviceModel,
//     this.form,
//     this.team,
//     this.activity,
//     this.orgUnit,
//     this.version,
//   });
//
//   String? attribute(AttributeType? attributeType) => switch (attributeType) {
//         AttributeType.uuid => uuid,
//         AttributeType.username => username,
//         AttributeType.userInfo => userInfo,
//         AttributeType.deviceId => deviceId,
//         AttributeType.deviceModel => deviceModel,
//         AttributeType.form => form,
//         // AttributeType.orgUnit => orgUnit,
//         AttributeType.team => team,
//         AttributeType.activity => activity,
//         AttributeType.version => version.toString(),
//         _ => null
//       };
//
//   final String? uuid;
//   final String? username;
//   final String? userInfo;
//   final String? deviceId;
//   final String? deviceModel;
//   final String? form;
//   final String? team;
//   final String? activity;
//   final String? orgUnit;
//   final int? version;
//
//   @override
//   List<Object?> get props => [
//         uuid,
//         username,
//         userInfo,
//         deviceId,
//         deviceModel,
//         form,
//         team,
//         activity,
//         orgUnit,
//         version
//       ];
//
//   FormAttributes copyWith({
//     String? uuid,
//     String? username,
//     String? userInfo,
//     String? deviceId,
//     String? deviceModel,
//     String? form,
//     String? team,
//     String? activity,
//     String? orgUnit,
//     int? version,
//   }) {
//     return FormAttributes(
//       uuid: uuid ?? this.uuid,
//       username: username ?? this.username,
//       userInfo: userInfo ?? this.userInfo,
//       deviceId: deviceId ?? this.deviceId,
//       deviceModel: deviceModel ?? this.deviceModel,
//       form: form ?? this.form,
//       team: team ?? this.team,
//       activity: activity ?? this.activity,
//       orgUnit: orgUnit ?? this.orgUnit,
//       version: version ?? this.version,
//     );
//   }
// }
