import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/home/form_template/application/form_list_filter.dart';
import 'package:datarunmobile/home/form_template/domain/model/form_list_item_model.dart';
import 'package:datarunmobile/home/form_template/application/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FormTemplatesScreen extends ConsumerWidget {
  const FormTemplatesScreen({super.key, required this.filters});

  final FormListFilter filters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formList = ref.watch(formListProvider(filters));
    return Scaffold(
      appBar: AppBar(title: const Text('Submissions')),
      body: AsyncValueWidget(
        value: formList,
        valueBuilder: (List<FormListItemModel> items) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final formItem = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Slidable(
                  key: ValueKey(formItem.id),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.5,
                    children: [
                      SlidableAction(
                        onPressed: (_) => onMarkFinal(context, formItem),
                        icon: Icons.check_circle,
                        label: 'Mark Final',
                        backgroundColor: Colors.indigo,
                      ),
                      SlidableAction(
                        onPressed: (_) => onSubmit(context, formItem),
                        icon: Icons.cloud_upload,
                        label: 'Submit',
                        backgroundColor: Colors.teal,
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        onPressed: (_) => onDelete(context, formItem),
                        icon: Icons.delete,
                        label: 'Delete',
                        backgroundColor: Colors.red.shade400,
                      ),
                    ],
                  ),
                  child: SubmissionCard(formItem: formItem),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onMarkFinal(BuildContext context, FormListItemModel submission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Marked "${submission.displayLabel}" as Final')),
    );
  }

  void onSubmit(BuildContext context, FormListItemModel submission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Submitted "${submission.displayLabel}"')),
    );
  }

  void onDelete(BuildContext context, FormListItemModel submission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted "${submission.displayLabel}"')),
    );
  }
}

class SubmissionCard extends StatelessWidget {
  final FormListItemModel formItem;

  const SubmissionCard({super.key, required this.formItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metadataStyle =
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formItem.displayLabel, style: theme.textTheme.titleMedium),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('v${formItem.versionNumber}', style: metadataStyle),
                ),
              ],
            ),

            const SizedBox(height: 8),

            SyncStatusBadgesView(
              aggregationLevel: StatusAggregationLevel.form,
              id: formItem.id,
            ),
            // Metadata Row
            // Wrap(
            //   spacing: 16,
            //   runSpacing: 8,
            //   children: [
            //     // _metadataChip(Icons.location_on, formItem.orgUnit),
            //     // _metadataChip(Icons.timeline, formItem.progress),
            //     // _metadataChip(Icons.access_time,
            //     //     '${formItem.submittedAt.hour.toString().padLeft(2, '0')}:${formItem.submittedAt.minute.toString().padLeft(2, '0')}'),
            //     // _metadataChip(Icons.sync, formItem.syncStatus.name,
            //     //     bgColor: _statusColor(formItem.syncStatus.name)),
            //   ],
            // ),

            // const SizedBox(height: 12),
            //
            // // Shown Fields (up to 3)
            // if (formItem.dataValues.isNotEmpty)
            //   Wrap(
            //     spacing: 12,
            //     runSpacing: 8,
            //     children: formItem.dataValues
            //         .take(3)
            //         .map((e) => _dataElementChip(e.label, e.value))
            //         .toList(),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _metadataChip(IconData icon, String label, {Color? bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
        ],
      ),
    );
  }

  Widget _dataElementChip(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$key: $value',
          style: const TextStyle(fontSize: 13, color: Colors.black87)),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.green.shade100;
      case 'final':
        return Colors.orange.shade100;
      case 'draft':
        return Colors.grey.shade300;
      default:
        return Colors.grey.shade200;
    }
  }
}
