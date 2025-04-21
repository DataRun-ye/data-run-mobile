// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/auth/auth_manager.dart' as _i976;
import 'package:d_sdk/core/config/app_environment_instance.dart' as _i132;
import 'package:d_sdk/user_session/user_session.dart' as _i1010;
import 'package:datarunmobile/core/auth/auth.dart';
import 'package:datarunmobile/core/auth/auth_interceptor.dart' as _i656;
import 'package:datarunmobile/core/network/connectivy_service.dart' as _i761;
import 'package:datarunmobile/core/sync/sync_coordinator.dart' as _i432;
import 'package:datarunmobile/core/sync/sync_executor.dart' as _i148;
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart' as _i492;
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart' as _i28;
import 'package:datarunmobile/core/sync/sync_scheduler.dart' as _i658;
import 'package:datarunmobile/core/sync_manager/sync_manager.dart' as _i602;
import 'package:datarunmobile/core/user_session/default_session_repository.dart'
    as _i202;
import 'package:datarunmobile/di/dio_module.dart' as _i388;
import 'package:datarunmobile/di/third_party_services.module.dart' as _i224;
import 'package:datarunmobile/features/bottom_sheet/application/bottom_sheet_service.dart'
    as _i964;
import 'package:datarunmobile/features/dialog/application/dialog_service.dart'
    as _i418;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

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
  final dioModule = _$DioModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => thirdPartyServicesModule.prefs,
    preResolve: true,
  );
  gh.factory<_i1010.CacheStorageAdapter>(
      () => thirdPartyServicesModule.cacheStorageAdapter);
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
  gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => thirdPartyServicesModule.flutterSecureStorage);
  gh.lazySingleton<_i964.BottomSheetService>(() => _i964.BottomSheetService());
  gh.lazySingleton<_i418.DialogService>(() => _i418.DialogService());
  gh.factory<_i492.SyncMetadataRepository>(
      () => _i492.SyncMetadataRepository(gh<_i460.SharedPreferences>()));
  gh.factory<String>(
    () => dioModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.factory<String>(
    () => dioModule.apiPath,
    instanceName: 'apiPath',
  );
  gh.factory<_i148.SyncExecutor>(() =>
      _i148.SyncExecutor(progressNotifier: gh<_i28.SyncProgressNotifier>()));
  gh.factory<bool>(
    () => dioModule.shouldClearBeforeSave,
    instanceName: 'shouldClearBeforeSave',
  );
  gh.factory<int>(
    () => dioModule.sendTimeOut,
    instanceName: 'sendTimeOut',
  );
  gh.lazySingleton<_i1010.SessionRepository>(() =>
      _i202.DefaultSessionRepository(
        storageAdapter: gh<_i1010.CacheStorageAdapter>(),
        shouldClearBeforeSave: gh<bool>(instanceName: 'shouldClearBeforeSave'),
      ));
  gh.factory<_i656.AuthInterceptor>(() => _i656.AuthInterceptor(
        baseUrl: gh<String>(instanceName: 'baseUrl'),
        sessionRepository: gh<_i1010.SessionRepository>(),
      ));
  gh.lazySingleton<_i361.Dio>(() => dioModule.dio(
        gh<_i656.AuthInterceptor>(),
        gh<String>(instanceName: 'baseUrl'),
      ));
  gh.singleton<SessionScopeInitializer>(() => SessionScopeInitializer(
      sessionRepository: gh<_i1010.SessionRepository>()));
  gh.lazySingleton<_i761.ConnectivityService>(
    () => _i761.ConnectivityService(
      environmentInstance: gh<_i132.AppEnvironmentInstance>(),
      dio: gh<_i361.Dio>(),
    ),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i658.SyncScheduler>(() => _i658.SyncScheduler(
        metadataRepo: gh<_i492.SyncMetadataRepository>(),
        connectivity: gh<_i761.ConnectivityService>(),
      ));
  gh.lazySingleton<_i976.AuthManager>(() => SdkAuthManager(
        sessionRepository: gh<_i1010.SessionRepository>(),
        scopeInitializer: gh<SessionScopeInitializer>(),
        dio: gh<_i361.Dio>(),
      ));
  gh.factory<_i432.SyncCoordinator>(() => _i432.SyncCoordinator(
        gh<_i492.SyncMetadataRepository>(),
        gh<_i658.SyncScheduler>(),
        gh<_i148.SyncExecutor>(),
      ));
  return getIt;
}

class _$ThirdPartyServicesModule extends _i224.ThirdPartyServicesModule {}

class _$DioModule extends _i388.DioModule {}
