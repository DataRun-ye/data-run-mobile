import 'package:d_sdk/di/app_environment.dart';
import 'package:datarunmobile/core/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

@module
abstract class ThirdPartyServicesModule {
  @singleton
  CancelToken cancelToken() => CancelToken();

  @injectable
  Dio dio(AuthInterceptor authInterceptor, CancelToken cancelToken) {
    final Map<String, String> _headers = {};
    _headers['content-type'] = 'application/json; charset=utf-8';

    final dio = Dio()
      ..options.baseUrl = AppEnvironment.apiBaseUrl
      ..options.headers = _headers
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 20)
      ..interceptors.add(authInterceptor);

    return dio;
  }

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
}

const AndroidOptions _androidOptions = AndroidOptions(
  encryptedSharedPreferences: true,
  keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
  storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
);

const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.passcode, synchronizable: false);
