import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_label_with_icon.dart';
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
    // final activityModel = ActivityInheritedWidget.of(context);
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
            // CardHeaderRow(),
            // const SizedBox(height: 8),
            _buildEntityInfo(assignment, searchQuery, context),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SyncStatusBadgesView(
                  assignmentId: assignment.id,
                ),
                _buildActionButtons(context, assignment, ref),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 5.0),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message: S.of(context).openNewForm,
                  child: IconButton(
                    visualDensity: VisualDensity.standard,
                    onPressed: assignment.availableForms.isNotEmpty
                        ? () async {
                            await showFormSelectionBottomSheet(
                                context, assignment.id);
                          }
                        : null,
                    // enableFeedback: true,
                    icon: const Icon(Icons.document_scanner),
                    // label: Text(S.of(context).openNewForm),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shadowColor: Theme.of(context).colorScheme.shadow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10.0),
                    ),
                  ),
                ),
                CardHeaderRow(
                  showIcon: false,
                ),
              ],
            ),
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
        HighlightedByValueLabel(
            '${assignment.orgUnit.code ?? ''}: ${assignment.orgUnit.name}',
            searchQuery,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context, AssignmentModel assignment, WidgetRef ref) {
    return OverflowBar(
      spacing: 8,
      overflowSpacing: 8,
      overflowAlignment: OverflowBarAlignment.start,
      children: [
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
  const CardHeaderRow({this.showIcon = true});

  final bool showIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery =
        ref.watch(filterQueryProvider.select((value) => value.searchQuery));
    // final activityModel = ActivityInheritedWidget.of(context);
    final assignment = ref.watch(assignmentProvider);
    final List<Pair<AssignmentForm, bool>> userForms = assignment.userForms;
    final List<Pair<AssignmentForm, bool>> availableLocally =
        assignment.availableForms;

    return HighlightedLabelWithIcon(
      showIcon ? Icons.document_scanner : null,
      availableLocally.length == userForms.length
          ? '(${S.of(context).form(availableLocally.length)})'
          : '(${availableLocally.length}/${S.of(context).form(userForms.length)})',
      searchQuery,
    );
  }
}
