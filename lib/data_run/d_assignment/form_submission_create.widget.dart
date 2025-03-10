import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/generated/l10n.dart';

class FormSubmissionCreate extends ConsumerStatefulWidget {
  const FormSubmissionCreate(
      {super.key, required this.assignment, required this.onNewFormCreated});

  final AssignmentModel assignment;
  final Function(DataFormSubmission submissionId) onNewFormCreated;

  @override
  FormSubmissionCreateState createState() => FormSubmissionCreateState();
}

class FormSubmissionCreateState extends ConsumerState<FormSubmissionCreate> {
  // bool _isLoading = false;

  Future<DataFormSubmission> _createEntity(
      BuildContext context, FormVersion formTemplate) async {
    final activityModel = ActivityInheritedWidget.of(context);
    final submissionInitialRepository =
        ref.read(formSubmissionsProvider(formTemplate.formTemplate).notifier);

    final submission = await submissionInitialRepository.createNewSubmission(
      formVersion: formTemplate.id,
      assignmentId: widget.assignment.id,
      form: formTemplate.id!.split('_').first,
      team: activityModel.assignedTeam!.id!,
      version: formTemplate.version,
    );
    return submission;
  }

  Future<void> createAndPopupWithResult(
      BuildContext context, FormVersion formTemplate) async {
    // setState(() {
    //   _isLoading = true;
    // });

    DataFormSubmission? createdSubmission;
    try {
      createdSubmission = await _createEntity(context, formTemplate);
      // setState(() {
      //   _isLoading = false;
      // });
      widget.onNewFormCreated.call(createdSubmission);
    } catch (e) {
      // setState(() {
      //   _isLoading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorOpeningNewForm}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.document_scanner, size: 30),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  S.of(context).selectForm,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                '(${S.of(context).form(widget.assignment.forms.length)})',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Divider(color: Colors.grey.shade400, thickness: 1.0),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.assignment.forms.length,
            itemBuilder: (context, index) {
              final form = widget.assignment.forms[index];
              if (!ActivityInheritedWidget.of(context)
                  .assignedForms
                  .contains(form)) {
                return const SizedBox.shrink();
              }

              final formTemplateAsync = ref.watch(
                latestFormTemplateProvider(formId: form),
              );

              return AsyncValueWidget(
                value: formTemplateAsync,
                valueBuilder: (formTemplate) {
                  return ListTile(
                    leading: Icon(Icons.description),
                    title: Text(
                      getItemLocalString(formTemplate.label),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      softWrap: true,
                    ),
                    subtitle: formTemplate.description != null
                        ? Text(
                            formTemplate.description!,
                            style: Theme.of(context).textTheme.bodySmall,
                            softWrap: true,
                          )
                        : null,
                    onTap: () =>
                        createAndPopupWithResult(context, formTemplate),
                    trailing: const Icon(Icons.chevron_right),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    // tileColor: Colors.grey.shade100,
                    hoverColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
