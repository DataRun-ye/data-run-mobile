// import 'package:datarunmobile/data_run/form/form_state/table_state.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'table_state_notifier.provider.g.dart';

// @riverpod
// class TableStateNotifier extends _$TableStateNotifier {
//   @override
//   IMap<String, RowState> build() {
//     throw UnimplementedError();
//   }

// TableStateNotifier(SectionTemplate template)
//     : super(instantiateTableFromTemplate(template));

// void addRow(TableRow row) {
//   state = {...state, row.id: row};
// }
//
// void updateCell(String rowId, String cellId, dynamic newValue) {
//   final row = state[rowId];
//   if (row != null) {
//     final updatedCells = row.cells.map((cell) {
//       return cell.id == cellId ? cell.copyWith(value: newValue) : cell;
//     }).toList();
//     state = {...state, rowId: row.copyWith(cells: updatedCells)};
//   }
// }
// }
