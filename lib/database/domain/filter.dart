import 'package:drift/drift.dart';

/// Supported comparison operators.
enum FilterOperator {
  equals,
  notEquals,
  greaterThan,
  lessThan,
  greaterOrEqual,
  lessOrEqual,
  contains, // LIKE '%value%'
  inList, // IN (...)
  isNull, // IS NULL
  isNotNull, // IS NOT NULL
  between, // BETWEEN low AND high
}

/// A single filter on a column of type T.
///
/// Example:
///
/// ```dart
/// final repo = DriftTableRepository(db);
///
/// // e.g. get “draft” rows created after Jan 1st 2025, sorted by modifiedDate:
/// final filters = [
///   FilterCondition<String>(
///     column: db.items.status,
///     op: FilterOperator.equals,
///     value: 'draft',
///   ),
///   FilterCondition<DateTime>(
///     column: db.items.modifiedDate,
///     op: FilterOperator.greaterThan,
///     value: DateTime(2025, 1, 1),
///   ),
/// ];
///
/// final (items, count) = await repo.getItems(
///   page: 0,
///   pageSize: 20,
///  filters: filters,
///   sortColumn: 'modified_date',
///   sortAscending: false,
/// );
///
/// print('Found $count matching items, showing ${items.length} on page 1.');
///```
///
class FilterCondition<T extends Object> {
  final GeneratedColumn<T> column;
  final FilterOperator op;
  final T? value;
  final List<T>? listValues;
  final T? secondValue;

  FilterCondition._({
    required this.column,
    required this.op,
    this.value,
    this.listValues,
    this.secondValue,
  });

  String get displayText {
    switch (op) {
      case FilterOperator.equals:
        return '${column.name} = $value';
      case FilterOperator.notEquals:
        return '${column.name} != $value';
      case FilterOperator.greaterThan:
        return '${column.name} > $value';
      case FilterOperator.lessThan:
        return '${column.name} < $value';
      case FilterOperator.greaterOrEqual:
        return '${column.name} >= $value';
      case FilterOperator.lessOrEqual:
        return '${column.name} <= $value';
      case FilterOperator.contains:
        return '${column.name} contains $value';
      case FilterOperator.inList:
        return '${column.name} in $listValues';
      case FilterOperator.isNull:
        return '${column.name} is null';
      case FilterOperator.isNotNull:
        return '${column.name} is not null';
      case FilterOperator.between:
        return '${column.name} between $value and $secondValue';
    }
  }

  // Helper constructors
  factory FilterCondition.equals(GeneratedColumn<T> column, T value) =>
      FilterCondition._(
          column: column, op: FilterOperator.equals, value: value);

  factory FilterCondition.inList(GeneratedColumn<T> column, List<T> values) =>
      FilterCondition._(
          column: column, op: FilterOperator.inList, listValues: values);

  factory FilterCondition.between(GeneratedColumn<T> column, T low, T high) =>
      FilterCondition._(
        column: column,
        op: FilterOperator.between,
        value: low,
        secondValue: high,
      );

  factory FilterCondition.isNull(GeneratedColumn<T> column) =>
      FilterCondition._(column: column, op: FilterOperator.isNull);

  factory FilterCondition.isNotNull(GeneratedColumn<T> column) =>
      FilterCondition._(column: column, op: FilterOperator.isNotNull);

  // …other operators e.g. startsWith, endsWith, custom

  /// Converts this condition into a Drift Expression<bool>.
  Expression<bool> toExpression() {
    switch (op) {
      case FilterOperator.equals:
        return column.equals(value as T);
      case FilterOperator.notEquals:
        return column.isNotValue(value as T);
      case FilterOperator.greaterThan:
        return (column as GeneratedColumn<Comparable>)
            .isBiggerThanValue(value as Comparable);
      case FilterOperator.lessThan:
        return (column as GeneratedColumn<Comparable>)
            .isSmallerThanValue(value as Comparable);
      case FilterOperator.greaterOrEqual:
        return (column as GeneratedColumn<Comparable>)
            .isBiggerOrEqualValue(value as Comparable);
      case FilterOperator.lessOrEqual:
        return (column as GeneratedColumn<Comparable>)
            .isSmallerOrEqualValue(value as Comparable);
      case FilterOperator.contains:
        return (column as GeneratedColumn<String>)
            .like('%${value.toString()}%');
      case FilterOperator.inList:
        return column.isIn(listValues!);
      case FilterOperator.isNull:
        return column.isNull();
      case FilterOperator.isNotNull:
        return column.isNotNull();
      case FilterOperator.between:
        return (column as GeneratedColumn<Comparable>)
            .isBetweenValues(value as Comparable, secondValue as Comparable);
    }
  }
}
