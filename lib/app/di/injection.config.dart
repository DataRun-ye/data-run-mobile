// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart'
    as _i587;
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart'
    as _i381;
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart'
    as _i603;
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart'
    as _i731;
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart'
    as _i1042;
import 'package:datarunmobile/app/di/third_party_services.module.dart' as _i427;
import 'package:datarunmobile/core/element_instance/data_value_repository.dart'
    as _i730;
import 'package:datarunmobile/core/form/data/display_name_provider.dart'
    as _i1030;
import 'package:datarunmobile/core/form/data/display_name_provider_impl.dart'
    as _i971;
import 'package:datarunmobile/core/form/data/form_command_handler.dart'
    as _i372;
import 'package:datarunmobile/core/form/data/form_repository.dart' as _i16;
import 'package:datarunmobile/core/form/data/form_value_store.dart' as _i520;
import 'package:datarunmobile/core/form/data/map_field_value_to_user.dart'
    as _i624;
import 'package:datarunmobile/core/form/data/metadata/option_set_configuration.dart'
    as _i362;
import 'package:datarunmobile/core/form/data/metadata/org_unit_configuration.dart'
    as _i406;
import 'package:datarunmobile/core/form/data/search_option_set_option.dart'
    as _i653;
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart'
    as _i595;
import 'package:datarunmobile/core/form/ui/factories/hint_provider_impl.dart'
    as _i1066;
import 'package:datarunmobile/core/form/ui/field_view_model_factory.dart'
    as _i1067;
import 'package:datarunmobile/core/form/ui/field_view_model_factory_impl.dart'
    as _i835;
import 'package:datarunmobile/core/resources/resource_manager.provider.dart'
    as _i683;
import 'package:datarunmobile/core/services/auth.service.dart' as _i409;
import 'package:datarunmobile/core/services/user_session_manager.service.dart'
    as _i775;
import 'package:datarunmobile/data/repository/d_activity_local.repository.dart'
    as _i684;
import 'package:datarunmobile/data/repository/d_assignment_local.repository.dart'
    as _i158;
import 'package:datarunmobile/data/repository/d_form_template_local.repository.dart'
    as _i298;
import 'package:datarunmobile/data/repository/d_org_unit_local.repository.dart'
    as _i612;
import 'package:datarunmobile/data/repository/d_team_local.repository.dart'
    as _i231;
import 'package:datarunmobile/data/repository/identifiable.repository.dart'
    as _i236;
import 'package:datarunmobile/data/service/authentication_service.dart'
    as _i1049;
import 'package:datarunmobile/data/service/d_authentication.service.dart'
    as _i443;
import 'package:datarunmobile/data/use_case/activity/assignment_detail.service.dart'
    as _i359;
import 'package:datarunmobile/data_run/screens/login_screen/reactive_form_state/login_reactive_form.viewmodel.dart'
    as _i676;
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
  gh.factory<_i730.DataValueRepository>(() => _i730.DataValueRepository());
  gh.factory<_i362.OptionSetConfigurations>(
      () => const _i362.OptionSetConfigurations());
  gh.factory<_i406.OrgUnitConfiguration>(
      () => const _i406.OrgUnitConfiguration());
  gh.factory<_i653.SearchOptionSetOption>(
      () => const _i653.SearchOptionSetOption());
  gh.factory<_i683.ResourceManager>(() => const _i683.ResourceManager());
  gh.lazySingleton<_i1055.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i1055.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i1055.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i1055.BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.factory<_i775.UserSessionService>(
      () => _i775.UserSessionService(gh<_i460.SharedPreferences>()));
  gh.factory<_i409.AuthService>(() => _i409.AuthService(
        gh<_i775.UserSessionService>(),
        gh<_i1055.NavigationService>(),
      ));
  gh.factory<_i236.IdentifiableRepository<_i603.Assignment>>(
      () => _i158.DAssignmentListLocalRepository());
  gh.lazySingleton<_i676.LoginReactiveFormViewModel>(
      () => _i676.LoginReactiveFormViewModel(
            gh<_i409.AuthService>(),
            gh<_i775.UserSessionService>(),
            gh<_i1055.NavigationService>(),
          ));
  gh.factory<_i236.IdentifiableRepository<_i381.Activity>>(
      () => _i684.DActivityLocalRepository());
  gh.factory<_i236.IdentifiableRepository<_i587.FormVersion>>(
      () => _i298.DFormTemplateLocalRepository());
  gh.factoryParam<_i520.FormValueStore, String, dynamic>((
    recordUid,
    _,
  ) =>
      _i520.FormValueStore(recordUid: recordUid));
  gh.factory<_i236.IdentifiableRepository<_i731.OrgUnit>>(
      () => _i612.DOrgUnitLocalRepository());
  gh.factory<_i1049.AuthenticationService>(
      () => _i443.DAuthenticationService(gh<_i775.UserSessionService>()));
  gh.factory<_i236.IdentifiableRepository<_i1042.Team>>(
      () => _i231.DTeamLocalRepository());
  gh.factory<_i624.MapFieldValueToUser>(() => _i624.MapFieldValueToUser(
        resources: gh<_i683.ResourceManager>(),
        repository: gh<_i730.DataValueRepository>(),
      ));
  gh.factory<_i595.HintProvider>(() => const _i1066.HintProviderImpl());
  gh.factory<_i1030.DisplayNameProvider>(() => _i971.DisplayNameProviderImpl(
        gh<_i362.OptionSetConfigurations>(),
        gh<_i406.OrgUnitConfiguration>(),
      ));
  gh.factoryParam<_i1067.FieldViewModelFactory, bool?, dynamic>((
    noMandatoryFields,
    _,
  ) =>
      _i835.FieldViewModelFactoryImpl(
        noMandatoryFields: noMandatoryFields,
        hintProvider: gh<_i595.HintProvider>(),
        displayNameProvider: gh<_i1030.DisplayNameProvider>(),
      ));
  gh.factory<_i372.FormCommandHandler>(
      () => _i372.FormCommandHandler(repository: gh<_i16.FormRepository>()));
  gh.factory<_i359.AssignmentDetailService>(() => _i359.AssignmentDetailService(
      gh<_i236.IdentifiableRepository<_i603.Assignment>>()));
  return getIt;
}

class _$ThirdPartyServicesModule extends _i427.ThirdPartyServicesModule {
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
