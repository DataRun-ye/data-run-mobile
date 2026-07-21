// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_form_permissions_dao.dart';

// ignore_for_file: type=lint
mixin _$UserFormPermissionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $ActivitiesTable get activities => attachedDatabase.activities;
  $TeamsTable get teams => attachedDatabase.teams;
  $FormTemplatesTable get formTemplates => attachedDatabase.formTemplates;
  $UserFormPermissionsTable get userFormPermissions =>
      attachedDatabase.userFormPermissions;
  UserFormPermissionsDaoManager get managers =>
      UserFormPermissionsDaoManager(this);
}

class UserFormPermissionsDaoManager {
  final _$UserFormPermissionsDaoMixin _db;
  UserFormPermissionsDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db.attachedDatabase, _db.activities);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$FormTemplatesTableTableManager get formTemplates =>
      $$FormTemplatesTableTableManager(_db.attachedDatabase, _db.formTemplates);
  $$UserFormPermissionsTableTableManager get userFormPermissions =>
      $$UserFormPermissionsTableTableManager(
          _db.attachedDatabase, _db.userFormPermissions);
}
