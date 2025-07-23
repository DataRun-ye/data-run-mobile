import 'dart:io';

import 'package:d_sdk/di/app_environment.dart';
import 'package:datarunmobile/core/auth/auth_interceptor.dart';
import 'package:datarunmobile/features/form_submission/application/device_info_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

@module
abstract class ThirdPartyServicesModule {
  // @lazySingleton
  // NavigationService get navigationService;
  //
  // @lazySingleton
  // DialogService get dialogService;
  //
  // @lazySingleton
  // SnackbarService get snackbarService;
  //
  // @lazySingleton
  // BottomSheetService get bottomSheetService;

  @injectable
  Dio dio(AuthInterceptor authInterceptor) {
    final Map<String, String> _headers = {};
    _headers['content-type'] = 'application/json; charset=utf-8';

    final dio = Dio()
      ..options.baseUrl = AppEnvironment.apiBaseUrl
      ..options.headers = _headers
      ..options.connectTimeout = const Duration(seconds: 20)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..interceptors.add(authInterceptor);

    return dio;
  }

  @preResolve
  @factoryMethod
  Future<AndroidDeviceInfoService> getAndroidDeviceInfo() async {
    DeviceInfoPlugin;
    if (Platform.isAndroid) {
      return AndroidDeviceInfoService(
          androidDeviceInfo: await DeviceInfoPlugin().androidInfo);
    }

    return AndroidDeviceInfoService(androidDeviceInfo: null);
  }

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @injectable
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
