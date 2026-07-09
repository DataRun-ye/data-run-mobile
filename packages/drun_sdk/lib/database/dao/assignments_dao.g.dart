// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignments_dao.dart';

// ignore_for_file: type=lint
mixin _$AssignmentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $ActivitiesTable get activities => attachedDatabase.activities;
  $TeamsTable get teams => attachedDatabase.teams;
  $OrgUnitsTable get orgUnits => attachedDatabase.orgUnits;
  $AssignmentsTable get assignments => attachedDatabase.assignments;
  AssignmentsDaoManager get managers => AssignmentsDaoManager(this);
}

class AssignmentsDaoManager {
  final _$AssignmentsDaoMixin _db;
  AssignmentsDaoManager(this._db);
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
}
