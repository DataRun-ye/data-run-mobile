import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.project)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class ProjectDatasource extends BaseDataSource<$ProjectsTable, Project>
    implements MetaDataSource<Project> {
  @override
  String get resourceName => 'projects';

  @override
  Project fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      Project.fromJson(data, serializer: serializer);

  @override
  $ProjectsTable get table => db.projects;
}
