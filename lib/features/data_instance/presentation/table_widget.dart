import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/features/data_instance/application/models.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/data_instance/presentation/paginated_table_source.dart';
import 'package:datarunmobile/features/data_instance/presentation/table_columns_build_extension.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

/// 3️⃣ Refactored PaginatedItemsTable using PaginatorController
class PaginatedItemsTable extends ConsumerStatefulWidget {
  const PaginatedItemsTable({
    super.key,
    required this.templateModel,
    this.assignmentId,
    this.header,
    this.disabledCellColor,
    this.pagination,
    this.filters = const IList.empty(),
  });

  final FormTemplateModel templateModel;
  final String? assignmentId;
  final Widget? header;
  final WidgetStateProperty<Color?>? disabledCellColor;
  final Pagination? pagination;
  final IList<FilterCondition<Object>> filters;

  @override
  ConsumerState<PaginatedItemsTable> createState() =>
      _PaginatedItemsTableState();
}

class _PaginatedItemsTableState extends ConsumerState<PaginatedItemsTable>
    with TableColumnsBuildExtension {
  late final PaginatorController _paginator;
  late final PaginatedTableSource _source;

  // Track the last‐seen values
  int? _lastFirstRow;
  int? _lastPageSize;

  @override
  void initState() {
    super.initState();
    logDebug('1.**********************        initState');
    _paginator = PaginatorController();
    _source = PaginatedTableSource(
      disabledCellColor: widget.disabledCellColor,
      templateModel: widget.templateModel,
      assignmentId: widget.assignmentId,
      onEdit: (item) =>
          appLocator<NavigationService>().navigateToFormFlowBootstrapper(
        formId: item.form.id,
        versionId: item.formVersionId,
        assignmentId: item.assignment,
        submissionId: item.id,
      ),
      onFailedSyncClicked: (item) {
        appLocator<ConfirmationService>().confirmAndExecute(
            context: context,
            title: S.current.syncFailed,
            body: '${S.current.syncErrors}: ${item.lastSyncMessage?.contains('Timeout') == true ? S.current.networkTimeout : item.lastSyncMessage}',
            confirmLabel: S.current.ok,
            action: () {});
      },
      onSelectedItem: ref.read(selectedItemsProvider.notifier).toggleSelection,
      isSelected: (id) => ref.read(selectedItemsProvider).contains(id),
    );

    // Only call our handler when real page/size changes occur
    _paginator.addListener(_maybeLoadPage);

    // Reset to row 0 on filter‐change
    ref.listenManual(
        dataInstanceFilterProvider(
            formId: widget.templateModel.id,
            assignmentId: widget.assignmentId), (_, __) async {
      logDebug('**********************        _filters Listener');
      if (_paginator.isAttached) _paginator.goToFirstPage();
      await _onPageOrSizeChanged();
    });

    ref.listenManual<ISet<String>>(selectedItemsProvider, (prev, next) {
      final updateSelectedItems = prev != next;
      logDebug(
          'SelectedItems Listener, source, update selectedIds? $updateSelectedItems');
      if (prev != next) {
        _updateSelectedItems();
      }
    });

    ref.listenManual<AsyncValue<int>>(
        totalItemsStreamProvider(
            templateFilter: SubmissionsFilter(
                formId: widget.templateModel.id,
                assignmentId: widget.assignmentId)), (prev, next) {
      next.whenData((count) {
        final currentTotal = ref.read(tablePaginationProvider).totalItems;
        logDebug(
            'totalItemsStream listener, pagination update total (current, new): ($currentTotal, $count)');
        _onPageOrSizeChanged1();
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   logDebug('**********************        _PostFrameCallback');
    //   if (_paginator.isAttached) _maybeLoadPage();
    // });
  }

  void _maybeLoadPage() {
    logDebug('**********************        _maybeLoadPage');
    final firstRow = _paginator.currentRowIndex;
    final pageSize = _paginator.rowsPerPage;

    // If neither value changed, bail out
    if (firstRow == _lastFirstRow && pageSize == _lastPageSize) return;

    // remember them and fetch
    _lastFirstRow = firstRow;
    _lastPageSize = pageSize;
    _onPageOrSizeChanged();
  }

  Future<void> _onPageOrSizeChanged() async {
    logDebug('Real page/size change detected → fetching');

    final firstRow = _lastFirstRow!;
    final pageSize = _lastPageSize!;
    final pageIndex = firstRow ~/ pageSize;

    final filter = ref.read(dataInstanceFilterProvider(
      formId: widget.templateModel.id,
      assignmentId: widget.assignmentId,
    ));
    final result = await appLocator<FormInstanceService>().fetchByFilter(
      filter,
      page: pageIndex,
      pageSize: pageSize,
    );

    // Clamp if deletes shrank the dataset
    final total = result.totalCount;
    final lastFirstRow = (total - 1).clamp(0, total) ~/ pageSize * pageSize;
    if (firstRow > lastFirstRow && _paginator.isAttached) {
      _paginator.goToRow(lastFirstRow);
      return;
    }

    // Update the table source
    _source.update(
      pageData: result.items.toList(),
      total: total,
      offset: pageIndex * pageSize,
    );

    ref
        .read(selectedItemsProvider.notifier)
        .validateSelections(result.items.map((e) => e.id));
  }

  Future<void> _onPageOrSizeChanged1() async {
    final firstRow = _paginator.currentRowIndex;
    final pageSize = _paginator.rowsPerPage;
    final pageIndex = firstRow ~/ pageSize;

    final filter = ref.read(dataInstanceFilterProvider(
      formId: widget.templateModel.id,
      assignmentId: widget.assignmentId,
    ));
    final svc = appLocator<FormInstanceService>();
    final result = await svc.fetchByFilter(
      filter,
      page: pageIndex,
      pageSize: pageSize,
    );

    final total = result.totalCount;
    final lastFirstRow = (total - 1).clamp(0, total) ~/ pageSize * pageSize;
    if (firstRow > lastFirstRow && _paginator.isAttached) {
      // jump to last valid page
      _paginator.goToRow(lastFirstRow);
    }

    _source.update(
      pageData: result.items.toList(),
      total: result.totalCount,
      offset: pageIndex * pageSize,
    );
  }

  Future<void> _updateSelectedItems() async {
    final ISet<String> selectedIds = ref.read(selectedItemsProvider);
    // Push the new slice into your DataTableSource
    _source.updateSelectedItems(ids: selectedIds.toList());
  }

  @override
  void dispose() {
    logDebug('4.**********************        dispose');
    _paginator.removeListener(_onPageOrSizeChanged);
    _paginator.dispose();
    _source.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final columns = buildColumns(widget.templateModel, ref);
    final minTableWidth = (columns.length * 150.0);

    return PaginatedDataTable2(
      header: widget.header,
      controller: _paginator,
      source: _source,
      columns: columns,
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20, 30, 50],
      showFirstLastButtons: true,
      onRowsPerPageChanged: (newSize) {
        if (newSize != null) {
          setState(() {
            _lastPageSize = newSize;
            _lastFirstRow = 0;
          });
          _onPageOrSizeChanged();
        }
      },
      fixedTopRows: 1,
      fixedLeftColumns: 1,
      showCheckboxColumn: true,
      minWidth: minTableWidth,
      columnSpacing: 12,
      horizontalMargin: 12,
      dataRowHeight: 60,
      wrapInCard: false,
      renderEmptyRowsInTheEnd: false,
    );
  }

  @override
  void didUpdateWidget(covariant PaginatedItemsTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    final prev = oldWidget.pagination;
    final next = widget.pagination;
    final loadData = prev?.currentPage != next?.currentPage ||
        prev?.pageSize != next?.pageSize ||
        prev?.totalItems != next?.totalItems;
    logDebug(
        '2.**********************        didUpdateWidget, load data? $loadData');
    // if (loadData) {
    //   _pagination = next;
    //   _loadPage();
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logDebug('3.**********************        didChangeDependencies');
  }
}
