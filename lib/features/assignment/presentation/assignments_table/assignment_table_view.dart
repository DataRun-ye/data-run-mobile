import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/org_unit_display.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/team_display.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_page.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
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
        final assignmentsMap = Map<String, AssignmentModel>.fromIterable(
            assignments,
            key: (assignment) => assignment.id,
            value: (assignment) =>
                assignments.firstWhere((a) => a.id == assignment.id));
        return _buildTable(context, assignmentsMap, searchQuery);
      },
    );
  }

  num calculateColumnSum(List<Map<String, dynamic>> rows, String colIndex) {
    return rows.fold(0,
        (sum, row) => sum + (row[colIndex] is num ? row[colIndex] as num : 0));
  }

  Widget _buildTable(BuildContext context,
      Map<String, AssignmentModel> assignments, String searchQuery) {
    final cols = <DataColumn>[
      DataColumn2(label: Text(S.current.openNewForm), size: ColumnSize.S),
      DataColumn2(label: Text(S.current.synced), size: ColumnSize.M),
      DataColumn2(label: Text(S.current.entity), size: ColumnSize.L),
      DataColumn2(label: Text(S.current.team), size: ColumnSize.S),
    ];
    final minTableWidth = (cols.length * 170.0);

    return DataTable2(
      minWidth: minTableWidth,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      showBottomBorder: true,
      showCheckboxColumn: false,
      columns: cols,
      rows: assignments.values
          .map((assignment) => DataRow(
                // color: WidgetStateProperty.resolveWith<Color?>(
                //   (Set<WidgetState> states) {
                //     return statusColor(assignment.status);
                //   },
                // ),
                cells: <DataCell>[
                  DataCell(IconButton(
                      visualDensity: VisualDensity.comfortable,
                      onPressed: assignment.availableForms.isNotEmpty
                          ? () async {
                              await showFormSelectionBottomSheet(
                                  context, assignment.id);
                            }
                          : null,
                      icon: const Icon(Icons.document_scanner),
                      // label: Text(S.of(context).openNewForm),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shadowColor: Theme.of(context).colorScheme.shadow,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ))),
                  DataCell(
                    SyncStatusBadgesView(
                        assignmentId: assignment.id),
                  ),
                  DataCell(OrgUnitDisplay(
                      orgUnit: assignment.orgUnit, highlightText: searchQuery)),
                  DataCell(TeamDisplay(team: assignment.team)),
                ],
                onSelectChanged: (_) => onViewDetails(assignment),
              ))
          .toList(),
    );
  }
}
