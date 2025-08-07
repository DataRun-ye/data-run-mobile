import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/exception_indicators/empty_list_indicator.dart';
import 'package:datarunmobile/features/assignment_detail/application/models.dart';
import 'package:datarunmobile/features/assignment_detail/application/table.providers.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/paginated_table/paginated_table_source.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/paginated_table/table_columns_build_extension.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance_service.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

/// A ConsumerStatefulWidget holds the DataTableSource
class PaginatedItemsTable extends ConsumerStatefulWidget {
  PaginatedItemsTable({
    super.key,
    this.header,
    required this.templateModel,
    this.assignmentId,
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
  ConsumerState<PaginatedItemsTable> createState() => _SubmissionTableState();
}

class _SubmissionTableState extends ConsumerState<PaginatedItemsTable>
    with TableColumnsBuildExtension {
  late final PaginatedTableSource _source;
  late Pagination? _pagination;

  @override
  void didUpdateWidget(covariant PaginatedItemsTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    final prev = oldWidget.pagination;
    final next = widget.pagination;
    final loadData = prev?.currentPage != next?.currentPage ||
        prev?.pageSize != next?.pageSize ||
        prev?.totalItems != next?.totalItems;
    logDebug('2.**********************        didUpdateWidget, load data? $loadData');
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

  @override
  void dispose() {
    logDebug('4.**********************        dispose');
    // _source.dispose(); // only needed if your source has subscriptions
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logDebug('1.**********************        initState');

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
      onFailedSyncClicked: (item) {},
      onSelectedItem: ref.read(selectedItemsProvider.notifier).toggleSelection,
      isSelected: (id) => ref.read(selectedItemsProvider).contains(id),
    );

    // Listen to pagination changes
    ref.listenManual<Pagination>(tablePaginationProvider, (prev, next) {
      final loadData = prev?.currentPage != next.currentPage ||
          prev?.pageSize != next.pageSize ||
          prev?.totalItems != next.totalItems;
      logDebug(
          'Pagination listener, source, load data? $loadData, pagination: (${prev?.toString()}, ${next.toString()})');
      // only load if pageIndex or pageSize changed
      if (loadData) {
        _loadPage();
      }
    });

    ref.listenManual<ISet<String>>(selectedItemsProvider, (prev, next) {
      final updateSelectedItems = prev != next;
      logDebug(
          'SelectedItems Listener, source, update selectedIds? $updateSelectedItems');
      // only load if pageIndex or pageSize changed
      if (prev != next) {
        _updateSelectedItems();
      }
    });

    // Listen to filter changes
    // ref.listenManual<IList<FilterCondition>>(tableFilterProvider, (prev, next) {
    //   logDebug('filters changing resetting pagination to 0');
    //   // reset to first page
    //   ref.read(tablePaginationProvider.notifier).reset();
    //   // now that pageIndex is 0, let pagination-listener trigger the load
    //   // (so you don’t double-call _loadPage here)
    // });

    // Kick off initial load
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPage());
  }

  Future<void> _updateSelectedItems() async {
    final ISet<String> selectedIds = ref.read(selectedItemsProvider);
    // Push the new slice into your DataTableSource
    _source.updateSelectedItems(ids: selectedIds.toList());
  }

  Future<void> _loadPage() async {
    // 1️⃣ Grab the current filters + pagination for the fetch call
    final before = ref.read(tablePaginationProvider);
    final filters = ref.read(tableFilterProvider);

    // 2️⃣ Fetch the slice
    final pageResult = await appLocator<FormInstanceService>().fetchByFilter(
      SubmissionsFilter(
        formId: widget.templateModel.id,
        assignmentId: widget.assignmentId,
      ),
      page: before.currentPage,
      pageSize: before.pageSize,
      sortColumn: before.sortColumn,
      sortAscending: before.sortAscending,
      filters: filters,
    );

    // 3️⃣ Clamp total & pageIndex
    // ref
    //     .read(tablePaginationProvider.notifier)
    //     .updateTotal(pageResult.totalCount);

    // 4️⃣ read the updated pagination
    final after = ref.read(tablePaginationProvider);

    // 5️⃣ Push into your DataTableSource with the corrected offset
    _source.update(
      pageData: pageResult.items.toList(),
      total: pageResult.totalCount,
      offset: after.currentPage * after.pageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagination = ref.watch(tablePaginationProvider);
    final columns = buildColumns(widget.templateModel, ref);
    final minTableWidth = (columns.length * 150.0);
    return PaginatedDataTable2(
      // key: ValueKey(
      //     'instances_table_${widget.templateModel.id}_${widget.assignmentId != null ? widget.assignmentId : ''}'),
      header: widget.header,
      source: _source,
      columns: columns,
      availableRowsPerPage: <int>[
        5,
        10,
        20,
      ],
      onPageChanged:
          ref.read(tablePaginationProvider.notifier).onPageIndexChanged,
      onRowsPerPageChanged: (newSize) {
        if (newSize != null) {
          ref.read(tablePaginationProvider.notifier).onPageSizeChanged(newSize);
          // _loadPage();
        }
      },
      rowsPerPage: pagination.pageSize,
      fixedTopRows: 1,
      fixedLeftColumns: 1,
      empty: EmptyListIndicator(
        message: S.of(context).addAnItem,
      ),
      // showFirstLastButtons: true,
      sortAscending: pagination.sortAscending,
      showCheckboxColumn: true,
      minWidth: minTableWidth,
      columnSpacing: 12,
      horizontalMargin: 12,
      dataRowHeight: 60,
      // new
      // wrapInCard: false,
      renderEmptyRowsInTheEnd: false,
      // hidePaginator: true,
    );
  }
}
