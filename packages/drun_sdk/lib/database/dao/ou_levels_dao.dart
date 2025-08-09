import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'ou_levels_dao.g.dart';

@DriftAccessor(tables: [OuLevels])
class OuLevelsDao extends DatabaseAccessor<AppDatabase>
    with _$OuLevelsDaoMixin, BaseDaoMixin<OuLevel> {
  OuLevelsDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'ouLevels';

  @override
  OuLevel fromApiJson(Map<String, dynamic> data,
          {ValueSerializer? serializer}) =>
      OuLevel.fromJson(data, serializer: serializer);

  @override
  $OuLevelsTable get table => ouLevels;
}
