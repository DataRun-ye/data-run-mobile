import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:ulid/ulid.dart';

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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (Migrator m, int from, int to) async {

          //----------------------------------------------------
          // If you prefer SQL, you can also use
          // `await customStatement('ALTER TABLE form_template_versions ADD COLUMN options TEXT;');`
          // — but prefer m.addColumn(...) since it uses generated column
          // definition and is less error prone.
          if (from < 2) {
            // add the new nullable column in a safe, Drift-native way
            await m.addColumn(formTemplateVersions,
                formTemplateVersions.options as GeneratedColumn);
          }
          // or without the cast:
          // if (from < 2) {
          //   final col = formTemplateVersions.$columns
          //       .firstWhere((c) => c.$name == 'options'); // $name is the column name
          //   await m.addColumn(formTemplateVersions, col);
          // }
          //----------------------------------------------------
          if (from < 3) {
            // add the new nullable column in a safe, Drift-native way
            await m.addColumn(dataOptions,
                dataOptions.deletedAt as GeneratedColumn);
            await m.addColumn(dataOptionSets,
                dataOptionSets.deletedAt as GeneratedColumn);
          }
          //----------------------------------------------------

          // future upgrades can be chained here...
        },

        // Optional but useful if you ship a prepopulated DB
        beforeOpen: (details) async {
          if (details.wasCreated) {
            // populate initial seed data if needed
          }
        },
      );
}
