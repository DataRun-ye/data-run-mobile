// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ou_levels_dao.dart';

// ignore_for_file: type=lint
mixin _$OuLevelsDaoMixin on DatabaseAccessor<AppDatabase> {
  $OuLevelsTable get ouLevels => attachedDatabase.ouLevels;
  OuLevelsDaoManager get managers => OuLevelsDaoManager(this);
}

class OuLevelsDaoManager {
  final _$OuLevelsDaoMixin _db;
  OuLevelsDaoManager(this._db);
  $$OuLevelsTableTableManager get ouLevels =>
      $$OuLevelsTableTableManager(_db.attachedDatabase, _db.ouLevels);
}
