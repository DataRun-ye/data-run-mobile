// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/core/util/user_file_manager.dart' as _i629;
import 'package:d_sdk/database/database.dart' as _i210;
import 'package:d_sdk/database/db_factory/database_factory.dart' as _i320;
import 'package:d_sdk/datasource/datasource.dart' as _i277;
import 'package:d_sdk/datasource/remote_data_sources/activity_datasource.dart'
    as _i434;
import 'package:d_sdk/datasource/remote_data_sources/assignment_datasource.dart'
    as _i90;
import 'package:d_sdk/datasource/remote_data_sources/data_element_datasource.dart'
    as _i827;
import 'package:d_sdk/datasource/remote_data_sources/data_submission_datasource.dart'
    as _i646;
import 'package:d_sdk/datasource/remote_data_sources/form_template_datasource.dart'
    as _i569;
import 'package:d_sdk/datasource/remote_data_sources/metadata_submission_datasource.dart'
    as _i1071;
import 'package:d_sdk/datasource/remote_data_sources/option_set_datasource.dart'
    as _i756;
import 'package:d_sdk/datasource/remote_data_sources/org_unit_datasource.dart'
    as _i185;
import 'package:d_sdk/datasource/remote_data_sources/ou_level_datasource.dart'
    as _i790;
import 'package:d_sdk/datasource/remote_data_sources/project_datasource.dart'
    as _i589;
import 'package:d_sdk/datasource/remote_data_sources/team_datasource.dart'
    as _i143;
import 'package:d_sdk/datasource/remote_data_sources/user_datasource.dart'
    as _i822;
import 'package:d_sdk/datasource/remote_data_sources/user_form_permission_datasource.dart'
    as _i588;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initSdkGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i320.DatabaseFactory>(
    () => _i320.DatabaseFactory(),
    dispose: (i) => i.close(),
  );
  gh.factoryParam<_i629.UserFileManager, String, dynamic>((
    userId,
    _,
  ) =>
      _i629.UserFileManager(userId));
  return getIt;
}

// initializes the registration of activeSessionContext-scope dependencies inside of GetIt
_i174.GetIt initActiveSessionContextScope(
  _i174.GetIt getIt, {
  _i174.ScopeDisposeFunc? dispose,
}) {
  return _i526.GetItHelper(getIt).initScope(
    'activeSessionContext',
    dispose: dispose,
    init: (_i526.GetItHelper gh) {
      gh.factory<_i822.UserDatasource>(() => _i822.UserDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.Project>>(
          () => _i589.ProjectDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.Activity>>(
          () => _i434.ActivityDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.OuLevel>>(
          () => _i790.OuLevelDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.OrgUnit>>(
          () => _i185.OrgUnitDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.DataOptionSet>>(
          () => _i756.OptionSetDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.DataElement>>(
          () => _i827.DataElementDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.FormTemplate>>(
          () => _i569.DataFormTemplateDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.Team>>(
          () => _i143.TeamDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.UserFormPermission>>(
          () => _i588.UserFormAccessesDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.Assignment>>(
          () => _i90.AssignmentDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.DataInstance>>(
          () => _i646.DataInstanceDatasource());
      gh.factory<_i277.AbstractDatasource<_i210.MetadataSubmission>>(
          () => _i1071.MetadataSubmissionDatasource());
    },
  );
}
