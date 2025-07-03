import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarunmobile/data_run/d_assignment/build_highlighted_text.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignmentTile extends ConsumerWidget {
  const AssignmentTile({
    required this.assignment,
    super.key,
    this.onViewDetails,
  });

  final AssignmentModel assignment;
  final Function(String assignmentUid)? onViewDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailIcon(
                  Icons.group,
                  '${S.of(context).team}: ${assignment.team.code}',
                  null,
                  context,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Entity and Team Info
            CopyToClipboard(
              value: assignment.orgUnit.code,
              child: _buildDetailIcon(
                  Icons.location_on,
                  '${assignment.orgUnit.code} - ${assignment.orgUnit.name}',
                  null,
                  context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailIcon(
      IconData icon, String value, String? searchQuery, BuildContext context,
      {TextStyle? style}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 4),
        QueryHighlightedText(text: value, style: style)
      ],
    );
  }
}
