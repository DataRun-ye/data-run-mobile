import 'package:d_sdk/database/shared/submission_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SortDescriptor {
  const SortDescriptor({
    this.sortColumn,
    this.sortAscending = false,
  });

  final String? sortColumn;
  final bool sortAscending;
}

class Pagination with EquatableMixin {
  const Pagination({
    this.currentPage = 0,
    this.pageSize = 10,
    this.totalItems = 0,
    this.sortColumn,
    this.sortAscending = false,
  });

  final int currentPage;
  final int pageSize;
  final int totalItems;
  final String? sortColumn;
  final bool sortAscending;

  int get lastPage => (totalItems / pageSize).ceil() - 1;

  // int get totalPages => (totalItems / pageSize).ceil();
  // bool get isFirstPage => currentPage == 0;
  //
  // bool get isLastPage => currentPage == lastPage;
  //
  // bool get hasNextPage => currentPage < lastPage;
  //
  // bool get hasPreviousPage => currentPage > 0;
  int get totalPages => (totalItems / pageSize).ceil();

  bool get hasNextPage => (currentPage + 1) * pageSize < totalItems;

  bool get hasPreviousPage => currentPage > 0;

  int get nextPageIndex => currentPage + 1;

  int get previousPageIndex => currentPage - 1;

  bool get isLastPage => !hasNextPage;

  bool get isFirstPage => !hasPreviousPage;

  int get lastPageIndex => (totalItems / pageSize).ceil() - 1;

  int get firstPageIndex => 0;

  int get currentOffset => currentPage * pageSize;

  int get lastOffset => (totalItems / pageSize).ceil() * pageSize;

  int get totalPagesCount => (totalItems / pageSize).ceil();

  Pagination copyWith({
    int? currentPage,
    int? pageSize,
    String? sortColumn,
    bool? sortAscending,
    int? totalItems,
  }) {
    return Pagination(
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      sortColumn: sortColumn ?? this.sortColumn,
      sortAscending: sortAscending ?? this.sortAscending,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  Pagination onTotalChanged(int newTotalItems) {
    final newLastPageIndex = (newTotalItems / pageSize).ceil() - 1;
    final newPageIndex = this.currentPage.clamp(0, newLastPageIndex);

    // Only update if needed
    if (newPageIndex != this.currentPage || newTotalItems != totalItems) {
      return copyWith(
        currentPage: newPageIndex,
        totalItems: newTotalItems,
      );
    }
    return this;
  }

  @override
  List<Object?> get props => [
        currentPage,
        pageSize,
        sortColumn,
        sortAscending,
        totalItems,
      ];

  @override
  String toString() {
    return '(currentPage: $currentPage, size: $pageSize, total: $totalItems)';
  }
}

class TableState with EquatableMixin {
  TableState({
    this.pagination = const Pagination(),
    this.items = const IList.empty(),
    this.selectedIds = const ISet.empty(),
    // this.activeFilters = const IList.empty(),
    // this.isLoading = false,
  });

  final IList<SubmissionSummary> items;
  final ISet<String> selectedIds;

  // final IList<FilterCondition> activeFilters;
  // final bool isLoading;
  final Pagination pagination;

  int get currentPage => pagination.currentPage;

  int get pageSize => pagination.pageSize;

  String? get sortColumn => pagination.sortColumn;

  bool get sortAscending => pagination.sortAscending;

  int get totalItems => pagination.totalItems;

  TableState onPageIndexChanged(int newPageIndex) {
    return copyWith(
      pagination: pagination.copyWith(currentPage: newPageIndex ~/ pageSize),
    );
  }

  TableState onTotalChanged(int newTotalItems) {
    final newLastPageIndex = (newTotalItems / pageSize).ceil() - 1;
    final newPageIndex = this.currentPage.clamp(0, newLastPageIndex);

    // Only update if needed
    if (newPageIndex != this.currentPage || newTotalItems != totalItems) {
      return copyWith(
          pagination: pagination.copyWith(
        currentPage: newPageIndex,
        totalItems: newTotalItems,
      ));
    }
    return this;
  }

  @override
  List<Object?> get props => [
        pagination,
        items,
        selectedIds,
      ];

  TableState copyWith({
    Pagination? pagination,
    Iterable<SubmissionSummary>? items,
    Iterable<String>? selectedIds,
  }) {
    return TableState(
      pagination: pagination ?? this.pagination,
      items: IList.orNull(items) ?? this.items,
      selectedIds: ISet.orNull(selectedIds) ?? this.selectedIds,
      // activeFilters: IList.orNull(activeFilters) ?? this.activeFilters,
    );
  }

  Set<String> get syncableSelectedIds {
    final validSubmissions = items
        .where((s) => selectedIds.contains(s.id) && s.syncStatus.isFinalized);
    return validSubmissions.map((s) => s.id).toSet();
  }
}

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
