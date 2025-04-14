import 'package:d_sdk/core/cache/cache.dart' show CacheStorage;
import 'package:d_sdk/core/config/app_environment_instance.dart';
import 'package:datarunmobile/core/user_session/secure_cache_storage_adapter.dart';
import 'package:datarunmobile/core/user_session/shared_cache_storage_adapter.dart'
    show SharedCacheStorageAdapter;
import 'package:datarunmobile/di/app_environment.dart' show AppEnvironment;
import 'package:datarunmobile/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SnackbarService get snackbarService;

  @lazySingleton
  BottomSheetService get bottomSheetService;

  @singleton
  AppEnvironmentInstance get appEnvironmentInstance => AppEnvironmentInstance(
      envLabel: AppEnvironment.envLabel,
      apiBaseUrl: AppEnvironment.apiBaseUrl,
      apiPath: AppEnvironment.apiPath,
      defaultLocale: AppEnvironment.defaultLocale,
      apiRequestSentTimeout: AppEnvironment.apiRequestSentTimeout,
      secureCache: AppEnvironment.secureCache,
      secureDatabase: AppEnvironment.secureDatabase,
      encryptionKey: AppEnvironment.encryptionKey);

  @singleton
  Dio dio(AppEnvironmentInstance envInstance) => Dio(
        BaseOptions(
          baseUrl: AppEnvironment.apiBaseUrl,
          sendTimeout:
              const Duration(seconds: AppEnvironment.apiRequestSentTimeout),
        ),
      );

  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() => const FlutterSecureStorage();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @factoryMethod
  CacheStorage getAdapter() {
    return AppEnvironment.secureCache
        ? SecureStorageAdapter(
            cacheStorage: appLocator<FlutterSecureStorage>(),
            prefs: appLocator<SharedPreferences>())
        : SharedCacheStorageAdapter(
            cacheStorage: appLocator<SharedPreferences>());
  }
}
