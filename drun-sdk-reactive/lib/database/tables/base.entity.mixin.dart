import 'package:drift/drift.dart';

mixin BaseTableMixin on Table {
  TextColumn get id => text()();

  DateTimeColumn get lastModifiedDate =>
      dateTime().nullable().clientDefault(() => DateTime.now().toUtc())();

  DateTimeColumn get createdDate =>
      dateTime().nullable().clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
