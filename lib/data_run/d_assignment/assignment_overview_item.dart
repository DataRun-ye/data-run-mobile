import 'package:d2_remote/modules/datarun_shared/utilities/team_form_permission.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarunmobile/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarunmobile/commons/helpers/collections.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/data.dart';
import 'package:datarunmobile/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarunmobile/data_run/d_activity/activity_model.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/assignment_detail_page.dart';
import 'package:datarunmobile/data_run/d_assignment/build_highlighted_text.dart';
import 'package:datarunmobile/data_run/d_assignment/build_status.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/data_run/d_form_submission/submission_count_chips/submission_count_chips.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
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
    final List<Pair<TeamFormPermission, bool>> userForms = assignment.userForms;
    final List<Pair<TeamFormPermission, bool>> availableLocally =
        assignment.availableForms;

    return Card(
      color: getCardColor(assignment.status, Theme.of(context)),
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeaderRow(),
            const SizedBox(height: 8),
            _buildEntityInfo(assignment, searchQuery, context),
            const SizedBox(height: 8),
            _buildCountChips(),
            const Divider(height: 5.0),
            _buildActionButtons(context, assignment, activityModel, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildEntityInfo(
      AssignmentModel assignment, String searchQuery, BuildContext context) {
    return CopyToClipboard(
      value: assignment.entityCode,
      children: [
        const Icon(Icons.location_on),
        const SizedBox(width: 4),
        BuildHighlightedText(assignment.entityCode, searchQuery,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(width: 8),
        BuildHighlightedText(assignment.entityName, searchQuery)
      ],
    );
  }

  Widget _buildCountChips() {
    return Wrap(
      alignment: WrapAlignment.end,
      children: const [
        CountChip(syncStatus: SyncStatus.SYNCED),
        SizedBox(width: 2),
        CountChip(syncStatus: SyncStatus.TO_POST),
        SizedBox(width: 2),
        CountChip(syncStatus: SyncStatus.TO_UPDATE),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, AssignmentModel assignment,
      ActivityModel activityModel, WidgetRef ref) {
    return OverflowBar(
      spacing: 8,
      overflowSpacing: 8,
      overflowAlignment: OverflowBarAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: assignment.availableForms.isNotEmpty
              ? () async {
                  await showFormSelectionBottomSheet(
                      context, assignment, activityModel);
                  ref.invalidate(assignmentsProvider);
                }
              : null,
          icon: const Icon(Icons.document_scanner),
          label: Text(S.of(context).openNewForm),
        ),
        TextButton.icon(
          onPressed: () => onViewDetails.call(assignment),
          icon: const Icon(Icons.info_outline),
          label: Text(S.of(context).viewDetails),
        ),
      ],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: assignment.reportedResources.keys.map((key) {
            final allocated = assignment.reportedResources[key] ?? 0;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Intl.message(key.toLowerCase()),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${assignment.allocatedResources[key.toLowerCase()] ?? 0} / $allocated',
                    style: bodyStyle?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _CardHeaderRow extends ConsumerWidget {
  const _CardHeaderRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery =
        ref.watch(filterQueryProvider.select((value) => value.searchQuery));
    final activityModel = ActivityInheritedWidget.of(context);
    final assignment = ref.watch(assignmentProvider);
    final List<Pair<TeamFormPermission, bool>> userForms = assignment.userForms;
    final List<Pair<TeamFormPermission, bool>> availableLocally =
        assignment.availableForms;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OverflowBar(
            spacing: 32,
            overflowSpacing: 4,
            children: [
              DetailRowWithIcon(
                  Icons.assignment,
                  Intl.message(assignment.scope.name.toLowerCase()),
                  searchQuery),
              DetailRowWithIcon(Icons.group,
                  '${S.of(context).team}: ${assignment.teamCode}', searchQuery),
              DetailRowWithIcon(
                Icons.document_scanner,
                availableLocally.length == userForms.length
                    ? '(${S.of(context).form(availableLocally.length)})'
                    : '(${availableLocally.length}/${S.of(context).form(userForms.length)})',
                searchQuery,
              ),
            ],
          ),
        ),
        buildStatusBadge(assignment.status),
      ],
    );
  }
}

class DetailRowWithIcon extends StatelessWidget {
  const DetailRowWithIcon(
    this.icon,
    this.text,
    this.searchQuery, {
    super.key,
    this.style,
  });

  final IconData? icon;
  final String text;

  final String searchQuery;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      spacing: 2,
      overflowSpacing: 2,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 4),
        BuildHighlightedText(text, searchQuery, style: style)
      ],
    );
  }
}
