import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/team_form_permission.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/commons/helpers/collections.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data/submission_list.provider.dart';
import 'package:datarunmobile/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormSubmissionCreate extends ConsumerStatefulWidget {
  const FormSubmissionCreate(
      {super.key, required this.assignment, required this.onNewFormCreated});

  final AssignmentModel assignment;
  final Function(DataFormSubmission submissionId) onNewFormCreated;

  @override
  FormSubmissionCreateState createState() => FormSubmissionCreateState();
}

class FormSubmissionCreateState extends ConsumerState<FormSubmissionCreate> {
  Future<DataFormSubmission> _createEntity(
      BuildContext context, FormVersion formTemplate) async {
    final activityModel = ActivityInheritedWidget.of(context);
    final submissionInitialRepository =
        ref.read(formSubmissionsProvider(formTemplate.formTemplate).notifier);

    final submission = await submissionInitialRepository.createNewSubmission(
      versionUid: formTemplate.id!,
      assignmentId: widget.assignment.id,
      form: formTemplate.formTemplate!,
      team: activityModel.assignedTeam!.id!,
      versionNumber: formTemplate.versionNumber,
    );
    return submission;
  }

  Future<void> createAndPopupWithResult(
      BuildContext context, FormVersion formTemplate) async {
    DataFormSubmission? createdSubmission;
    try {
      createdSubmission = await _createEntity(context, formTemplate);
      widget.onNewFormCreated.call(createdSubmission);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).errorOpeningNewForm}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final List<Pair<TeamFormPermission, bool>> userForms =
        widget.assignment.userForms;
    final List<Pair<TeamFormPermission, bool>> availableLocally =
        widget.assignment.availableForms;

    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.document_scanner, size: 30),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  S.of(context).selectForm,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ).copyWith(color:cs.primary),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                availableLocally.length == userForms.length
                    ? '(${S.of(context).form(availableLocally.length)})'
                    : '(${availableLocally.length}/${S.of(context).form(userForms.length)})',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Divider(color: Colors.grey.shade400, thickness: 1.0),
          // const SizedBox(height: 10.0),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                itemCount: availableLocally.length,
                itemBuilder: (BuildContext context, int index) {
                  return _FormListItem(
                    index: index,
                    permission: availableLocally[index].first,
                    onTap: (FormVersion formTemplate) =>
                        createAndPopupWithResult(context, formTemplate),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormListItem extends ConsumerWidget {
  const _FormListItem(
      {required this.index, required this.permission, required this.onTap});

  final int index;
  final TeamFormPermission permission;
  final void Function(FormVersion) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formTemplateAsync =
        ref.watch(latestFormTemplateProvider(formId: permission.form));

    return AsyncValueWidget(
      value: formTemplateAsync,
      valueBuilder: (formTemplate) {
        final cs = Theme.of(context).colorScheme;
        return ListTile(
          tileColor: cs.onInverseSurface,
          iconColor: cs.primary,
          textColor: cs.onSurfaceVariant,
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
          // isThreeLine: formTemplate.description != null,
          leading: const Icon(Icons.description),
          title: Text(
            '${index + 1}. ${getItemLocalString(formTemplate.label, defaultString: formTemplate.name)}',
            softWrap: true,
          ),
          subtitle: formTemplate.description != null
              ? Text(
                  formTemplate.description!,
                  softWrap: true,
                )
              : null,
          onTap: () => onTap(formTemplate),
          trailing: const Icon(Icons.chevron_right),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hoverColor: cs.onSurface.withOpacity(0.1),
        );
      },
    );
  }
}
