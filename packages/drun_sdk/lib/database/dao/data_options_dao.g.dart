// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_options_dao.dart';

// ignore_for_file: type=lint
mixin _$DataOptionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DataOptionSetsTable get dataOptionSets => attachedDatabase.dataOptionSets;
  $DataOptionsTable get dataOptions => attachedDatabase.dataOptions;
  DataOptionsDaoManager get managers => DataOptionsDaoManager(this);
}

class DataOptionsDaoManager {
  final _$DataOptionsDaoMixin _db;
  DataOptionsDaoManager(this._db);
  $$DataOptionSetsTableTableManager get dataOptionSets =>
      $$DataOptionSetsTableTableManager(
          _db.attachedDatabase, _db.dataOptionSets);
  $$DataOptionsTableTableManager get dataOptions =>
      $$DataOptionsTableTableManager(_db.attachedDatabase, _db.dataOptions);
}
