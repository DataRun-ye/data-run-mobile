import 'package:d_sdk/core/auth/auth_response.dart';
import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthApi {
  AuthApi()
      : _dioClient = Dio()
          ..options.baseUrl = AppEnvironment.apiBaseUrl
          ..options.headers = {
            'content-type': 'application/json; charset=utf-8'
          }
          ..options.connectTimeout = const Duration(seconds: 20)
          ..options.receiveTimeout = const Duration(seconds: 30);

  final Dio _dioClient;

  String get apiPath => AppEnvironment.apiV1Path;

  Future<AuthResponse> login(username, password) async {
    try {
      final response = await _dioClient.post('$apiPath/authenticate',
          data: {'username': username, 'password': password},
          options: Options(
            extra: {'skipAuth': true},
            receiveTimeout: const Duration(seconds: 70),
            sendTimeout: const Duration(seconds: 40),
          ));

      return AuthResponse.fromJson(response.data);
    } catch (e, s) {
      logError('Error during login', source: e, stackTrace: s);
      throw AuthException('Error during login',
          cause: e, errorCode: DRunErrorCode.noUserDetailsFetchedFromServer);
    }
  }

  Future<UserSession> getUserProfile(String accessToken) async {
    try {
      final response = await _dioClient.get('$apiPath/myDetails',
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
            receiveTimeout: const Duration(seconds: 70),
            sendTimeout: const Duration(seconds: 40),
          ));
      final authorities = (response.data['authorities'] as List<dynamic>)
          .map<String>((e) => e['authority'] as String)
          .toList();
      return UserSession.fromJson({
        ...response.data,
        'username': response.data['username'],
        'authorities': authorities,
      });
    } on DioException catch (e) {
      throw DException(e.toString(), e);
    } catch (e, s) {
      logError('Error while fetching user details', source: e, stackTrace: s);
      throw AuthException('Error while fetching user details', cause: e);
    }
  }
}
