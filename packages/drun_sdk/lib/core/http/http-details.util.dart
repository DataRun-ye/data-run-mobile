// import 'dart:convert';
//
// import 'package:d_sdk/database/app_database.dart';
//
// class HttpDetails {
//   // AppDatabase? database;
//   // String? baseUrl;
//   String? username;
//   String? password;
//   String? token;
//   String? tokenType;
//   User? user;
//
//   HttpDetails({
//     this.username,
//     this.password,
//     // this.baseUrl,
//     this.token,
//     this.tokenType,
//     // this.database,
//   });
//
//   // Future<HttpDetails> get() async {
//   //   if (this.username != null &&
//   //       this.password != null) {
//   //     return this;
//   //   }
//   //
//   //   final User? user = await database?.managers.users.getSingle();
//   //
//   //
//   //   this.username = user?.username;
//   //   this.password = user?.password;
//   //   this.baseUrl = user?.baseUrl;
//   //   this.token = user?.token;
//   //   this.tokenType = user?.tokenType;
//   //
//   //   return Future.value(this);
//   // }
//
//   String get authToken {
//     if (this.token != null) {
//       return this.token as String;
//     }
//     return base64Encode(utf8.encode('${this.username}:${this.password}'));
//   }
//
//   String get authTokenType {
//     switch (this.tokenType) {
//       case 'bearer':
//         return 'Bearer';
//       default:
//         return 'Basic';
//     }
//   }
// }
