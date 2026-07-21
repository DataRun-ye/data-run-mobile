// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_values_dao.dart';

// ignore_for_file: type=lint
mixin _$DataValuesDaoMixin on DatabaseAccessor<AppDatabase> {
  $DataOptionSetsTable get dataOptionSets => attachedDatabase.dataOptionSets;
  $DataElementsTable get dataElements => attachedDatabase.dataElements;
  $FormTemplatesTable get formTemplates => attachedDatabase.formTemplates;
  $FormTemplateVersionsTable get formTemplateVersions =>
      attachedDatabase.formTemplateVersions;
  $ProjectsTable get projects => attachedDatabase.projects;
  $ActivitiesTable get activities => attachedDatabase.activities;
  $TeamsTable get teams => attachedDatabase.teams;
  $OrgUnitsTable get orgUnits => attachedDatabase.orgUnits;
  $AssignmentsTable get assignments => attachedDatabase.assignments;
  $DataInstancesTable get dataInstances => attachedDatabase.dataInstances;
  $DataValuesTable get dataValues => attachedDatabase.dataValues;
  DataValuesDaoManager get managers => DataValuesDaoManager(this);
}

class DataValuesDaoManager {
  final _$DataValuesDaoMixin _db;
  DataValuesDaoManager(this._db);
  $$DataOptionSetsTableTableManager get dataOptionSets =>
      $$DataOptionSetsTableTableManager(
          _db.attachedDatabase, _db.dataOptionSets);
  $$DataElementsTableTableManager get dataElements =>
      $$DataElementsTableTableManager(_db.attachedDatabase, _db.dataElements);
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
  $$DataValuesTableTableManager get dataValues =>
      $$DataValuesTableTableManager(_db.attachedDatabase, _db.dataValues);
}
