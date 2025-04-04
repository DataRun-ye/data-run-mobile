class PagedResult<T> {
  PagedResult(
      {this.items = const [],
      required this.totalCount,
      required this.hasNextPage,
      this.page = 1,
      this.pageSize = 20});

  final List<T> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
}
