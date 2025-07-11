import 'dart:io';

import 'package:d_sdk/di/app_environment.dart';
import 'package:d_sdk/user_session/cache_storage_adapter.dart';
import 'package:datarunmobile/core/user_session/secure_cache_storage_adapter.dart';
import 'package:datarunmobile/core/user_session/shared_cache_storage_adapter.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SdkModule {
  @Named('shouldClearBeforeSave')
  @injectable
  bool get shouldClearBeforeSave => true;

  @factoryMethod
  CacheStorageAdapter get cacheStorageAdapter =>
      !kIsWeb && !Platform.isLinux && AppEnvironment.secureCache
          ? SecureCacheStorageAdapter(
              cacheStorage: appLocator<FlutterSecureStorage>())
          : SharedCacheStorageAdapter(
              cacheStorage: appLocator<SharedPreferences>());
}
