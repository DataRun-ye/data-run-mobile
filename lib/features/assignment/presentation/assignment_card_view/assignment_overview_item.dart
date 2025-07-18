import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_label_with_icon.dart';
import 'package:datarunmobile/features/activity/presentation/activity_inherited_widget.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_page.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
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
            CardHeaderRow(),
            const SizedBox(height: 8),
            _buildEntityInfo(assignment, searchQuery, context),
            const SizedBox(height: 8),
            SyncStatusBadgesView(
              id: assignment.id,
              aggregationLevel: StatusAggregationLevel.assignment,
            ),
            const SizedBox(height: 8),

            const Divider(height: 5.0),
            const SizedBox(height: 4),
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
        HighlightedByValueLabel('${assignment.orgUnit.code ?? ''}: ${assignment.orgUnit.name}', searchQuery,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        // const SizedBox(width: 8),
        // HighlightedByValueLabel(assignment.orgUnit.name, searchQuery)
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

class CardHeaderRow extends ConsumerWidget {
  const CardHeaderRow();

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
              HighlightedLabelWithIcon(
                Icons.document_scanner,
                availableLocally.length == userForms.length
                    ? '(${S.of(context).form(availableLocally.length)})'
                    : '(${availableLocally.length}/${S.of(context).form(userForms.length)})',
                searchQuery,
              ),
            ],
          ),
        ),
        // buildStatusBadge(assignment.status),
      ],
    );
  }
}
