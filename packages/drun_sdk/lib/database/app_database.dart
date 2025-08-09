import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Users,
  OrgUnits,
  OuLevels,
  Projects,
  Activities,
  Teams,
  ManagedTeams,
  Assignments,
  AssignmentForms,
  FormTemplates,
  FormTemplateVersions,
  MetadataSubmissions,
  RepeatInstances,
  DataValues,
  DataElements,
  DataOptionSets,
  DataOptions,
  DataInstances,
  FormTemplateVersions,
  UserFormPermissions,
  SyncSummaries
], daos: [
  UsersDao,
  OrgUnitsDao,
  ActivitiesDao,
  TeamsDao,
  AssignmentsDao,
  FormTemplatesDao,
  DataElementsDao,
  FormTemplateVersionsDao,
  DataOptionSetsDao,
  DataOptionsDao,
  DataInstancesDao,
  DataValuesDao,
  RepeatInstancesDao,
  SyncSummariesDao,
  MetadataSubmissionsDao,
  OuLevelsDao,
  ProjectsDao,
  UserFormPermissionsDao
])
class AppDatabase extends _$AppDatabase {
  String userId;

  AppDatabase({required QueryExecutor executor, required this.userId})
      : super(executor);

  @override
  int get schemaVersion => 1;
}
