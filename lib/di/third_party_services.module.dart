import 'dart:io';

import 'package:d_sdk/core/config/app_environment_instance.dart';
import 'package:d_sdk/user_session/user_session.dart';
import 'package:datarunmobile/core/user_session/secure_cache_storage_adapter.dart';
import 'package:datarunmobile/core/user_session/shared_cache_storage_adapter.dart'
    show SharedCacheStorageAdapter;
import 'package:datarunmobile/di/app_environment.dart' show AppEnvironment;
import 'package:datarunmobile/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @singleton
  AppEnvironmentInstance get appEnvironmentInstance => AppEnvironmentInstance(
      envLabel: AppEnvironment.envLabel,
      apiBaseUrl: AppEnvironment.apiBaseUrl,
      apiPath: AppEnvironment.apiPath,
      defaultLocale: AppEnvironment.defaultLocale,
      apiRequestSentTimeout: AppEnvironment.apiRequestSentTimeout,
      secureDatabase: AppEnvironment.secureDatabase,
      encryptionKey: AppEnvironment.encryptionKey);

  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @factoryMethod
  CacheStorageAdapter get cacheStorageAdapter => kIsWeb || Platform.isLinux
      ? SharedCacheStorageAdapter(cacheStorage: appLocator<SharedPreferences>())
      : SecureCacheStorageAdapter(
          cacheStorage: appLocator<FlutterSecureStorage>());
}

const AndroidOptions _androidOptions = AndroidOptions(
  encryptedSharedPreferences: true,
  keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
  storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
);

const IOSOptions _iosOptions = IOSOptions(
  accessibility: KeychainAccessibility.passcode,
  synchronizable: false,
);
