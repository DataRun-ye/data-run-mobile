import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/database/converters/converters.dart';
import 'package:datarunmobile/database/dao/dao.dart';
import 'package:datarunmobile/database/shared/assignment_status.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_permission.dart';
import 'package:datarunmobile/database/shared/metadata_resource_type.dart';
import 'package:datarunmobile/database/shared/scanned_code_properties.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/sync_error.dart';
import 'package:datarunmobile/database/shared/translations.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/database/tables/tables.dart';
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
  DataElements,
  DataOptionSets,
  DataOptions,
  DataInstances,
  FormTemplateVersions,
  UserFormPermissions,
  SyncSummaries,
], daos: [
  AssignmentsDao,
  FormTemplateVersionsDao,
  DataInstancesDao,
  SyncSummariesDao,
])
class AppDatabase extends _$AppDatabase {
  String userId;

  AppDatabase({required QueryExecutor executor, required this.userId})
      : super(executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(formTemplateVersions,
                formTemplateVersions.options as GeneratedColumn);
          }
          if (from < 3) {
            await m.addColumn(
                dataOptions, dataOptions.deletedAt as GeneratedColumn);
            await m.addColumn(
                dataOptionSets, dataOptionSets.deletedAt as GeneratedColumn);
          }
          if (from < 4) {
            await m.addColumn(syncSummaries,
                syncSummaries.lastSuccessfulSync as GeneratedColumn);
          }
          if (from < 5) {
            await m.deleteTable('data_values');
            await m.deleteTable('repeat_instances');
          }
        },
      );
}
