// import 'dart:convert';
// import 'dart:io';
//
// import 'package:d_sdk/core/http/http_client.dart';
// import 'package:dio/src/response.dart';
// import 'package:injectable/injectable.dart';
//
// // @Order(2)
// @Injectable(as: HttpClient)
// class AuthorizeHttpClientDecorator extends HttpClient<dynamic> {
//   late final HttpClient<dynamic> decoratee;
//
//   @override
//   Future<Response<dynamic>> request(
//       {required String resourceName,
//       required String method,
//       Object? data,
//       Map<String, dynamic>? headers}) {
//     // final loggedInUser = userData;
//     // final loggedInUser = ;
//
//     final authorizedHeaders = headers ?? {}
//       ..addAll({
//         HttpHeaders.authorizationHeader:
//         'Basic ${base64Encode(utf8.encode('${loggedInUser.username}:${loggedInUser.password}'))}'
//       });
//
//     return decoratee.request(
//         resourceName: resourceName,
//         method: method,
//         data: data,
//         headers: authorizedHeaders);
//   }
//
// }
