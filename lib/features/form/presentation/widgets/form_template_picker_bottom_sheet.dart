import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/form_template_list_service.dart';
import 'package:flutter/material.dart';

class FormTemplatePickerBottomSheet extends StatelessWidget {
  const FormTemplatePickerBottomSheet({required this.templates, super.key});

  final List<FormTemplate> templates;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: templates.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (_, index) {
        final template = templates[index];
        return ListTile(
          title: Text(template.name),
          subtitle: Text('Version: ${template.versionNumber}'),
          onTap: () => Navigator.pop(context, template),
        );
      },
    );
  }
}

Future<void> onCreateSubmissionTap(
    BuildContext context, String assignmentId) async {
  final templates =
      await appLocator<FormTemplateListService>().fetchByAssignment(assignmentId);

  final selectedForm = await showModalBottomSheet<FormTemplate>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => FormTemplatePickerBottomSheet(templates: templates),
  );

  if (selectedForm != null) {
    // appLocator<AppRouter>().pushCreateSubmission(
    //   formId: selectedForm.id,
    //   assignmentId: assignmentId,
    // );
  }
}
