import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
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
