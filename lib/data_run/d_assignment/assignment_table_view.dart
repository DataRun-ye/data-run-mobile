import 'package:collection/collection.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/common/state.dart';
import 'package:datarun/data_run/d_assignment/build_highlighted_text.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/d_assignment/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';
import 'package:datarun/data_run/d_form_submission/submission_count_chips/submission_count_chips.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AssignmentTableView extends HookConsumerWidget {
  AssignmentTableView({super.key, required this.onViewDetails, this.scope});

  final void Function(AssignmentModel) onViewDetails;
  final EntityScope? scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider(scope));
    final searchQuery = ref.watch(filterQueryProvider).searchQuery;
    final horizontalScrollController = useScrollController();
    final verticalScrollController = useScrollController();
    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        final resourceHeaders =
            assignments.firstOrNull?.reportedResources.keys.toList() ?? [];
        final rows = assignments.map((t) => t.reportedResources).toList();
        final totalSummary = {
          for (var i in resourceHeaders) i: calculateColumnSum(rows, i)
        };
        return _buildTable(
            context, assignments, searchQuery, resourceHeaders, totalSummary);
        // Column(
        //   children: [
        //     _buildTable(context, assignments, searchQuery,
        //         resourceHeaders, totalSummary),
        //     SingleChildScrollView(
        //       scrollDirection: Axis.horizontal,
        //       child: Row(
        //         children: totalSummary.keys
        //             .map((key) => Card(
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Text('$key: ${totalSummary[key] ?? 0}'),
        //                   ),
        //                 ))
        //             .toList(),
        //       ),
        //     )
        //   ],
        // );
      },
    );
  }

  num calculateColumnSum(List<Map<String, dynamic>> rows, String colIndex) {
    return rows.fold(0,
        (sum, row) => sum + (row[colIndex] is num ? row[colIndex] as num : 0));
  }

  Widget _buildTable(
    BuildContext context,
    List<AssignmentModel> assignments,
    String searchQuery,
    List<String> resourceHeaders,
    Map<String, Object> totalSummary,
  ) {
    return DataTable2(
      minWidth: 1200,
      // scrollController: vController,
      // horizontalScrollController: hController,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      showBottomBorder: true,
      showCheckboxColumn: false,
      columns: <DataColumn>[
        DataColumn2(label: Text(S.current.dueDay), size: ColumnSize.S),
        DataColumn2(label: Text(S.current.status), size: ColumnSize.S),
        DataColumn2(label: Text(S.current.entity), size: ColumnSize.L),
        DataColumn2(label: Text(S.current.team), size: ColumnSize.S),
        ...resourceHeaders
            .map((header) => DataColumn2(
                numeric: true,
                label: Column(
                  children: [
                    Text('|${totalSummary[header]}|'),
                    Text(
                      '${Intl.message(header.toLowerCase())} ${S.of(context).reported}',
                    ),
                  ],
                ),
                size: ColumnSize.S))
            .toList(),
        DataColumn2(label: Text(S.current.scope), size: ColumnSize.S),
        DataColumn2(label: Text(S.current.status)),
      ],
      rows: assignments
          .map((assignment) => DataRow2(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return statusColor(assignment.status);
                  },
                ),
                cells: <DataCell>[
                  DataCell(buildHighlightedText(
                      '${assignment.startDay != null ? S.of(context).day : ''} ${assignment.startDay ?? ''}',
                      searchQuery,
                      context)),
                  DataCell(buildStatusBadge(assignment.status)),
                  DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHighlightedText(
                            '${assignment.entityCode}', searchQuery, context),
                        buildHighlightedText(
                            '${assignment.entityName}', searchQuery, context)
                      ])),
                  DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.group),
                        Text('${assignment.teamCode}'),
                        // SizedBox(width: 4),
                      ])),
                  ...resourceHeaders.map((header) {
                    return DataCell(Text(
                      assignment.reportedResources[header.toLowerCase()]
                              ?.toString() ??
                          '-',
                    ));
                  }),
                  DataCell(
                      Text(Intl.message(assignment.scope.name.toLowerCase()))),
                  DataCell(ProviderScope(
                    overrides: [
                      assignmentProvider.overrideWithValue(assignment)
                    ],
                    child: Wrap(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // const SizedBox(width: 2),
                        const CountChip(syncStatus: SyncStatus.SYNCED),
                        // const SizedBox(width: 2),
                        const CountChip(syncStatus: SyncStatus.TO_POST),
                        // const SizedBox(width: 2),
                        const CountChip(syncStatus: SyncStatus.TO_UPDATE)
                      ],
                    ),
                  )),
                ],
                onSelectChanged: (_) => onViewDetails(assignment),
              ))
          .toList(),
    );
  }
}
