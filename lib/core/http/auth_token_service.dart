// import 'dart:io' show HttpHeaders;
//
// import 'package:d_sdk/core/exception/exception.dart';
// import 'package:d_sdk/core/user_session/user_session.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
//
// @LazySingleton()
// class AuthTokenService {
//   AuthTokenService({
//     required SessionRepository storage,
//     @Named('baseUrl') required String baseUrl,
//     @Named('shouldClearBeforeTokenReset')
//     bool shouldClearBeforeTokenReset = true,
//   })  : _storage = storage,
//         this.shouldClearBeforeTokenReset = shouldClearBeforeTokenReset,
//         this.refreshClient = Dio()..options = BaseOptions(baseUrl: baseUrl),
//         this.retryClient = Dio()..options = BaseOptions(baseUrl: baseUrl) {}
//
//   final SessionRepository _storage;
//   final bool shouldClearBeforeTokenReset;
//   final Dio refreshClient;
//   final Dio retryClient;
//
//
// }
