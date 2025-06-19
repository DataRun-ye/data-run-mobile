// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

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
import 'package:datarunmobile/core/form/data/form_value_store.dart' as _i520;
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
  gh.factory<_i236.IdentifiableRepository<_i731.OrgUnit>>(
      () => _i612.DOrgUnitLocalRepository());
  gh.factory<_i1049.AuthenticationService>(
      () => _i443.DAuthenticationService(gh<_i775.UserSessionService>()));
  gh.factory<_i236.IdentifiableRepository<_i1042.Team>>(
      () => _i231.DTeamLocalRepository());
  gh.factory<_i520.FormValueStore>(
      () => _i520.FormValueStore(recordUidFuture: gh<_i687.Future<String>>()));
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
