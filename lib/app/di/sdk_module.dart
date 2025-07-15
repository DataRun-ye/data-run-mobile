import 'dart:io';

import 'package:d_sdk/core/auth/token_storage.dart';
import 'package:d_sdk/core/secure_storage/prefs_storage_service.dart';
import 'package:d_sdk/core/secure_storage/secure_storage_service.dart';
import 'package:d_sdk/core/secure_storage/storage_service.dart';
import 'package:d_sdk/di/app_environment.dart';
import 'package:d_sdk/core/user_session/session_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SdkModule {
  @injectable
  SessionStorage getSessionStorage(SharedPreferences storage) =>
      SessionStorage(storage: storage);

  @factoryMethod
  StorageService getStorageService(
      FlutterSecureStorage secureStorage, SharedPreferences prefs) {
    final storageType =
        !kIsWeb && !Platform.isLinux && AppEnvironment.secureCache
            ? StorageType.secure
            : StorageType.prefs;
    return switch (storageType) {
      StorageType.secure => SecureStorageService(storage: secureStorage),
      StorageType.prefs => PrefsStorageService(storage: prefs)
    };
  }

  @injectable
  TokenStorage getTokenStorage(StorageService storageService) =>
      TokenStorage(storage: storageService);

// @LazySingleton(as: AuthManager)
// AuthManager getAuthManager(
//     {required TokenStorage tokenStorage,
//     required SessionStorage sessionStorage,
//     required SharedPreferences prefs,
//     required AuthApi authApi}) {
//   return AuthManager(
//       tokenStorage: tokenStorage,
//       sessionStorage: sessionStorage,
//       prefs: prefs,
//       authApi: authApi);
// }
}
