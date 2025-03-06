import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarun/core/common/state.dart';
import 'package:datarun/data_run/d_activity/activity_card.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/assignment_detail/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';
import 'package:datarun/data_run/d_assignment/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/build_highlighted_text.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/d_form_submission/submission_count_chips/submission_count_chips.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AssignmentOverviewItem extends ConsumerWidget {
  const AssignmentOverviewItem({
    super.key,
    required this.onViewDetails,
  });

  final Function(AssignmentModel assignment) onViewDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery =
        ref.watch(filterQueryProvider.select((value) => value.searchQuery));
    final activityModel = ActivityInheritedWidget.of(context);
    final assignment = ref.watch(assignmentProvider);

    return Card(
      color: getCardColor(assignment.status, Theme.of(context)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Name, Status Badge, Due Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: buildHighlightedText(
                    assignment.activity,
                    searchQuery,
                    context,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                buildStatusBadge(assignment.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailIcon(
                  Icons.assignment,
                  Intl.message(assignment.scope.name.toLowerCase()),
                  searchQuery,
                  context,
                ),
                if (assignment.dueDate != null && assignment.startDate != null)
                  _buildDueInfo(context, assignment),
              ],
            ),
            const SizedBox(height: 8),

            // Entity and Team Info
            CopyToClipboard(
              value: assignment.entityCode,
              child: _buildDetailIcon(
                Icons.location_on,
                '${assignment.entityCode} - ${assignment.entityName}',
                searchQuery,
                context,
              ),
            ),
            const SizedBox(height: 4),
            _buildDetailIcon(
              Icons.group,
              '${S.of(context).team}: ${assignment.teamCode}',
              searchQuery,
              context,
            ),
            const SizedBox(height: 8),

            // Counts Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  CountChip(syncStatus: SyncStatus.SYNCED),
                  const SizedBox(width: 8),
                  CountChip(syncStatus: SyncStatus.TO_POST),
                  const SizedBox(width: 8),
                  CountChip(syncStatus: SyncStatus.TO_UPDATE)
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Resources
            if (assignment.allocatedResources.isNotEmpty ||
                assignment.reportedResources.isNotEmpty)
              ResourcesComparisonWidget(
                headerStyle: Theme.of(context).textTheme.bodySmall,
                bodyStyle: Theme.of(context).textTheme.bodySmall,
              ),
            // Actions
            const Divider(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await showFormSelectionBottomSheet(
                          context, assignment, activityModel);
                      ref.invalidate(assignmentsProvider);
                    },
                    icon: const Icon(Icons.document_scanner),
                    label: Text(
                        '${S.of(context).openNewForm} (${assignment.forms.length})'),
                  ),
                  TextButton.icon(
                    onPressed: () => onViewDetails.call(assignment),
                    icon: const Icon(Icons.info_outline),
                    label: Text(S.of(context).viewDetails),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? getCardColor(AssignmentStatus status, ThemeData theme) {
    switch (status) {
      case AssignmentStatus.NOT_STARTED:
      case AssignmentStatus.RESCHEDULED:
        return theme.cardColor.withOpacity(0.5);
      case AssignmentStatus.DONE:
        return theme.cardColor;
      case AssignmentStatus.IN_PROGRESS:
        return Colors.greenAccent.withOpacity(0.2);

      case AssignmentStatus.MERGED:
      case AssignmentStatus.REASSIGNED:
      case AssignmentStatus.CANCELLED:
        return Colors.orangeAccent.withOpacity(0.2);
    }
  }

  // Widget _buildCountChip(BuildContext context,
  //     {required Widget icon, required String label}) {
  //   return Chip(
  //     avatar: icon,
  //     //Icon(icon, size: 18, color: Theme.of(context).primaryColor),
  //     label: Text(label, style: Theme.of(context).textTheme.bodySmall),
  //     backgroundColor: Theme.of(context).chipTheme.backgroundColor,
  //   );
  // }

  Widget _buildDueInfo(BuildContext context, AssignmentModel assignment) {
    final isOverdue = assignment.dueDate!.isBefore(DateTime.now());
    return Row(
      children: [
        Icon(Icons.calendar_today,
            size: 16, color: isOverdue ? Colors.red : Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          formatDate(assignment.dueDate!, context),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isOverdue ? Colors.red : Colors.grey[700],
              ),
        ),
        if (assignment.startDay != null) ...[
          const VerticalDivider(width: 5),
          Text(
            '|',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isOverdue ? Colors.red : Colors.grey[700],
                ),
          ),
          const VerticalDivider(width: 5),
          Text(
            '${S.of(context).day} ${assignment.startDay}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isOverdue ? Colors.red : Colors.grey[700],
                ),
          ),
        ]
      ],
    );
  }

  Widget _buildDetailIcon(
      IconData icon, String value, String searchQuery, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 4),
        buildHighlightedText(value, searchQuery, context),
      ],
    );
  }

  // Widget _buildHighlightedText(
  //     String text, String searchQuery, BuildContext context,
  //     {TextStyle? style}) {
  //   if (searchQuery.isEmpty) {
  //     return Text(text, softWrap: true);
  //   }
  //
  //   final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);
  //   if (matches.isEmpty) {
  //     return Text(text, softWrap: true);
  //   }
  //
  //   final List<TextSpan> spans = [];
  //   int start = 0;
  //
  //   for (final match in matches) {
  //     if (match.start > start) {
  //       spans.add(TextSpan(text: text.substring(start, match.start)));
  //     }
  //     spans.add(TextSpan(
  //       text: text.substring(match.start, match.end),
  //       style: TextStyle(backgroundColor: Theme.of(context).primaryColorLight)
  //           .merge(style),
  //     ));
  //     start = match.end;
  //   }
  //
  //   if (start < text.length) {
  //     spans.add(TextSpan(text: text.substring(start)));
  //   }
  //
  //   return RichText(
  //     text:
  //         TextSpan(style: DefaultTextStyle.of(context).style, children: spans),
  //   );
  // }

// Widget _buildHighlightedText(
//     String text, String searchQuery, BuildContext context,
//     {TextStyle? style}) {
//   if (searchQuery.isEmpty) {
//     return Text(text, softWrap: true);
//   }
//
//   final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);
//   if (matches.isEmpty) {
//     return Text(text, softWrap: true);
//   }
//
//   final List<TextSpan> spans = [];
//   int start = 0;
//
//   for (final match in matches) {
//     if (match.start > start) {
//       spans.add(TextSpan(text: text.substring(start, match.start)));
//     }
//     spans.add(TextSpan(
//       text: text.substring(match.start, match.end),
//       style: TextStyle(backgroundColor: Colors.yellow).merge(style),
//     ));
//     start = match.end;
//   }
//
//   if (start < text.length) {
//     spans.add(TextSpan(text: text.substring(start)));
//   }
//
//   return RichText(
//     text:
//         TextSpan(style: DefaultTextStyle.of(context).style, children: spans),
//   );
// }

// Widget _buildResourcesComparison(BuildContext context) {
//   // Enhanced resource comparison layout
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: assignment.allocatedResources.keys.map((key) {
//       final allocated = assignment.allocatedResources[key] ?? 0;
//       final reported = assignment.reportedResources[key.toLowerCase()] ?? 0;
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(Intl.message(key.toLowerCase()),
//               style: Theme.of(context).textTheme.bodySmall),
//           Text(
//             '$reported / $allocated',
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//         ],
//       );
//     }).toList(),
//   );
// }

// Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               )
//
// Theme.of(context).textTheme.bodySmall)
}

class ResourcesComparisonWidget extends ConsumerWidget {
  const ResourcesComparisonWidget(
      {super.key, this.headerStyle, this.bodyStyle});

  final TextStyle? headerStyle;
  final TextStyle? bodyStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignment = ref.watch(assignmentProvider);
    // final reportedResourcesAsync = ref.watch(reportedResourcesProvider());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).resources,
          style: headerStyle,
        ),
        ...assignment.reportedResources.keys.map((key) {
          final allocated = assignment.reportedResources[key] ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Intl.message(key.toLowerCase()),
                  style: bodyStyle,
                ),
                SizedBox(width: 30,),
                Text(
                  '${assignment.allocatedResources[key.toLowerCase()] ?? 0} / $allocated',
                  style: bodyStyle?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        }).toList()
      ],
    );
  }
}
