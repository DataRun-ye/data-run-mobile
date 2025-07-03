// widgets/form_template_picker_bottom_sheet.dart
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app_router/app_router.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/home/form_template/domain/service/form_template_service.dart';
import 'package:flutter/material.dart';

class FormTemplatePickerBottomSheet extends StatelessWidget {
  final List<FormTemplate> templates;

  const FormTemplatePickerBottomSheet({required this.templates, super.key});

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
          subtitle: Text("Version: ${template.versionNumber}"),
          onTap: () => Navigator.pop(context, template),
        );
      },
    );
  }
}

Future<void> onCreateSubmissionTap(
    BuildContext context, String assignmentId) async {
  final templates =
      await appLocator<FormTemplateService>().fetchByAssignment(assignmentId);

  final selectedForm = await showModalBottomSheet<FormTemplate>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => FormTemplatePickerBottomSheet(templates: templates),
  );

  if (selectedForm != null) {
    appLocator<AppRouter>().pushCreateSubmission(
      formId: selectedForm.id,
      assignmentId: assignmentId,
    );
  }
}
