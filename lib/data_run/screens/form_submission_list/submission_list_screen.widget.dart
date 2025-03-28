import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:datarunmobile/data/form_submission/form_submissions_status.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/sync_status_icon.dart';
import 'package:datarunmobile/data/form/form_instance.provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/form_submission/submission_list.provider.dart';
import 'package:datarunmobile/data_run/screens/form/form_tab_screen.widget.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/data_run/screens/form_submission_list/submission_info.widget.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarunmobile/data_run/screens/form_submission_list/submission_sync_dialog.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:intl/intl.dart';

class SubmissionListScreen extends StatefulHookConsumerWidget {
  const SubmissionListScreen({super.key});

  @override
  SubmissionListState createState() => SubmissionListState();
}

class SubmissionListState extends ConsumerState<SubmissionListScreen> {
  SyncStatus? _selectedStatus;
  final List<Template> formTemplates = [];

  Future<void> _showSyncDialog(List<String> entityIds) async {
    final formMetadata = FormMetadataWidget.of(context);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog(
          entityIds: entityIds,
          syncEntity: (ids) async {
            if (ids != null) {
              await ref
                  .read(formSubmissionsProvider(formMetadata.formId).notifier)
                  .syncEntities(ids);
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formMetadata = FormMetadataWidget.of(context);
    final formTemplateAsync = ref.watch(
        submissionVersionFormTemplateProvider(formId: formMetadata.formId));
    return AsyncValueWidget(
      value: formTemplateAsync,
      valueBuilder: (formTemplate) {
        return Scaffold(
            key: ValueKey(formMetadata.formId),
            appBar: AppBar(
              title: Text(formMetadata.assignmentModel.activity),
            ),
            body: Column(
              children: [
                _buildFilterBar(),
                Expanded(
                    child: AsyncValueWidget(
                  value: ref.watch(
                    submissionFilteredByStateProvider(
                        form: formMetadata.formId, status: _selectedStatus),
                  ),
                  valueBuilder: (submissions) => ListView.builder(
                    itemCount: submissions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DataFormSubmission entity = submissions[index];

                      return FormMetadataWidget(
                        formMetadata: FormMetadataWidget.of(context)
                            .copyWith(submission: entity.id),
                        child: Card(
                          shadowColor: Theme.of(context).colorScheme.shadow,
                          surfaceTintColor:
                              Theme.of(context).colorScheme.primary,
                          elevation: .7,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SubmissionInfo(
                              rootSection:
                                  SectionTemplate(fields: formTemplate.fields),
                              submissionEntity: entity,
                              onSyncPressed: (id) =>
                                  _showSyncDialog([entity.id!]),
                              onTap: () => _goToDataEntryForm(
                                    entity.id!, /*entity.version*/
                                  )),
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showAddEntityDialog();
              },
              tooltip: S.current.addNew,
              child: const Icon(Icons.add),
            ));
      },
    );
  }

  Widget _buildFilterBar() {
    final statusCountModelValue = ref.watch(
        formSubmissionsStatusProvider(FormMetadataWidget.of(context).formId));

    return switch (statusCountModelValue) {
      AsyncValue(:final Object error?, :final stackTrace) =>
        getErrorWidget(error, stackTrace),
      AsyncValue(valueOrNull: final model?) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip(SyncStatus.SYNCED, model.synced),
                _buildFilterChip(SyncStatus.TO_POST, model.toPost),
                _buildFilterChip(SyncStatus.TO_UPDATE, model.toUpdate),
                _buildFilterChip(SyncStatus.ERROR, model.withError),
              ],
            ),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildFilterChip(SyncStatus status, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(' ($count)'),
        showCheckmark: false,
        tooltip: Intl.message(status.name.toLowerCase()),
        avatar: buildStatusIcon(status),
        selected: _selectedStatus == status,
        onSelected: (bool selected) {
          setState(() {
            _selectedStatus = selected ? status : null;
          });
        },
      ),
    );
  }

  Future<void> _showAddEntityDialog() async {
    if (!context.mounted) {
      return;
    }

    // final formMetadata = FormMetadataWidget.of(context);
    // final String? result = await showDialog<String?>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return FormMetadataWidget(
    //         formMetadata: formMetadata,
    //         child: const SubmissionCreationDialog(),
    //       );
    //     });
    // if (result != null) {
    //   // _goToDataEntryForm(result/*, formMetadata.version*/);
    // } else {
    //   // Handle cancellation or failure
    // }
  }

  void _goToDataEntryForm(String submission /*, int version*/) async {
    final metas = FormMetadataWidget.of(context).copyWith(
      submission: submission,
      // version: version,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormMetadataWidget(
                formMetadata: metas,
                child: const FormSubmissionScreen(
                  currentPageIndex: 1,
                ),
              )),
    );
  }
}
