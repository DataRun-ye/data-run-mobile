import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class PaginatedResult<T> with EquatableMixin {
  PaginatedResult({
    Iterable<T>? items,
    required this.totalCount,
  }) : this.items = IList.orNull(items) ?? const IList.empty();

  final IList<T> items;
  final int totalCount;

  @override
  List<Object?> get props => [items, totalCount];
}
