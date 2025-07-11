// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/core/http/http_client.dart' as _i8;
import 'package:d_sdk/user_session/cache_storage_adapter.dart' as _i216;
import 'package:d_sdk/user_session/session_repository.dart' as _i993;
import 'package:datarunmobile/app/di/sdk_module.dart' as _i567;
import 'package:datarunmobile/app/di/third_party_services.module.dart' as _i427;
import 'package:datarunmobile/core/auth/auth_api.dart' as _i64;
import 'package:datarunmobile/core/auth/auth_interceptor.dart' as _i656;
import 'package:datarunmobile/core/auth/auth_manager.dart' as _i261;
import 'package:datarunmobile/core/auth/sdk_auth_manager.dart' as _i157;
import 'package:datarunmobile/core/form/data/metadata/team_configuration.dart'
    as _i54;
import 'package:datarunmobile/core/http/default_http_adapter.dart' as _i832;
import 'package:datarunmobile/core/network/connectivy_service.dart' as _i761;
import 'package:datarunmobile/core/services/user_session_manager.service.dart'
    as _i775;
import 'package:datarunmobile/core/sync/sync_coordinator.dart' as _i432;
import 'package:datarunmobile/core/sync/sync_executor.dart' as _i148;
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart' as _i492;
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart' as _i28;
import 'package:datarunmobile/core/sync/sync_scheduler.dart' as _i658;
import 'package:datarunmobile/core/sync_manager/sync_manager.dart' as _i602;
import 'package:datarunmobile/core/user_session/default_session.repository.dart'
    as _i694;
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart'
    as _i584;
import 'package:datarunmobile/data/form_template_service.dart' as _i991;
import 'package:datarunmobile/data/option_set_service.dart' as _i158;
import 'package:datarunmobile/features/assignment/application/assignment_service_impl.dart'
    as _i1027;
import 'package:datarunmobile/features/form_submission/application/form_instance_service_impl.dart'
    as _i756;
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
  final sdkModule = _$SdkModule();
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.factory<_i216.CacheStorageAdapter>(() => sdkModule.cacheStorageAdapter);
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => thirdPartyServicesModule.prefs,
    preResolve: true,
  );
  gh.factory<_i54.TeamConfiguration>(() => _i54.TeamConfiguration());
  gh.factory<_i158.OptionSetService>(() => _i158.OptionSetService());
  gh.factory<_i1027.AssignmentServiceImpl>(
      () => _i1027.AssignmentServiceImpl());
  gh.singleton<_i361.CancelToken>(() => thirdPartyServicesModule.cancelToken());
  gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => thirdPartyServicesModule.flutterSecureStorage);
  gh.lazySingleton<_i28.SyncProgressNotifier>(
    () => _i28.SyncProgressNotifier(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i602.SyncManager>(
    () => _i602.SyncManager(),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i775.UserSessionService>(
      () => _i775.UserSessionService(gh<_i460.SharedPreferences>()));
  gh.factory<_i492.SyncMetadataRepository>(
      () => _i492.SyncMetadataRepository(gh<_i460.SharedPreferences>()));
  gh.factory<_i148.SyncExecutor>(() =>
      _i148.SyncExecutor(progressNotifier: gh<_i28.SyncProgressNotifier>()));
  gh.factory<bool>(
    () => sdkModule.shouldClearBeforeSave,
    instanceName: 'shouldClearBeforeSave',
  );
  gh.factory<_i991.FormTemplateService>(() => _i991.FormTemplateService(
      optionSetService: gh<_i158.OptionSetService>()));
  gh.factoryParam<_i756.FormInstanceServiceImpl, String, dynamic>((
    formId,
    _,
  ) =>
      _i756.FormInstanceServiceImpl(formId: formId));
  gh.factory<_i993.SessionRepository>(() => _i694.DefaultSessionRepository(
        storageAdapter: gh<_i216.CacheStorageAdapter>(),
        shouldClearBeforeSave: gh<bool>(instanceName: 'shouldClearBeforeSave'),
      ));
  gh.factory<_i584.SessionScopeInitializer>(() => _i584.SessionScopeInitializer(
      sessionRepository: gh<_i993.SessionRepository>()));
  gh.factory<_i656.AuthInterceptor>(() =>
      _i656.AuthInterceptor(sessionRepository: gh<_i993.SessionRepository>()));
  gh.factory<_i361.Dio>(() => thirdPartyServicesModule.dio(
        gh<_i656.AuthInterceptor>(),
        gh<_i361.CancelToken>(),
      ));
  gh.factory<_i64.AuthApi>(() => _i64.AuthApi(dioClient: gh<_i361.Dio>()));
  gh.lazySingleton<_i761.NetworkUtil>(
    () => _i761.NetworkUtil(dio: gh<_i361.Dio>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i8.HttpClient<dynamic>>(
      () => _i832.DefaultHttpAdapter(gh<_i361.Dio>()));
  gh.factory<_i658.SyncScheduler>(() => _i658.SyncScheduler(
        metadataRepo: gh<_i492.SyncMetadataRepository>(),
        connectivity: gh<_i761.NetworkUtil>(),
      ));
  gh.lazySingleton<_i261.AuthManager>(() => _i157.SdkAuthManager(
        sessionRepository: gh<_i993.SessionRepository>(),
        scopeInitializer: gh<_i584.SessionScopeInitializer>(),
        authApi: gh<_i64.AuthApi>(),
      ));
  gh.factory<_i432.SyncCoordinator>(() => _i432.SyncCoordinator(
        gh<_i492.SyncMetadataRepository>(),
        gh<_i658.SyncScheduler>(),
        gh<_i148.SyncExecutor>(),
      ));
  return getIt;
}

class _$SdkModule extends _i567.SdkModule {}

class _$ThirdPartyServicesModule extends _i427.ThirdPartyServicesModule {}
