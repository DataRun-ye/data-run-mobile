import 'package:datarunmobile/core/auth/auth_interceptor.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @Named('baseUrl')
  @injectable
  String get baseUrl => AppEnvironment.apiBaseUrl;

  @Named('apiPath')
  @injectable
  String get apiPath => AppEnvironment.apiPath;

  @Named('sendTimeOut')
  @injectable
  int get sendTimeOut => AppEnvironment.apiRequestSentTimeout;

  @Named('shouldClearBeforeSave')
  @injectable
  bool get shouldClearBeforeSave => true;

  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor, @Named('baseUrl') String baseUrl) {
    final dioWithAuth = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout:
            const Duration(seconds: AppEnvironment.apiRequestSentTimeout),
      ),
    );

    dioWithAuth.interceptors.add(authInterceptor);
    return dioWithAuth;
  }
}
