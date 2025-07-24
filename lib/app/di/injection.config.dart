// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/core/auth/token_storage.dart' as _i765;
import 'package:d_sdk/core/http/http_client.dart' as _i8;
import 'package:d_sdk/core/secure_storage/storage_service.dart' as _i537;
import 'package:datarunmobile/app/di/sdk_module.dart' as _i567;
import 'package:datarunmobile/app/di/third_party_services.module.dart' as _i427;
import 'package:datarunmobile/core/auth/auth_api.dart' as _i64;
import 'package:datarunmobile/core/auth/auth_interceptor.dart' as _i656;
import 'package:datarunmobile/core/auth/auth_manager.dart' as _i261;
import 'package:datarunmobile/core/auth/auth_storage.dart' as _i324;
import 'package:datarunmobile/core/auth/token_refresher.dart' as _i48;
import 'package:datarunmobile/core/common/confirmation_service.dart' as _i18;
import 'package:datarunmobile/core/element_instance/data_value_repository.dart'
    as _i730;
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart'
    as _i595;
import 'package:datarunmobile/core/form/ui/factories/hint_provider_impl.dart'
    as _i1066;
import 'package:datarunmobile/core/http/default_http_adapter.dart' as _i832;
import 'package:datarunmobile/core/network/network_util.dart' as _i537;
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart'
    as _i658;
import 'package:datarunmobile/core/resources/resource_manager.provider.dart'
    as _i683;
import 'package:datarunmobile/core/services/user_session_manager.service.dart'
    as _i775;
import 'package:datarunmobile/core/sync/sync_coordinator.dart' as _i432;
import 'package:datarunmobile/core/sync/sync_executor.dart' as _i148;
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart' as _i492;
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart' as _i28;
import 'package:datarunmobile/core/sync/sync_scheduler.dart' as _i658;
import 'package:datarunmobile/core/sync_manager/sync_manager.dart' as _i602;
import 'package:datarunmobile/core/user_session/session_storage.dart' as _i139;
import 'package:datarunmobile/data/form_template_list_service.dart' as _i760;
import 'package:datarunmobile/data/form_template_service.dart' as _i991;
import 'package:datarunmobile/data/option_set_service.dart' as _i158;
import 'package:datarunmobile/features/assignment/application/assignment_service_impl.dart'
    as _i1027;
import 'package:datarunmobile/features/form_submission/application/device_info_service.dart'
    as _i1058;
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart'
    as _i54;
import 'package:datarunmobile/features/form_submission/application/element/rule_effect_state_factory.dart'
    as _i415;
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart'
    as _i342;
import 'package:datarunmobile/features/form_submission/application/form_instance_service_impl.dart'
    as _i756;
import 'package:datarunmobile/features/form_submission/application/form_metadata_service.dart'
    as _i747;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> setupGlobalDependencies(
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
  final sdkModule = _$SdkModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => thirdPartyServicesModule.prefs,
    preResolve: true,
  );
  gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyServicesModule.flutterSecureStorage);
  await gh.factoryAsync<_i1058.AndroidDeviceInfoService>(
    () => thirdPartyServicesModule.getAndroidDeviceInfo(),
    preResolve: true,
  );
  gh.factory<_i64.AuthApi>(() => _i64.AuthApi());
  gh.factory<_i730.DataValueRepository>(() => _i730.DataValueRepository());
  gh.factory<_i683.ResourceManager>(() => const _i683.ResourceManager());
  gh.factory<_i158.OptionSetService>(() => _i158.OptionSetService());
  gh.factory<_i1027.AssignmentServiceImpl>(
      () => _i1027.AssignmentServiceImpl());
  gh.factory<_i415.RuleEffectStateFactory>(
      () => _i415.RuleEffectStateFactory());
  gh.lazySingleton<_i18.ConfirmationService>(() => _i18.ConfirmationService());
  gh.lazySingleton<_i658.ConnectivityService>(
      () => _i658.ConnectivityService());
  gh.lazySingleton<_i28.SyncProgressNotifier>(
    () => _i28.SyncProgressNotifier(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i342.FieldContextRegistry>(
      () => _i342.FieldContextRegistry());
  gh.factory<_i775.UserSessionService>(
      () => _i775.UserSessionService(gh<_i460.SharedPreferences>()));
  gh.factory<_i139.SessionStorage>(
      () => _i139.SessionStorage(storage: gh<_i460.SharedPreferences>()));
  gh.factory<_i492.SyncMetadataRepository>(
      () => _i492.SyncMetadataRepository(gh<_i460.SharedPreferences>()));
  gh.factory<_i658.SyncScheduler>(() => _i658.SyncScheduler(
        metadataRepo: gh<_i492.SyncMetadataRepository>(),
        connectivity: gh<_i658.ConnectivityService>(),
      ));
  gh.factory<_i602.SyncManager>(
      () => _i602.SyncManager(gh<_i658.ConnectivityService>()));
  gh.factory<_i148.SyncExecutor>(() =>
      _i148.SyncExecutor(progressNotifier: gh<_i28.SyncProgressNotifier>()));
  gh.factory<_i595.HintProvider>(() => const _i1066.HintProviderImpl());
  gh.factory<_i537.StorageService>(() => sdkModule.getStorageService(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i460.SharedPreferences>(),
      ));
  gh.factoryParam<_i747.FormMetadataService, _i54.FormMetadata, dynamic>((
    formMetadata,
    _,
  ) =>
      _i747.FormMetadataService(
        deviceInfoService: gh<_i1058.AndroidDeviceInfoService>(),
        formMetadata: formMetadata,
      ));
  gh.factory<_i760.FormTemplateListService>(() => _i760.FormTemplateListService(
      optionSetService: gh<_i158.OptionSetService>()));
  gh.factory<_i991.FormTemplateService>(() => _i991.FormTemplateService(
      optionSetService: gh<_i158.OptionSetService>()));
  gh.factoryParam<_i756.FormInstanceServiceImpl, String, dynamic>((
    formId,
    _,
  ) =>
      _i756.FormInstanceServiceImpl(formId: formId));
  gh.factory<_i765.TokenStorage>(
      () => sdkModule.getTokenStorage(gh<_i537.StorageService>()));
  gh.factory<_i324.AuthStorage>(() => _i324.AuthStorage(
        tokenStorage: gh<_i765.TokenStorage>(),
        sessionStorage: gh<_i139.SessionStorage>(),
        prefs: gh<_i460.SharedPreferences>(),
      ));
  gh.factory<_i432.SyncCoordinator>(() => _i432.SyncCoordinator(
        gh<_i492.SyncMetadataRepository>(),
        gh<_i658.SyncScheduler>(),
        gh<_i148.SyncExecutor>(),
      ));
  gh.factory<_i656.AuthInterceptor>(
      () => _i656.AuthInterceptor(authStorage: gh<_i324.AuthStorage>()));
  gh.factory<_i361.Dio>(
      () => thirdPartyServicesModule.dio(gh<_i656.AuthInterceptor>()));
  gh.factory<_i48.TokenRefresher>(
      () => _i48.TokenRefresher(gh<_i765.TokenStorage>()));
  gh.lazySingleton<_i261.AuthManager>(() => _i261.AuthManager(
        authStorage: gh<_i324.AuthStorage>(),
        authApi: gh<_i64.AuthApi>(),
      ));
  gh.lazySingleton<_i537.NetworkUtil>(
    () => _i537.NetworkUtil(dio: gh<_i361.Dio>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i8.HttpClient<dynamic>>(
      () => _i832.DefaultHttpAdapter(gh<_i361.Dio>()));
  return getIt;
}

class _$ThirdPartyServicesModule extends _i427.ThirdPartyServicesModule {}

class _$SdkModule extends _i567.SdkModule {}
