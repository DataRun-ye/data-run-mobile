// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $ActivitiesTable get activities => attachedDatabase.activities;
  $TeamsTable get teams => attachedDatabase.teams;
  TeamsDaoManager get managers => TeamsDaoManager(this);
}

class TeamsDaoManager {
  final _$TeamsDaoMixin _db;
  TeamsDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db.attachedDatabase, _db.activities);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
}
