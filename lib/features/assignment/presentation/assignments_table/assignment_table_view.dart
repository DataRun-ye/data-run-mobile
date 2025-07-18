import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/org_unit_display.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/team_display.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
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
    return DataTable2(
      minWidth: 1200,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      showBottomBorder: true,
      showCheckboxColumn: false,
      columns: <DataColumn>[
        DataColumn2(label: Text(S.current.synced), size: ColumnSize.S),
        DataColumn2(label: Text(S.current.entity), size: ColumnSize.L),
        DataColumn2(label: Text(S.current.team), size: ColumnSize.S),
      ],
      rows: assignments.values
          .map((assignment) => DataRow2(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return statusColor(assignment.status);
                  },
                ),
                cells: <DataCell>[
                  DataCell(
                    SyncStatusBadgesView(
                        id: assignment.id,
                        aggregationLevel: StatusAggregationLevel.assignment),
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
