// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_units_dao.dart';

// ignore_for_file: type=lint
mixin _$OrgUnitsDaoMixin on DatabaseAccessor<AppDatabase> {
  $OrgUnitsTable get orgUnits => attachedDatabase.orgUnits;
  OrgUnitsDaoManager get managers => OrgUnitsDaoManager(this);
}

class OrgUnitsDaoManager {
  final _$OrgUnitsDaoMixin _db;
  OrgUnitsDaoManager(this._db);
  $$OrgUnitsTableTableManager get orgUnits =>
      $$OrgUnitsTableTableManager(_db.attachedDatabase, _db.orgUnits);
}
