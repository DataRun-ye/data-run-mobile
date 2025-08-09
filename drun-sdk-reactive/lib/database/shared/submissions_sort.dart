import 'package:equatable/equatable.dart';

class SortModel with EquatableMixin {
  const SortModel({
    this.sortColumn,
    this.sortAscending = false,
  });

  /// current sort column
  final String? sortColumn;
  final bool sortAscending;

  @override
  List<Object?> get props => [
        sortColumn,
        sortAscending,
      ];

  SortModel copyWith({
    String? sortColumn,
    bool? sortAscending,
  }) {
    return SortModel(
      sortColumn: sortColumn ?? this.sortColumn,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }
}
