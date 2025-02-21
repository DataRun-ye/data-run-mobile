import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/d_assignment/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AssignmentTableView extends HookConsumerWidget {
  AssignmentTableView({super.key, required this.onViewDetails, this.scope});

  final void Function(AssignmentModel) onViewDetails;
  final EntityScope? scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider(scope));
    final searchQuery = ref.watch(filterQueryProvider).searchQuery;

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return _buildTable(context, assignments, searchQuery);
      },
    );
  }

  Widget _buildTable(BuildContext context, List<AssignmentModel> assignments,
      String searchQuery) {
    Map<String, dynamic>? allocatedHeaders =
        assignments.firstOrNull?.allocatedResources;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: DataTable(
          showCheckboxColumn: false,
          columns: <DataColumn>[
            DataColumn(label: Text(S.current.dueDay)),
            DataColumn(label: Text(S.current.status)),
            DataColumn(label: Text(S.current.entity)),
            DataColumn(label: Text(S.current.team)),
            if (allocatedHeaders != null)
              ...allocatedHeaders.entries
                  .map((entry) => DataColumn(
                          label: Text(
                        Intl.message(entry.key.toLowerCase()),
                      )))
                  .toList(),
            if (allocatedHeaders != null)
              ...allocatedHeaders.entries
                  .map((entry) => DataColumn(
                          label: Text(
                        '${Intl.message(entry.key.toLowerCase())} ${S.of(context).reported}',
                      )))
                  .toList(),
            DataColumn(label: Text(S.current.scope)),
            DataColumn(label: Text(S.current.dueDate)),
            DataColumn(label: Text(S.current.rescheduled)),
          ],
          rows: assignments
              .map((assignment) => DataRow(
                    color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        return statusColor(assignment.status);
                      },
                    ),
                    cells: <DataCell>[
                      DataCell(_buildHighlightedText(
                          '${S.of(context).day} ${assignment.startDay}',
                          searchQuery)),
                      DataCell(buildStatusBadge(assignment.status)),
                      DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHighlightedText(
                                '${assignment.entityCode}', searchQuery),
                            _buildHighlightedText(
                                '${assignment.entityName}', searchQuery)
                          ])),
                      DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.group),
                            Text('${assignment.teamCode}'),
                            // SizedBox(width: 4),
                          ])),
                      if (allocatedHeaders != null)
                        ...assignment.allocatedResources.entries
                            .map((entry) => DataCell(Text(
                                  entry.value?.toString() ?? '-',
                                ))),
                      if (allocatedHeaders != null)
                        ...assignment.allocatedResources.keys
                            .map((key) => DataCell(Text(
                                  assignment
                                          .reportedResources[key.toLowerCase()]
                                          ?.toString() ??
                                      '-',
                                ))),
                      DataCell(Text(
                          Intl.message(assignment.scope.name.toLowerCase()))),
                      DataCell(Text(assignment.dueDate != null
                          ? DateHelper.formatForUi(assignment.dueDate!)
                          : '')),
                      DataCell(Text(assignment.rescheduledDate != null
                          ? DateHelper.formatForUi(
                              (assignment.rescheduledDate!))
                          : '')),
                    ],
                    onSelectChanged: (_) => onViewDetails(assignment),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String searchQuery) {
    if (searchQuery.isEmpty) {
      return Text(text);
    }

    final lowerCaseText = text.toLowerCase();
    final lowerCaseQuery = searchQuery.toLowerCase();
    final startIndex = lowerCaseText.indexOf(lowerCaseQuery);

    if (startIndex == -1) {
      return Text(text);
    }

    final endIndex = startIndex + searchQuery.length;
    final highlightedText = TextSpan(
      text: text.substring(0, startIndex),
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(
          text: text.substring(startIndex, endIndex),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: text.substring(endIndex),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );

    return RichText(text: highlightedText);
  }
}
