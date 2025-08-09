import 'package:drift/drift.dart';
extension FindById<Table extends HasResultSet, Row>
on ResultSetImplementation<Table, Row> {
  Selectable<Row> findById(String id) {
    return select()
      ..where((row) {
        final idColumn = columnsByName['id'];

        if (idColumn == null) {
          throw ArgumentError.value(
              this, 'this', 'Must be a table with an id column');
        }

        if (idColumn.type != DriftSqlType.string) {
          throw ArgumentError('Column `id` is not an integer');
        }

        return idColumn.equals(id);
      });
  }
}

extension UpdateTitle on DatabaseConnectionUser {
  Future<Row?> updateTitle<T extends TableInfo<Table, Row>, Row>(
      T table, String id, String newTitle) async {
    final columnsByName = table.columnsByName;
    final stmt = update(table)
      ..where((tbl) {
        final idColumn = columnsByName['id'];

        if (idColumn == null) {
          throw ArgumentError.value(
              this, 'this', 'Must be a table with an id column');
        }

        if (idColumn.type != DriftSqlType.string) {
          throw ArgumentError('Column `id` is not an integer');
        }

        return idColumn.equals(id);
      });

    final rows = await stmt.writeReturning(RawValuesInsertable({
      'title': Variable<String>(newTitle),
    }));

    return rows.singleOrNull;
  }
}