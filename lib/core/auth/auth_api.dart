import 'package:d_sdk/auth/auth_response.dart';
import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthApi {
  AuthApi({required this.dioClient});

  final Dio dioClient;

  String get apiPath => AppEnvironment.apiV1Path;

  Future<AuthResponse> login(username, password) async {
    try {
      final response = await dioClient.post('$apiPath/authenticate',
          data: {'username': username, 'password': password},
          options: Options(
            extra: {'skipAuth': true},
            receiveTimeout: const Duration(seconds: 70),
            sendTimeout: const Duration(seconds: 40),
          ));

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      throw AuthException('Error during login',
          cause: e, errorCode: DRunErrorCode.noUserDetailsFetchedFromServer);
    }
  }

  Future<User> getUserProfile(String accessToken) async {
    try {
      final response = await dioClient.get('$apiPath/myDetails',
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

      return User.fromJson({
        ...response.data,
        'username': response.data['username'],
        'authorities': authorities,
        // 'authorities': authorities,
        // 'authorities': authorities,
        // 'authorities': authorities,
        // 'authorities': authorities,
      }, serializer: CustomSerializer());
    } catch (e) {
      throw AuthException('Error while fetching user details', cause: e);
    }
  }
}
