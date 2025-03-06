import 'package:datarun/core/form/evaluation_engine/expression_engine/expression_type.dart';
import 'package:equatable/equatable.dart';

class ExpressionUnit with EquatableMixin {
  ExpressionUnit(
      {required this.source, required this.dependent, required this.type});

  final String source;
  final String dependent;
  final ExpressionType type;

  @override
  List<Object?> get props => [source, dependent, type];
}
