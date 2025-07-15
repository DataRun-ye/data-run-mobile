import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_extension.dart';
import 'package:d_sdk/database/tables/projects.table.dart';
import 'package:drift/drift.dart';

part 'projects_dao.g.dart';

@DriftAccessor(tables: [Projects])
class ProjectsDao extends DatabaseAccessor<AppDatabase>
    with _$ProjectsDaoMixin, BaseExtension<Project> {
  ProjectsDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'projects';

  @override
  Project fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      Project.fromJson(data, serializer: serializer);

  @override
  TableInfo<TableInfo<Table, Project>, Project> get table => projects;
}
