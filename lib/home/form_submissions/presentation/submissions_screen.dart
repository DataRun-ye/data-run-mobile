import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/home/form_submissions/application/form_submission.provider.dart';
import 'package:datarunmobile/home/form_submissions/presentation/submission_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SubmissionsScreen extends ConsumerWidget {
  const SubmissionsScreen({
    super.key,
    this.activity,
    required this.formId,
    this.assignmentId,
  });

  final String formId;
  final String? activity;
  final String? assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submissionsAsync = ref.watch(formSubmissionsProvider(
        formId: formId, filter: SubmissionsFilter(assignment: assignmentId)));

    return Scaffold(
      appBar: AppBar(title: const Text('Submissions')),
      body: AsyncValueWidget(
        value: submissionsAsync,
        valueBuilder: (List<SubmissionSummary> submissions) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: submissions.length,
            itemBuilder: (context, index) {
              final submission = submissions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Slidable(
                  key: ValueKey(
                      '${submission.form.displayLabel}-${submission.submittedAt}'),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.5,
                    children: [
                      SlidableAction(
                        onPressed: (_) => onMarkFinal(context, submission),
                        icon: Icons.check_circle,
                        label: 'Mark Final',
                        backgroundColor: Colors.indigo,
                      ),
                      SlidableAction(
                        onPressed: (_) => onSubmit(context, submission),
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
                        onPressed: (_) => onDelete(context, submission),
                        icon: Icons.delete,
                        label: 'Delete',
                        backgroundColor: Colors.red.shade400,
                      ),
                    ],
                  ),
                  child: SubmissionCard(
                    submission: submission,
                    onTap: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onMarkFinal(BuildContext context, SubmissionSummary submission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Marked "${submission.form.displayLabel}" as Final')),
    );
  }

  void onSubmit(BuildContext context, SubmissionSummary submission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Submitted "${submission.form.displayLabel}"')),
    );
  }

  void onDelete(BuildContext context, SubmissionSummary submission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted "${submission.form.displayLabel}"')),
    );
  }
}
