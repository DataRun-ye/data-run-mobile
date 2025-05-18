import 'package:d_sdk/di/app_environment.dart';
import 'package:datarunmobile/core/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

@module
abstract class ThirdPartyServicesModule {
  @injectable
  Dio dio(AuthInterceptor authInterceptor) {
    final dioWithAuth = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.apiBaseUrl,
        sendTimeout:
            const Duration(seconds: AppEnvironment.apiRequestSentTimeout),
      ),
    );

    dioWithAuth.interceptors.add(authInterceptor);
    return dioWithAuth;
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
