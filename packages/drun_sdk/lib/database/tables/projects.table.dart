import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

class Projects extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get name => text()();

  TextColumn get code => text().nullable()();

  BoolColumn get disabled => boolean().nullable()();
}
