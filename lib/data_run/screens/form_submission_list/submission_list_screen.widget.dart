import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mass_pro/commons/custom_widgets/async_value.widget.dart';
import 'package:mass_pro/core/common/state.dart';
import 'package:mass_pro/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:mass_pro/data_run/screens/form/form_tab_screen.widget.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/model/submission_list.provider.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/submission_summary.widget.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/submission_creation_dialog.widget.dart';
import 'package:mass_pro/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:mass_pro/data_run/screens/form_submission_list/submission_sync_dialog.widget.dart';
import 'package:mass_pro/generated/l10n.dart';

class SubmissionListScreen extends StatefulHookConsumerWidget {
  const SubmissionListScreen({super.key});

  @override
  SubmissionListState createState() => SubmissionListState();
}

class SubmissionListState extends ConsumerState<SubmissionListScreen> {
  SyncStatus? _selectedStatus;

  Future<void> _showSyncDialog(List<String> entityUids) async {
    final form = FormMetadataWidget.of(context).form;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog(
          entityUids: entityUids,
          syncEntity: (uids) async {
            if (uids != null) {
              await ref
                  .read(formSubmissionListProvider(form: form).notifier)
                  .syncEntities(uids);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formMetadata = FormMetadataWidget.of(context);
    return Scaffold(
        key: ValueKey(formMetadata.form),
        appBar: AppBar(
          title: Text(formMetadata.formLabel),
        ),
        body: Column(
          children: [
            _buildFilterBar(),
            Expanded(
                child: AsyncValueWidget(
              value: ref.watch(
                submissionFilteredByStateProvider(
                    form: formMetadata.form, status: _selectedStatus),
              ),
              data: (submissions) => ListView.builder(
                itemCount: submissions.length,
                itemBuilder: (BuildContext context, int index) {
                  final DataFormSubmission entity = submissions[index];

                  return Card(
                    shadowColor: Theme.of(context).colorScheme.shadow,
                    surfaceTintColor: Theme.of(context).colorScheme.primary,
                    elevation: .7,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SubmissionSummary(
                        form: formMetadata.form,
                        entity: entity,
                        onSyncPressed: (uid) => _showSyncDialog([entity.uid!]),
                        onTap: () =>
                            _goToDataEntryForm(entity.uid!, entity.version)),
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
  }

  Widget _buildFilterBar() {
    final formMetadata = FormMetadataWidget.of(context);

    final statusCountModelValue =
        ref.watch(submissionStatusModelProvider(form: formMetadata.form));

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
        tooltip: status.name,
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

    final formMetadata = FormMetadataWidget.of(context);
    final String? result = await showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          return FormMetadataWidget(
            formMetadata: formMetadata,
            child: const SubmissionCreationDialog(),
          );
        });
    if (result != null) {
      _goToDataEntryForm(result, formMetadata.version);
    } else {
      // Handle cancellation or failure
    }
  }

  void _goToDataEntryForm(String submission, int version) async {
    // final Bundle eventBundle = Get.arguments as Bundle;
    // Bundle bundle = eventBundle.putString(SYNCABLE_UID, uid);
    // bundle = bundle.putInt(FORM_VERSION, version);
    //
    // await Get.to(const FormSubmissionScreen(currentPageIndex: 1),
    //     arguments: bundle);
    // await Get.to(DataSubmissionScreen(), arguments: bundle);
    final metas = FormMetadataWidget.of(context).copyWith(
      submission: submission,
      version: version,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormMetadataWidget(
                formMetadata: metas,
                child: FormSubmissionScreen(
                  currentPageIndex: 1,
                ),
              )),
    );

    // Get.to(
    //   FormMetadataWidget(
    //     formMetadata: metas,
    //     child: FormSubmissionScreen(
    //       currentPageIndex: 1,
    //     ),
    //   ),
    // );
  }
}

Widget buildStatusIcon(SyncStatus? status) {
  switch (status) {
    case SyncStatus.SYNCED:
      return const Icon(Icons.cloud_done, color: Colors.green);
    case SyncStatus.TO_POST:
      return const Icon(Icons.cloud_upload, color: Colors.blue);
    case SyncStatus.TO_UPDATE:
      return const Icon(Icons.update, color: Colors.orange);
    case SyncStatus.ERROR:
      return const Icon(Icons.error, color: Colors.red);
    default:
      return const Icon(Icons.all_inclusive);
  }
}
