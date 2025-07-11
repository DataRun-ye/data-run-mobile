import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarunmobile/data/data.dart';
import 'package:datarunmobile/features/activity/presentation/activity_inherited_widget.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_page.dart';
import 'package:datarunmobile/features/assignment/presentation/build_highlighted_text.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form_submission/presentation/submission_count_chips.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final List<Pair<AssignmentForm, bool>> userForms = assignment.userForms;
    final List<Pair<AssignmentForm, bool>> availableLocally =
        assignment.availableForms;

    return Card(
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
      value: assignment.orgUnit.code,
      children: [
        const Icon(Icons.location_on),
        const SizedBox(width: 4),
        BuildHighlightedText(assignment.orgUnit.code!, searchQuery,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(width: 8),
        BuildHighlightedText(assignment.orgUnit.code!, searchQuery)
      ],
    );
  }

  Widget _buildCountChips() {
    return Wrap(
      alignment: WrapAlignment.end,
      children: const [
        CountChip(syncStatus: InstanceSyncStatus.synced),
        SizedBox(width: 2),
        CountChip(syncStatus: InstanceSyncStatus.finalized),
        SizedBox(width: 2),
        CountChip(syncStatus: InstanceSyncStatus.draft)
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
            // style: Theme.of(context).buttonTheme,
            onPressed: assignment.availableForms.isNotEmpty
                ? () async {
                    await showFormSelectionBottomSheet(
                        context, assignment, activityModel);
                    ref.invalidate(assignmentsProvider);
                  }
                : null,
            icon: const Icon(Icons.document_scanner),
            label: Text(S.of(context).openNewForm),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shadowColor: Theme.of(context).colorScheme.shadow,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            )),
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
      case AssignmentStatus.PLANNED:
      case AssignmentStatus.RESCHEDULED:
        return theme.cardColor.withValues(alpha: 0.5);
      case AssignmentStatus.DONE:
        return theme.cardColor;
      case AssignmentStatus.IN_PROGRESS:
        return Colors.greenAccent.withValues(alpha: 0.2);

      case AssignmentStatus.MERGED:
      case AssignmentStatus.REASSIGNED:
      case AssignmentStatus.CANCELLED:
        return Colors.orangeAccent.withValues(alpha: 0.2);
    }
  }
}

class _CardHeaderRow extends ConsumerWidget {
  const _CardHeaderRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery =
        ref.watch(filterQueryProvider.select((value) => value.searchQuery));
    final activityModel = ActivityInheritedWidget.of(context);
    final assignment = ref.watch(assignmentProvider);
    final List<Pair<AssignmentForm, bool>> userForms = assignment.userForms;
    final List<Pair<AssignmentForm, bool>> availableLocally =
        assignment.availableForms;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OverflowBar(
            spacing: 8,
            overflowSpacing: 2,
            children: [
              // DetailRowWithIcon(Icons.group,
              //     '${S.of(context).team}: ${assignment.teamCode}', searchQuery),
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
