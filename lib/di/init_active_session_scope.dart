import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/datasource/abstract_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/activity_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/assignment_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/form_template_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/option_set_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/org_unit_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/ou_level_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/project_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/reference_entry_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/team_datasource.dart';
import 'package:datarunmobile/datasource/remote_data_sources/user_form_permission_datasource.dart';
import 'package:get_it/get_it.dart';

GetIt registerUserConfigurationDatasources(GetIt getIt) {
  getIt.registerFactory<AbstractDatasource<dynamic>>(ProjectDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(ActivityDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(OuLevelDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(OrgUnitDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(OptionSetDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(
    DataFormTemplateDatasource.new,
  );
  getIt.registerFactory<AbstractDatasource<dynamic>>(TeamDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(
    UserFormAccessesDatasource.new,
  );
  getIt.registerFactory<AbstractDatasource<dynamic>>(AssignmentDatasource.new);
  getIt.registerFactory<AbstractDatasource<dynamic>>(
    () => ReferenceEntryDatasource(
      getIt<AppDatabase>(),
      getIt<HttpClient<dynamic>>(),
    ),
  );

  return getIt;
}
