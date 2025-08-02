import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/presentation/submissions_history_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmissionHistoryScreen extends ConsumerWidget {
  SubmissionHistoryScreen({super.key, required this.form, this.assignment});

  final String form;
  final String? assignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final assignmentModelAsync = ref.watch(provider);
    final formTemplateRepo = appLocator<FormTemplateRepository>();
    // final submissionsAsync = ref.watch(formSubmissionsProvider(form));
    final title = getItemLocalString(formTemplateRepo.template.label,
        defaultString: formTemplateRepo.template.name);

    return Scaffold(
      appBar: AppBar(title: Text(title, overflow: TextOverflow.ellipsis)),
      body: SafeArea(
        child: SubmissionsHistoryTable(
          assignment: assignment,
          template: formTemplateRepo,
        ),
      ),
    );
  }
}
