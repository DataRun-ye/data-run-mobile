import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/datasource/base_datasource.dart';
import 'package:datarunmobile/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

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
