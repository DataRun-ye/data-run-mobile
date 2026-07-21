// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_dao.dart';

// ignore_for_file: type=lint
mixin _$PartyDaoMixin on DatabaseAccessor<AppDatabase> {
  $PartiesTable get parties => attachedDatabase.parties;
  PartyDaoManager get managers => PartyDaoManager(this);
}

class PartyDaoManager {
  final _$PartyDaoMixin _db;
  PartyDaoManager(this._db);
  $$PartiesTableTableManager get parties =>
      $$PartiesTableTableManager(_db.attachedDatabase, _db.parties);
}
