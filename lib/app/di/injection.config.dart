// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:datarunmobile/app/di/sdk_module.dart' as _i567;
import 'package:datarunmobile/app/di/third_party_services.module.dart' as _i427;
import 'package:datarunmobile/core/auth/auth_api.dart' as _i64;
import 'package:datarunmobile/core/auth/auth_interceptor.dart' as _i656;
import 'package:datarunmobile/core/auth/auth_manager.dart' as _i261;
import 'package:datarunmobile/core/auth/auth_storage.dart' as _i324;
import 'package:datarunmobile/core/auth/token_refresher.dart' as _i48;
import 'package:datarunmobile/core/auth/token_storage.dart' as _i702;
import 'package:datarunmobile/core/common/confirmation_service.dart' as _i18;
import 'package:datarunmobile/core/element_instance/display_value_lookup.dart'
    as _i735;
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart'
    as _i595;
import 'package:datarunmobile/core/form/ui/factories/hint_provider_impl.dart'
    as _i1066;
import 'package:datarunmobile/core/http/default_http_adapter.dart' as _i832;
import 'package:datarunmobile/core/http/http_client.dart' as _i680;
import 'package:datarunmobile/core/network/network_util.dart' as _i537;
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart'
    as _i658;
import 'package:datarunmobile/core/secure_storage/storage_service.dart'
    as _i550;
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart' as _i492;
import 'package:datarunmobile/core/sync/sync_scheduler.dart' as _i658;
import 'package:datarunmobile/core/sync_manager/sync_manager.dart' as _i602;
import 'package:datarunmobile/core/user_session/session_storage.dart' as _i139;
import 'package:datarunmobile/data/form_template_list_service.dart' as _i760;
import 'package:datarunmobile/data/option_set_service.dart' as _i158;
import 'package:datarunmobile/features/form/application/map_value_to_display.dart'
    as _i244;
import 'package:datarunmobile/features/form_submission/application/device_info_service.dart'
    as _i1058;
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart'
    as _i54;
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
  gh.factory<_i735.DisplayValueLookup>(() => _i735.DisplayValueLookup());
  gh.factory<_i602.SyncManager>(() => _i602.SyncManager());
  gh.factory<_i158.OptionSetService>(() => _i158.OptionSetService());
  gh.lazySingleton<_i18.ConfirmationService>(() => _i18.ConfirmationService());
  gh.lazySingleton<_i658.ConnectivityService>(
      () => _i658.ConnectivityService());
  gh.factory<_i550.StorageService>(() => sdkModule.getStorageService(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i460.SharedPreferences>(),
      ));
  gh.factory<_i760.FormTemplateListService>(() => _i760.FormTemplateListService(
      optionSetService: gh<_i158.OptionSetService>()));
  gh.factory<_i244.MapValueToDisplay>(
      () => _i244.MapValueToDisplay(lookup: gh<_i735.DisplayValueLookup>()));
  gh.factoryParam<_i747.FormMetadataService, _i54.FormMetadata, dynamic>((
    formMetadata,
    _,
  ) =>
      _i747.FormMetadataService(
        deviceInfoService: gh<_i1058.AndroidDeviceInfoService>(),
        formMetadata: formMetadata,
      ));
  gh.factory<_i595.HintProvider>(() => const _i1066.HintProviderImpl());
  gh.factory<_i702.TokenStorage>(
      () => sdkModule.getTokenStorage(gh<_i550.StorageService>()));
  gh.factory<_i492.SyncMetadataRepository>(
      () => _i492.SyncMetadataRepository(gh<_i460.SharedPreferences>()));
  gh.factory<_i139.SessionStorage>(
      () => _i139.SessionStorage(storage: gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i48.TokenRefresher>(() => _i48.TokenRefresher(
        gh<_i702.TokenStorage>(),
        gh<_i64.AuthApi>(),
      ));
  gh.factory<_i324.AuthStorage>(() => _i324.AuthStorage(
        tokenStorage: gh<_i702.TokenStorage>(),
        sessionStorage: gh<_i139.SessionStorage>(),
        prefs: gh<_i460.SharedPreferences>(),
      ));
  gh.factory<_i658.SyncScheduler>(() => _i658.SyncScheduler(
        metadataRepo: gh<_i492.SyncMetadataRepository>(),
        connectivity: gh<_i658.ConnectivityService>(),
      ));
  gh.lazySingleton<_i261.AuthManager>(() => _i261.AuthManager(
        authStorage: gh<_i324.AuthStorage>(),
        authApi: gh<_i64.AuthApi>(),
      ));
  gh.factory<_i656.AuthInterceptor>(() => _i656.AuthInterceptor(
        authStorage: gh<_i324.AuthStorage>(),
        tokenRefresher: gh<_i48.TokenRefresher>(),
      ));
  gh.factory<_i361.Dio>(
      () => thirdPartyServicesModule.dio(gh<_i656.AuthInterceptor>()));
  gh.lazySingleton<_i537.NetworkUtil>(
    () => _i537.NetworkUtil(dio: gh<_i361.Dio>()),
    dispose: (i) => i.dispose(),
  );
  gh.factory<_i680.HttpClient<dynamic>>(
      () => _i832.DefaultHttpAdapter(gh<_i361.Dio>()));
  return getIt;
}

class _$ThirdPartyServicesModule extends _i427.ThirdPartyServicesModule {}

class _$SdkModule extends _i567.SdkModule {}
