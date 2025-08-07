import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/assignment_detail/application/table.providers.dart';
import 'package:datarunmobile/features/assignment_detail/application/table_controller.provider.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/paginated_table/filter_bar.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/paginated_table/filter_drawer.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/paginated_table/table_widget.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/widgets/action_fab.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class TableScreen extends ConsumerWidget {
  const TableScreen({
    super.key,
    required this.formId,
    this.assignmentId,
  });

  final String formId;
  final String? assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    ref.listen<AsyncValue<int>>(
        totalItemsStreamProvider(
            templateFilter:
                SubmissionsFilter(formId: formId, assignmentId: assignmentId)),
        (prev, next) {
      next.whenData((count) {
        final currentTotal = ref.read(tablePaginationProvider).totalItems;
        logDebug(
            'totalItemsStream listener, pagination update total (current, new): ($currentTotal, $count)');
        ref.read(tablePaginationProvider.notifier).updateTotal(count);
      });
    });
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const FilterDrawer(),
      body: Column(
        children: [
          const FilterBar(),
          Consumer(
            builder: (context, ref, child) {
              final formAsync = ref.watch(formTemplateProvider(formId: formId));
              final filters = ref.watch(tableFilterProvider);
              final pageSize = ref.watch(tablePaginationProvider
                  .select((pagination) => pagination.pageSize));

              // final totalItems = ref.watch(totalItemsStreamProvider());
              // final pagination = ref.watch(tablePaginationProvider);

              return AsyncValueWidget(
                value: formAsync,
                valueBuilder: (templateModel) {
                  return Expanded(
                    child: PaginatedItemsTable(
                      // key: ObjectKey(filters),
                      filters: filters,
                      disabledCellColor: WidgetStateProperty.all(
                          darken(cs.surfaceContainerHighest, 0.1)),
                      templateModel: templateModel,
                      assignmentId: assignmentId,
                      header: Row(
                        children: [
                          SyncStatusBadgesView(
                              formId: formId, assignmentId: assignmentId),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: ActionFAB(
        onAddNew: () {
          appLocator<NavigationService>().navigateToFormFlowBootstrapper(
              formId: formId, assignmentId: assignmentId);
        },
        onDelete: () {
          ref.read(tableControllerProvider.notifier).deleteSelectedItems();
        },
        onBulkSync: () {
          ref
              .read(tableControllerProvider.notifier)
              .syncSelectedFinalizedItems();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      persistentFooterButtons: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: const FilterBar()),
      ],
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   // child: Row(
      //   //   mainAxisAlignment: MainAxisAlignment.end,
      //   //   mainAxisSize: MainAxisSize.max,
      //   //   children: [
      //   //     Flexible(
      //   //       child: SingleChildScrollView(
      //   //           scrollDirection: Axis.horizontal, child: ),
      //   //     ),
      //   //   ],
      //   // ),
      // ),
    );
  }

// Row buildTableHeader(FormTemplateModel templateModel) {
//   return ;
// }

// List<Widget> buildTableActions(
//     Iterable<String> selectedIds,
//     // Iterable<String> syncableSelectedIds,
//     BuildContext context,
//     WidgetRef ref) {
//   return [
//     if (syncableSelectedIds.length > 0)
//       Wrap(
//         children: [
//           ElevatedButton.icon(
//               onPressed: syncableSelectedIds.isNotEmpty
//                   ? () async {
//                       // await _showSyncDialog(context, syncableSelectedIds);
//                     }
//                   : null,
//               icon: const Icon(
//                 Icons.cloud_upload_sharp,
//                 color: Colors.green,
//               ),
//               label: Text(
//                   '${S.of(context).syncSubmissions(syncableSelectedIds.length)}')),
//           if (selectedIds.isNotEmpty)
//             ElevatedButton.icon(
//                 onPressed: () async {
//                   // delete
//                   ref.read(tableControllerProvider.notifier).deleteSelected();
//                 },
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ),
//                 label: Text(
//                     '${S.of(context).deleteSelected(syncableSelectedIds.length)}'))
//         ],
//       )
//   ];
// }

// List<DataColumn> _buildColumns(
//     FormTemplateModel templateModel, WidgetRef ref) {
//   return [
//     _getStatusColumn(ref),
//     _getEditColumn(ref),
//     ..._getDynamicFormFields(templateModel, ref),
//     ..._getDatesColumn(ref),
//   ];
// }
//
// List<DataColumn> _getDynamicFormFields(
//     FormTemplateModel templateModel, WidgetRef ref) {
//   return templateModel.fields
//       .where((f) => f.mainField)
//       .map(
//         (f) => DataColumn2(
//             label: TableHeaderLabel(
//                 label: getItemLocalString(f.label.unlock,
//                     defaultString: f.name)),
//             numeric: f.type?.isNumeric == true,
//             size: ColumnSize.M),
//       )
//       .toList();
// }
//
// DataColumn _getStatusColumn(WidgetRef ref) {
//   return DataColumn2(
//     label: TableHeaderLabel(label: S.current.status),
//     onSort: (i, asc) =>
//         ref.read(tablePaginationProvider.notifier).sort('syncStatus', i, asc),
//     size: ColumnSize.S,
//     fixedWidth: 70,
//   );
// }
//
// DataColumn _getEditColumn(WidgetRef ref) {
//   return DataColumn2(
//     label: TableHeaderLabel(label: S.current.edit),
//     size: ColumnSize.S,
//     fixedWidth: 80,
//   );
// }
//
// List<DataColumn> _getDatesColumn(WidgetRef ref) {
//   return [
//     DataColumn2(
//       label: TableHeaderLabel(label: S.current.created),
//       onSort: (i, asc) => ref
//           .read(tablePaginationProvider.notifier)
//           .sort('createdDate', i, asc),
//       size: ColumnSize.M,
//     ),
//     DataColumn2(
//       label: TableHeaderLabel(label: S.current.modified),
//       onSort: (i, asc) => ref
//           .read(tablePaginationProvider.notifier)
//           .sort('lastModifiedDate', i, asc),
//       size: ColumnSize.M,
//     ),
//   ];
// }

// int? _getSortIndex(String? sortColumn) {
//   if (sortColumn == null) return null;
//
// }
}
//
// class _TableSource extends DataTableSource {
//   _TableSource({
//     required this.state,
//     required this.templateModel,
//     this.onEdit,
//     this.onSelectedItem,
//     this.onFailedSyncClicked,
//   });
//
//   final TableState state;
//   final FormTemplateModel templateModel;
//   final Function(String submission)? onSelectedItem;
//   final Function(SubmissionSummary submission)? onEdit;
//   final Function(SubmissionSummary submission)? onFailedSyncClicked;
//
//   @override
//   DataRow? getRow(int index) {
//     if (index >= state.items.length) return null;
//     final item = state.items[index];
//     return DataRow(
//       selected: state.selectedIds.contains(item.id),
//       onSelectChanged: (_) => onSelectedItem?.call(item.id),
//       cells: [
//         _getStatusCell(item),
//         _getEditCell(item),
//         ..._getFieldsCells(item),
//         ..._getDateCells(item),
//       ],
//     );
//   }
//
//   DataCell _getStatusCell(SubmissionSummary d) {
//     return DataCell(StatusCell(
//         id: d.id,
//         onTap: d.syncStatus.isSyncFailed
//             ? () => onFailedSyncClicked?.call(d)
//             : null));
//   }
//
//   DataCell _getEditCell(SubmissionSummary d) {
//     return DataCell(ActionCell(
//       onPressed: () => onEdit?.call(d),
//       icon: Icon(Icons.edit_document),
//     ));
//   }
//
//   List<DataCell> _getFieldsCells(SubmissionSummary d) {
//     return templateModel.fields
//         .where((f) => f.mainField)
//         .map((f) => DataCell(Center(
//               child: SubmissionTableCell(
//                 fieldValue: d.formData.get(f.name!),
//               ),
//             )))
//         .toList();
//   }
//
//   List<DataCell> _getDateCells(SubmissionSummary d) {
//     return [
//       DataCell(DateCell(
//           date: d.createdDate != null
//               ? DateHelper.formatForUi(d.createdDate!, includeTime: true)
//               : null)),
//       DataCell(DateCell(
//           date: d.lastModifiedDate != null
//               ? DateHelper.formatForUi(d.lastModifiedDate!, includeTime: true)
//               : null)),
//     ];
//   }
//
//   @override
//   int get rowCount => state.items.length;
//
//   @override
//   bool get isRowCountApproximate => false;
//
//   @override
//   int get selectedRowCount => state.selectedIds.length;
// }
