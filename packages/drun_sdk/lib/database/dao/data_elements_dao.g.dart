// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_elements_dao.dart';

// ignore_for_file: type=lint
mixin _$DataElementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DataOptionSetsTable get dataOptionSets => attachedDatabase.dataOptionSets;
  $DataElementsTable get dataElements => attachedDatabase.dataElements;
  DataElementsDaoManager get managers => DataElementsDaoManager(this);
}

class DataElementsDaoManager {
  final _$DataElementsDaoMixin _db;
  DataElementsDaoManager(this._db);
  $$DataOptionSetsTableTableManager get dataOptionSets =>
      $$DataOptionSetsTableTableManager(
          _db.attachedDatabase, _db.dataOptionSets);
  $$DataElementsTableTableManager get dataElements =>
      $$DataElementsTableTableManager(_db.attachedDatabase, _db.dataElements);
}
