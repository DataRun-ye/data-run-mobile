// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:datarun/app/di/third_party_services_module.dart' as _i228;
import 'package:datarun/core/auth/auth_service.dart' as _i950;
import 'package:datarun/core/auth/user_session_manager.dart' as _i307;
import 'package:datarun/data_run/screens/login_screen/reactive_form_state/login_reactive_form_model.dart'
    as _i532;
import 'package:datarun/services/authentication_service.dart' as _i54;
import 'package:datarun/services/d_authentication_service.dart' as _i149;
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
  gh.lazySingleton<_i1055.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i1055.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i1055.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i1055.BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.factory<_i307.UserSessionManager>(
      () => _i307.UserSessionManager(gh<_i460.SharedPreferences>()));
  gh.factory<_i54.AuthenticationService>(
      () => _i149.DAuthenticationService(gh<_i307.UserSessionManager>()));
  gh.factory<_i950.AuthService>(() => _i950.AuthService(
        gh<_i307.UserSessionManager>(),
        gh<_i1055.NavigationService>(),
      ));
  gh.lazySingleton<_i532.LoginReactiveFormModel>(
      () => _i532.LoginReactiveFormModel(
            gh<_i950.AuthService>(),
            gh<_i307.UserSessionManager>(),
          ));
  return getIt;
}

class _$ThirdPartyServicesModule extends _i228.ThirdPartyServicesModule {
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
