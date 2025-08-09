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
          throw ArgumentError('Column `id` is not a string');
        }

        return idColumn.equals(id);
      });
  }
}
