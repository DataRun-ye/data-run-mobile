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

// AbAstractDatasource<[^>]+>
/// initializes the registration of initActiveSessionScope-scope dependencies inside of GetIt
_i174.GetIt registerUserSdkDeps(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );

  gh.factory<_i822.UserDatasource>(() => _i822.UserDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i589.ProjectDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i434.ActivityDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i790.OuLevelDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i185.OrgUnitDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i756.OptionSetDatasource());
  gh.factory<_i277.AbstractDatasource>(
      () => _i827.DataElementDatasource());
  gh.factory<_i277.AbstractDatasource>(
      () => _i569.DataFormTemplateDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i143.TeamDatasource());
  gh.factory<_i277.AbstractDatasource>(
      () => _i588.UserFormAccessesDatasource());
  gh.factory<_i277.AbstractDatasource>(() => _i90.AssignmentDatasource());
  gh.factory<_i277.AbstractDatasource>(
      () => _i646.DataInstanceDatasource());
  gh.factory<_i277.AbstractDatasource>(
      () => _i1071.MetadataSubmissionDatasource());

  return getIt;
}
