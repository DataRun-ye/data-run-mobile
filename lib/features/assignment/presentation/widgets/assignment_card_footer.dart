import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class AssignmentCardButtonFooter extends StatelessWidget {
  const AssignmentCardButtonFooter(
      {super.key, this.count = 0, this.onViewDetails, this.onOpenNewForm});

  final VoidCallback? onOpenNewForm;
  final VoidCallback? onViewDetails;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: count > 0 ? onOpenNewForm : null,
            icon: const Icon(Icons.document_scanner),
            label: Text('${S.of(context).openNewForm} (${count})'),
          ),
          TextButton.icon(
            onPressed: count > 0 ? onViewDetails : null,
            icon: const Icon(Icons.info_outline),
            label: Text(S.of(context).viewDetails),
          ),
        ],
      ),
    );
  }
}
