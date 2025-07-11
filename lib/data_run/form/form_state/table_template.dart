// import 'package:d_sdk/core/form/element_template/element_template.dart';
// import 'package:d_sdk/database/shared/value_type.dart';
//
// class TableTemplate extends FieldTemplate {
//   List<ColumnTemplate> get fields => columns;
//   // fieldTemplate/fields
//   final List<ColumnTemplate> columns;
//   final List<RowTemplate> rows; // Optional for pre-defined rows
//   final Map<String, ValidationRule> validationRules; // Rules for cell or row validation
//   final List<DerivedColumn> derivedColumns; // Defines computed columns
//   final String tableName;
//
//   TableTemplate({
//     required this.columns,
//     this.rows = const [],
//     this.validationRules = const {},
//     this.derivedColumns = const [],
//     required this.tableName,
//   });
// }
//
// class ColumnTemplate extends FieldTemplate {
//   final String name; // Unique identifier
//   final ValueType type; // e.g., "number", "string", etc.
//   final bool isEditable; // Can the user edit this column?
//   final String? derivedFormula; // For calculated fields, e.g., "SUM(row1_col1, row2_col1)"
//   final String? validationRuleKey; // Link to validationRules
//
//   ColumnTemplate({
//     required this.name,
//     required this.type,
//     this.isEditable = true,
//     this.derivedFormula,
//     this.validationRuleKey,
//   });
// }
//
// class RowTemplate {
//   final String id; // Unique identifier
//   final Map<String, dynamic> initialValues; // Default values for cells in this row
//   RowTemplate({required this.id, this.initialValues = const {}});
// }
//
// /// calculated Field
// class DerivedColumn {
//   final String columnName; // Target column
//   final String formula; // Formula to compute values dynamically
//   DerivedColumn({required this.columnName, required this.formula});
// }
//
//
// class ValidationRule {
//   final String id;
//   final String expression; // e.g., "value > 0", or "cell1 + cell2 == 100"
//   final String errorMessage;
//
//   ValidationRule({
//     required this.id,
//     required this.expression,
//     required this.errorMessage,
//   });
// }
