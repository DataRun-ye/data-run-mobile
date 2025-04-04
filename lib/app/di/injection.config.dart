// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart'
    as _i727;
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart'
    as _i587;
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart'
    as _i381;
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart'
    as _i603;
import 'package:d2_remote/modules/metadatarun/metadatarun.dart' as _i813;
import 'package:datarunmobile/app/di/third_party_services.module.dart' as _i427;
import 'package:datarunmobile/commons/identifiable.repository.dart' as _i710;
import 'package:datarunmobile/core/services/auth.service.dart' as _i409;
import 'package:datarunmobile/core/services/user_session_manager.service.dart'
    as _i775;
import 'package:datarunmobile/data/activity/model/activity_detail.service.dart'
    as _i199;
import 'package:datarunmobile/data/activity/model/activity_list.service.dart'
    as _i434;
import 'package:datarunmobile/data/activity/repository/d_activity_local.repository.dart'
    as _i999;
import 'package:datarunmobile/data/assignment/model/assignment_list.service.dart'
    as _i213;
import 'package:datarunmobile/data/assignment/model/assignment_resource_service.dart'
    as _i817;
import 'package:datarunmobile/data/assignment/model/filter_query_service.dart'
    as _i832;
import 'package:datarunmobile/data/assignment/model/timeline_service.dart'
    as _i871;
import 'package:datarunmobile/data/assignment/repository/d_assignment_local.repository.dart'
    as _i74;
import 'package:datarunmobile/data/form/model/form_list.service.dart' as _i729;
import 'package:datarunmobile/data/form/repository/d_form_version_local.repository.dart'
    as _i594;
import 'package:datarunmobile/data/form_submission/model/form_submission_list.service.dart'
    as _i736;
import 'package:datarunmobile/data/form_submission/repository/d_submission_local.repository.dart'
    as _i249;
import 'package:datarunmobile/data/org_unit/repository/d_org_unit_local.repository.dart'
    as _i318;
import 'package:datarunmobile/data/service/authentication_service.dart'
    as _i1049;
import 'package:datarunmobile/data/service/d_authentication.service.dart'
    as _i443;
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator.dart'
    as _i899;
import 'package:datarunmobile/data/team/repository/d_team_local.repository.dart'
    as _i937;
import 'package:datarunmobile/data_run/screens/login_screen/reactive_form_state/login_reactive_form.viewmodel.dart'
    as _i676;
import 'package:datarunmobile/presentation/assignment/assignment_page.service.dart'
    as _i152;
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
  gh.lazySingleton<_i832.FilterQueryService>(() => _i832.FilterQueryService());
  gh.factory<_i775.UserSessionService>(
      () => _i775.UserSessionService(gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i710.DRunBaseRepository<_i603.Assignment>>(
      () => _i74.DAssignmentListLocalRepository());
  gh.factory<_i409.AuthService>(() => _i409.AuthService(
        gh<_i775.UserSessionService>(),
        gh<_i1055.NavigationService>(),
      ));
  gh.lazySingleton<_i676.LoginReactiveFormViewModel>(
      () => _i676.LoginReactiveFormViewModel(
            gh<_i409.AuthService>(),
            gh<_i775.UserSessionService>(),
            gh<_i1055.NavigationService>(),
          ));
  gh.lazySingleton<_i710.DRunBaseRepository<_i813.OrgUnit>>(
      () => _i318.DOrgUnitLocalRepository());
  gh.lazySingleton<_i710.DRunBaseRepository<_i587.FormVersion>>(
      () => _i594.DFormTemplateLocalRepository());
  gh.factory<_i1049.AuthenticationService>(
      () => _i443.DAuthenticationService(gh<_i775.UserSessionService>()));
  gh.lazySingleton<_i710.DRunBaseRepository<_i381.Activity>>(
      () => _i999.DActivityLocalRepository());
  gh.lazySingleton<_i710.DRunBaseRepository<_i727.DataFormSubmission>>(
      () => _i249.SubmissionListLocalRepository());
  gh.lazySingleton<_i710.DRunBaseRepository<_i813.Team>>(
      () => _i937.DTeamLocalRepository());
  gh.factory<_i434.ActivityListService>(() => _i434.ActivityListService(
        gh<_i710.DRunBaseRepository<_i813.Activity>>(),
        gh<_i710.DRunBaseRepository<_i813.Assignment>>(),
        gh<_i710.DRunBaseRepository<_i813.Team>>(),
      ));
  gh.lazySingleton<_i199.ActivityDetailService>(
      () => _i199.ActivityDetailService(
            gh<_i710.DRunBaseRepository<_i813.Activity>>(),
            gh<_i710.DRunBaseRepository<_i813.Assignment>>(),
            gh<_i710.DRunBaseRepository<_i813.Team>>(),
          ));
  gh.lazySingleton<_i213.AssignmentListService>(
      () => _i213.AssignmentListService(
            gh<_i710.DRunBaseRepository<_i813.Assignment>>(),
            gh<_i710.DRunBaseRepository<_i813.Activity>>(),
            gh<_i710.DRunBaseRepository<_i813.OrgUnit>>(),
            gh<_i710.DRunBaseRepository<_i813.Team>>(),
          ));
  gh.factoryParam<_i899.SyncStatusAggregator, _i899.AggregationLevel?, dynamic>(
      (
    level,
    _,
  ) =>
          _i899.SyncStatusAggregator.create(level: level));
  gh.lazySingleton<_i817.AssignmentResourceService>(() =>
      _i817.AssignmentResourceService(
          gh<_i710.DRunBaseRepository<_i603.Assignment>>()));
  gh.lazySingleton<_i871.TimelineService>(() =>
      _i871.TimelineService(gh<_i710.DRunBaseRepository<_i603.Assignment>>()));
  gh.lazySingleton<_i152.AssignmentPageService>(() =>
      _i152.AssignmentPageService(
          assignmentListService: gh<_i213.AssignmentListService>()));
  gh.factory<_i736.FormSubmissionListService>(
      () => _i736.FormSubmissionListService(
            gh<_i710.DRunBaseRepository<_i727.DataFormSubmission>>(),
            gh<_i710.DRunBaseRepository<_i813.Assignment>>(),
            gh<_i710.DRunBaseRepository<_i813.Activity>>(),
            gh<_i710.DRunBaseRepository<_i813.OrgUnit>>(),
            gh<_i710.DRunBaseRepository<_i813.Team>>(),
            gh<_i710.DRunBaseRepository<_i587.FormVersion>>(),
          ));
  gh.lazySingleton<_i729.FormListService>(() => _i729.FormListService(
        gh<_i710.DRunBaseRepository<_i587.FormVersion>>(),
        gh<_i710.DRunBaseRepository<_i813.Team>>(),
      ));
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
