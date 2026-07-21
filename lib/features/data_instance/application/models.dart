import 'package:equatable/equatable.dart';

class TableAppearance with EquatableMixin {
  const TableAppearance({
    this.compact = false,
    this.fixedActionColumns = false,
    this.hideSynced = false,
    this.upwardDirectionOfSpeedDial = false,
  });

  final bool compact;
  final bool fixedActionColumns;
  final bool hideSynced;
  final bool upwardDirectionOfSpeedDial;

  @override
  List<Object?> get props =>
      [compact, fixedActionColumns, upwardDirectionOfSpeedDial, hideSynced];
}
