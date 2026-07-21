// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_resolution_dao.dart';

// ignore_for_file: type=lint
mixin _$PartyResolutionDaoMixin on DatabaseAccessor<AppDatabase> {
  $AssignmentPartyBindingsTable get assignmentPartyBindings =>
      attachedDatabase.assignmentPartyBindings;
  PartyResolutionDaoManager get managers => PartyResolutionDaoManager(this);
}

class PartyResolutionDaoManager {
  final _$PartyResolutionDaoMixin _db;
  PartyResolutionDaoManager(this._db);
  $$AssignmentPartyBindingsTableTableManager get assignmentPartyBindings =>
      $$AssignmentPartyBindingsTableTableManager(
          _db.attachedDatabase, _db.assignmentPartyBindings);
}
