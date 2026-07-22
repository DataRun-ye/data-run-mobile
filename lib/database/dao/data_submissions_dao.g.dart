// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_submissions_dao.dart';

// ignore_for_file: type=lint
mixin _$DataInstancesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FormTemplatesTable get formTemplates => attachedDatabase.formTemplates;
  $FormTemplateVersionsTable get formTemplateVersions =>
      attachedDatabase.formTemplateVersions;
  $ProjectsTable get projects => attachedDatabase.projects;
  $ActivitiesTable get activities => attachedDatabase.activities;
  $TeamsTable get teams => attachedDatabase.teams;
  $OrgUnitsTable get orgUnits => attachedDatabase.orgUnits;
  $AssignmentsTable get assignments => attachedDatabase.assignments;
  $DataInstancesTable get dataInstances => attachedDatabase.dataInstances;
  DataInstancesDaoManager get managers => DataInstancesDaoManager(this);
}

class DataInstancesDaoManager {
  final _$DataInstancesDaoMixin _db;
  DataInstancesDaoManager(this._db);
  $$FormTemplatesTableTableManager get formTemplates =>
      $$FormTemplatesTableTableManager(_db.attachedDatabase, _db.formTemplates);
  $$FormTemplateVersionsTableTableManager get formTemplateVersions =>
      $$FormTemplateVersionsTableTableManager(
          _db.attachedDatabase, _db.formTemplateVersions);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db.attachedDatabase, _db.activities);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$OrgUnitsTableTableManager get orgUnits =>
      $$OrgUnitsTableTableManager(_db.attachedDatabase, _db.orgUnits);
  $$AssignmentsTableTableManager get assignments =>
      $$AssignmentsTableTableManager(_db.attachedDatabase, _db.assignments);
  $$DataInstancesTableTableManager get dataInstances =>
      $$DataInstancesTableTableManager(_db.attachedDatabase, _db.dataInstances);
}
