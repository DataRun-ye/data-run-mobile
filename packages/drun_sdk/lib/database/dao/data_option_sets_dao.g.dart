// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_option_sets_dao.dart';

// ignore_for_file: type=lint
mixin _$DataOptionSetsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DataOptionSetsTable get dataOptionSets => attachedDatabase.dataOptionSets;
  DataOptionSetsDaoManager get managers => DataOptionSetsDaoManager(this);
}

class DataOptionSetsDaoManager {
  final _$DataOptionSetsDaoMixin _db;
  DataOptionSetsDaoManager(this._db);
  $$DataOptionSetsTableTableManager get dataOptionSets =>
      $$DataOptionSetsTableTableManager(
          _db.attachedDatabase, _db.dataOptionSets);
}
