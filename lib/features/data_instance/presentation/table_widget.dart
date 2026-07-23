import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_table_service.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/data_instance/application/table_controller.provider.dart';
import 'package:datarunmobile/features/data_instance/presentation/paginated_table_source.dart';
import 'package:datarunmobile/features/data_instance/presentation/submission_sync_failure_message.dart';
import 'package:datarunmobile/features/data_instance/presentation/table_columns_build_extension.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/gestures.dart';
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
  });

  final FormTemplateModel templateModel;
  final String? assignmentId;
  final Widget? header;
  final WidgetStateProperty<Color?>? disabledCellColor;

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
  int _loadGeneration = 0;

  @override
  void initState() {
    super.initState();
    // logDebug('1.**********************        initState');
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
            body:
                '${S.current.syncErrors}: ${submissionSyncFailureMessage(item.lastSyncMessage)}',
            confirmLabel: S.current.ok,
            action: () {});
      },
      onSelectedItem: ref
          .read(tableControllerProvider(
            formId: widget.templateModel.id,
            assignmentId: widget.assignmentId,
          ).notifier)
          .toggleSelection,
    );

    // Only call our handler when real page/size changes occur
    _paginator.addListener(_maybeLoadPage);

    // Reset to row 0 on filter‐change
    ref.listenManual(
        dataInstanceFilterProvider(
            formId: widget.templateModel.id,
            assignmentId: widget.assignmentId), (_, __) async {
      if (!_paginator.isAttached) return;
      if (_paginator.currentRowIndex == 0) {
        await _reloadCurrentPage(force: true);
      } else {
        _paginator.goToFirstPage();
      }
    });

    ref.listenManual<ISet<String>>(
        tableControllerProvider(
          formId: widget.templateModel.id,
          assignmentId: widget.assignmentId,
        ), (prev, next) {
      if (prev != next) {
        _source.updateSelectedItems(ids: next);
      }
    });

    ref.listenManual<AsyncValue<int>>(
        totalItemsStreamProvider(
            templateFilter: SubmissionsFilter(
                formId: widget.templateModel.id,
                assignmentId: widget.assignmentId)), (prev, next) {
      next.whenData((count) {
        _reloadCurrentPage(force: true);
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   logDebug('**********************        _PostFrameCallback');
    //   if (_paginator.isAttached) _maybeLoadPage();
    // });
  }

  void _maybeLoadPage() {
    if (!_paginator.isAttached) return;
    final firstRow = _paginator.currentRowIndex;
    final pageSize = _paginator.rowsPerPage;

    // If neither value changed, bail out
    if (firstRow == _lastFirstRow && pageSize == _lastPageSize) return;

    _reloadCurrentPage();
  }

  Future<void> _reloadCurrentPage({
    bool force = false,
    int? firstRowOverride,
    int? pageSizeOverride,
  }) async {
    if (!_paginator.isAttached &&
        (firstRowOverride == null || pageSizeOverride == null)) {
      return;
    }
    final firstRow = firstRowOverride ?? _paginator.currentRowIndex;
    final pageSize = pageSizeOverride ?? _paginator.rowsPerPage;
    if (!force && firstRow == _lastFirstRow && pageSize == _lastPageSize) {
      return;
    }
    _lastFirstRow = firstRow;
    _lastPageSize = pageSize;
    final loadGeneration = ++_loadGeneration;
    final pageIndex = firstRow ~/ pageSize;

    final filter = ref.read(dataInstanceFilterProvider(
      formId: widget.templateModel.id,
      assignmentId: widget.assignmentId,
    ));
    final result = await appLocator<SubmissionTableService>().fetchByFilter(
      filter,
      page: pageIndex,
      pageSize: pageSize,
    );
    if (!mounted || loadGeneration != _loadGeneration) return;

    final total = result.totalCount;
    final lastFirstRow = (total - 1).clamp(0, total) ~/ pageSize * pageSize;
    if (firstRow > lastFirstRow && _paginator.isAttached) {
      _paginator.goToRow(lastFirstRow);
      return;
    }

    _source.update(
      pageData: result.items.toList(),
      total: total,
      offset: pageIndex * pageSize,
    );

    ref
        .read(tableControllerProvider(
          formId: widget.templateModel.id,
          assignmentId: widget.assignmentId,
        ).notifier)
        .retainOnly(result.items.map((e) => e.id));
  }

  @override
  void dispose() {
    // logDebug('4.**********************        dispose');
    _loadGeneration++;
    _paginator.removeListener(_maybeLoadPage);
    _paginator.dispose();
    _source.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tableAppearance = ref.watch(tableAppearanceControllerProvider);
    final cs = Theme.of(context).colorScheme;
    final columns = buildColumns(widget.templateModel, ref, tableAppearance);
    final compact = tableAppearance.compact;
    final minTableWidth = (columns.length * (compact ? 100.0 : 130.0));

    return PaginatedDataTable2(
      dragStartBehavior: DragStartBehavior.down,
      header: widget.header,
      controller: _paginator,
      source: _source,
      columns: columns,
      rowsPerPage: 10,
      availableRowsPerPage: const [10, 20, 30, 60],
      onRowsPerPageChanged: (newSize) {
        if (newSize != null) {
          setState(() {
            _lastPageSize = newSize;
            _lastFirstRow = 0;
          });
          _reloadCurrentPage(
            force: true,
            firstRowOverride: 0,
            pageSizeOverride: newSize,
          );
        }
      },
      fixedTopRows: 1,
      fixedLeftColumns:
          ref.watch(tableAppearanceControllerProvider).fixedActionColumns
              ? 3
              : 0,
      fixedCornerColor: cs.primaryContainer.withValues(alpha: 0.7),
      fixedColumnsColor: cs.surfaceContainer,
      showCheckboxColumn: true,
      minWidth: minTableWidth,
      columnSpacing: compact ? 8 : 12,
      horizontalMargin: compact ? 8 : 16,
      dataRowHeight: compact ? 40 : 55,
      wrapInCard: false,
      renderEmptyRowsInTheEnd: false,
    );
  }
}
