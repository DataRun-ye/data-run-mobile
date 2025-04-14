// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/auth/auth_manager.dart' as _i976;
import 'package:d_sdk/auth/authentication_service.dart' as _i335;
import 'package:d_sdk/core/cache/cache.dart' as _i505;
import 'package:d_sdk/core/config/app_environment_instance.dart' as _i132;
import 'package:d_sdk/core/http/http_client.dart' as _i8;
import 'package:d_sdk/core/user_session/session_storage_manager.dart' as _i389;
import 'package:d_sdk/datasource/abstract_datasource.dart' as _i458;
import 'package:datarunmobile/core/auth/remote_authentication.dart' as _i859;
import 'package:datarunmobile/core/auth/sdk_auth_manager.dart' as _i157;
import 'package:datarunmobile/core/http/http_adapter.dart' as _i445;
import 'package:datarunmobile/core/sync/sync_coordinator.dart' as _i432;
import 'package:datarunmobile/core/sync/sync_executor.dart' as _i148;
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart' as _i492;
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart' as _i28;
import 'package:datarunmobile/core/sync/sync_scheduler.dart' as _i658;
import 'package:datarunmobile/core/sync_manager/sync_manager.dart' as _i602;
import 'package:datarunmobile/core/user_session/sdk_session_storage_manager.dart'
    as _i701;
import 'package:datarunmobile/core/user_session/shared_cache_storage_adapter.dart'
    as _i199;
import 'package:datarunmobile/di/third_party_services.module.dart' as _i224;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:stacked_services/stacked_services.dart' as _i1055;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => thirdPartyServicesModule.prefs,
    preResolve: true,
  );
  gh.factory<_i505.CacheStorage>(() => thirdPartyServicesModule.getAdapter());
  gh.singleton<_i132.AppEnvironmentInstance>(
      () => thirdPartyServicesModule.appEnvironmentInstance);
  gh.lazySingleton<_i28.SyncProgressNotifier>(
    () => _i28.SyncProgressNotifier(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i602.SyncManager>(
    () => _i602.SyncManager(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i1055.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i1055.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i1055.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i1055.BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => thirdPartyServicesModule.flutterSecureStorage());
  gh.lazySingleton<_i492.SyncMetadataRepository>(
      () => _i492.SyncMetadataRepository(gh<_i460.SharedPreferences>()));
  gh.singleton<_i361.Dio>(
      () => thirdPartyServicesModule.dio(gh<_i132.AppEnvironmentInstance>()));
  gh.lazySingleton<_i701.SdkUserSessionRepository>(() =>
      _i701.SdkUserSessionRepository(cacheStorage: gh<_i505.CacheStorage>()));
  gh.lazySingleton<_i658.SyncScheduler>(() =>
      _i658.SyncScheduler(metadataRepo: gh<_i492.SyncMetadataRepository>()));
  gh.lazySingleton<_i148.SyncExecutor>(() => _i148.SyncExecutor(
        dataSources: gh<Iterable<_i458.AbstractDatasource<dynamic>>>(),
        progressNotifier: gh<_i28.SyncProgressNotifier>(),
      ));
  gh.factory<_i199.SharedCacheStorageAdapter>(() =>
      _i199.SharedCacheStorageAdapter(
          cacheStorage: gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i432.SyncCoordinator>(() => _i432.SyncCoordinator(
        gh<_i492.SyncMetadataRepository>(),
        gh<_i658.SyncScheduler>(),
        gh<_i28.SyncProgressNotifier>(),
      ));
  gh.lazySingleton<_i8.HttpClient<dynamic>>(
    () => _i445.HttpAdapter(gh<_i361.Dio>()),
    instanceName: 'httpAdapter',
  );
  gh.lazySingleton<_i335.AuthenticationService>(() =>
      _i859.RemoteAuthentication(
        httpClient: gh<_i8.HttpClient<dynamic>>(instanceName: 'httpAdapter'),
        envInstance: gh<_i132.AppEnvironmentInstance>(),
      ));
  gh.lazySingleton<_i976.AuthManager>(() => _i157.SdkAuthManager(
        userSessionRepository: gh<_i389.UserSessionRepository>(),
        authenticationService: gh<_i335.AuthenticationService>(),
      ));
  return getIt;
}

class _$ThirdPartyServicesModule extends _i224.ThirdPartyServicesModule {
  @override
  _i1055.NavigationService get navigationService => _i1055.NavigationService();

  @override
  _i1055.DialogService get dialogService => _i1055.DialogService();

  @override
  _i1055.SnackbarService get snackbarService => _i1055.SnackbarService();

  @override
  _i1055.BottomSheetService get bottomSheetService =>
      _i1055.BottomSheetService();
}
