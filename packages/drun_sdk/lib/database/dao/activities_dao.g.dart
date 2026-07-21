// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_dao.dart';

// ignore_for_file: type=lint
mixin _$ActivitiesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $ActivitiesTable get activities => attachedDatabase.activities;
  ActivitiesDaoManager get managers => ActivitiesDaoManager(this);
}

class ActivitiesDaoManager {
  final _$ActivitiesDaoMixin _db;
  ActivitiesDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db.attachedDatabase, _db.activities);
}
