import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/build_highlighted_text.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form_submission/presentation/submission_count_chips.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignmentTableView extends HookConsumerWidget {
  AssignmentTableView({super.key, required this.onViewDetails, this.scope});

  final void Function(AssignmentModel) onViewDetails;
  final EntityScope? scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider);
    final searchQuery = ref.watch(filterQueryProvider).searchQuery;
    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return _buildTable(context, assignments, searchQuery);
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
    // List<String> resourceHeaders,
    // Map<String, Object> totalSummary,
  ) {
    return DataTable2(
      minWidth: 1200,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      showBottomBorder: true,
      showCheckboxColumn: false,
      columns: <DataColumn>[
        DataColumn2(label: Text(S.current.dueDay), size: ColumnSize.S),
        DataColumn2(label: Text(S.current.synced), size: ColumnSize.S),
        DataColumn2(label: Text(S.current.entity), size: ColumnSize.L),
        DataColumn2(label: Text(S.current.status)),
        DataColumn2(label: Text(S.current.team), size: ColumnSize.S),
      ],
      rows: assignments
          .map((assignment) => DataRow2(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return statusColor(assignment.status);
                  },
                ),
                cells: <DataCell>[
                  DataCell(BuildHighlightedText(
                      '${assignment.startDay != null ? S.of(context).day : ''} ${assignment.startDay ?? ''}',
                      searchQuery)),
                  DataCell(ProviderScope(
                    overrides: [
                      assignmentProvider.overrideWithValue(assignment)
                    ],
                    child: const Wrap(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        CountChip(syncStatus: InstanceSyncStatus.synced),
                        CountChip(syncStatus: InstanceSyncStatus.finalized),
                        CountChip(syncStatus: InstanceSyncStatus.draft)
                      ],
                    ),
                  )),
                  DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildHighlightedText(
                            '${assignment.orgUnit.code}', searchQuery),
                        BuildHighlightedText(
                            '${assignment.orgUnit.name}', searchQuery)
                      ])),
                  // ...resourceHeaders.map((header) {
                  //   return DataCell(Text(
                  //     assignment.reportedResources[header.toLowerCase()]
                  //             ?.toString() ??
                  //         '-',
                  //   ));
                  // }),
                  DataCell(buildStatusBadge(assignment.status)),
                  DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.group),
                        Text('${assignment.team.code}'),
                        // SizedBox(width: 4),
                      ])),
                  // DataCell(
                  //     Text(Intl.message(assignment.scope.name.toLowerCase()))),
                ],
                onSelectChanged: (_) => onViewDetails(assignment),
              ))
          .toList(),
    );
  }
}
