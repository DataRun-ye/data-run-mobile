import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/core/utilities/list_extensions.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/common/state.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_activity/activity_model.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/data_run/form/form_submission/submission_list_util.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form_submission_list/submission_sync_dialog.widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class FormSubmissionsTable extends HookConsumerWidget {
  const FormSubmissionsTable(
      {super.key, required this.assignment, required this.formId});

  final AssignmentModel assignment;
  final String formId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubmissions = useState<IList<DataFormSubmission>>(IList());
    final toSync = selectedSubmissions.value
        .where((s) =>
            SubmissionListUtil.getSyncStatus(s) == SyncStatus.TO_POST ||
            SubmissionListUtil.getSyncStatus(s) == SyncStatus.ERROR)
        .map((s) => s.id!)
        .toList();
    final activityModel = ActivityInheritedWidget.of(context);

    final formAsync = ref.watch(latestFormTemplateProvider(formId: formId));
    final _sortColumnIndex = useState<int?>(null);
    final _sortAscending = useState(true);
    final ScrollController _horizontalController = useScrollController();

    final submissions = useState(ref
        .watch(formSubmissionsProvider(formId))
        .requireValue
        .where((s) => s.assignment == assignment.id)
        .toList());

    void _sort<T>(Comparable<T> Function(DataFormSubmission d) getField,
        int columnIndex, bool ascending) {
      submissions.value.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    }

    return AsyncValueWidget(
        value: formAsync,
        valueBuilder: (FormVersion formVersion) {
          final columnHeaders =
              formVersion.formFlatFields.entries.where((entry) {
            final field = entry.value;
            return !field.type!.isSection && field.mainField;
          }).toList();

          // final columns =

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  getItemLocalString(formVersion.label,
                      defaultString: formVersion.name),
                  style: Theme.of(context).textTheme.titleMedium),
              if (selectedSubmissions.value.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                        onPressed: toSync.length > 0
                            ? () async {
                                await _showSyncDialog(context, toSync, ref);
                              }
                            : null,
                        icon: const Icon(Icons.sync),
                        label: Text(
                            '${S.of(context).send}: ${S.of(context).syncSubmissions(toSync.length)}'))
                  ],
                ),
              submissions.value.isNotEmpty
                  ? LayoutBuilder(builder: (context, constraints) {
                      return Scrollbar(
                        interactive: true,
                        controller: _horizontalController,
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.only(bottom: 24),
                          scrollDirection: Axis.horizontal,
                          controller: _horizontalController,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: constraints.maxWidth),
                            child: DataTable(
                              sortAscending: _sortAscending.value,
                              sortColumnIndex: _sortColumnIndex.value,
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text(S.of(context).status),
                                  onSort: (columnIndex, ascending) {
                                    _sort<String>((d) => d.status!.name,
                                        columnIndex, ascending);
                                  },
                                ),
                                DataColumn(label: Text(S.of(context).edit)),
                                ...columnHeaders.map((header) => DataColumn(
                                    label: Text(getItemLocalString(
                                        header.value.label.unlock,
                                        defaultString: header.key)))),
                                // DataColumn(label: Text()),
                                // DataColumn(label: Text()),
                                DataColumn(
                                  label: Text(S.of(context).createdDate),
                                  onSort: (columnIndex, ascending) {
                                    _sort<DateTime>(
                                        (d) => DateTime.parse(
                                            DateHelper.fromUiLocalToDbUtcFormat(
                                                d.createdDate!)),
                                        columnIndex,
                                        ascending);
                                  },
                                ),
                                DataColumn(
                                  label: Text(S.of(context).lastmodifiedDate),
                                  onSort: (columnIndex, ascending) {
                                    _sort<DateTime>(
                                        (d) => DateTime.parse(
                                            DateHelper.fromUiLocalToDbUtcFormat(
                                                d.lastModifiedDate!)),
                                        columnIndex,
                                        ascending);
                                  },
                                ),
                                DataColumn(
                                    label: Text(S.of(context).deleteRestore)),
                              ],
                              rows: submissions.value.map((submission) {
                                final deleted = (submission.deleted ?? false);
                                final deletedStyle = deleted
                                    ? const TextStyle(
                                        fontStyle: FontStyle.italic)
                                    : null;
                                Map<String, dynamic> extractedValues = {};
                                Map<String, dynamic> totalResources = {};
                                try {
                                  extractedValues = _extractValues(
                                      submission.formData,
                                      formVersion,
                                      activityModel);
                                  totalResources =
                                      _sumNumericResources(submission.formData);
                                } catch (e) {
                                  // log
                                }

                                return DataRow(
                                  color: deleted
                                      ? WidgetStateProperty.all(
                                          Colors.redAccent)
                                      : null,
                                  selected: selectedSubmissions.value
                                      .contains(submission),
                                  onSelectChanged: (selected) {
                                    if (selected == true) {
                                      selectedSubmissions.value =
                                          selectedSubmissions.value
                                              .add(submission);
                                    } else {
                                      selectedSubmissions.value =
                                          selectedSubmissions.value
                                              .remove(submission);
                                    }
                                  },
                                  cells: <DataCell>[
                                    DataCell(buildStatusIcon(
                                        SubmissionListUtil.getSyncStatus(
                                            submission))),
                                    DataCell(IconButton(
                                      onPressed: !(submission.deleted ?? false)
                                          ? () async {
                                              goToDataEntryForm(
                                                  context,
                                                  assignment,
                                                  submission,
                                                  activityModel);
                                              // ref.invalidate(assignmentsProvider);
                                            }
                                          : null,
                                      icon: const Icon(Icons.edit),
                                      // label: Text(S.of(context).edit),
                                    )),
                                    ...columnHeaders.map(
                                      (header) => DataCell(
                                        Text(
                                            extractedValues[header.value.name]
                                                    ?.toString() ??
                                                totalResources[
                                                        header.value.name]
                                                    ?.toString() ??
                                                '',
                                            style: deletedStyle),
                                      ),
                                    ),
                                    DataCell(Text(
                                        _formatDate(submission.createdDate),
                                        style: deletedStyle)),
                                    DataCell(Text(
                                        _formatDate(
                                            submission.lastModifiedDate),
                                        style: (submission.deleted ?? false)
                                            ? const TextStyle(
                                                fontStyle: FontStyle.italic)
                                            : null)),
                                    DataCell(IconButton(
                                      icon: Icon(
                                          deleted
                                              ? Icons.settings_backup_restore
                                              : Icons.delete,
                                          size: 20),
                                      onPressed: () => _confirmDelete(
                                          context,
                                          submission.id,
                                          deleted
                                              ? S.of(context).restoreItem
                                              : S
                                                  .of(context)
                                                  .deleteConfirmationMessage,
                                          ref),
                                    )),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    })
                  : Center(child: Text(S.of(context).noSubmissions)),
              const SizedBox(height: 20),
              const Divider(height: 20),
              const SizedBox(height: 20),
            ],
          );
        });
  }

  Map<String, dynamic> _extractValues(Map<String, dynamic> formData,
      FormVersion formTemplate, ActivityModel activityModel) {
    Map<String, dynamic> extractedValues = {};

    void _extract(Map<String, dynamic> data, List<Template> fields) {
      fields.forEach((field) {
        if (field.name != null) {
          if (field.type!.isSection && data.containsKey(field.name)) {
            _extract(
                data[field.name], (field as SectionTemplate).fields.toList());
          } else if (field.type!.isRepeatSection &&
              data.containsKey(field.name)) {
            // extractedValues[field.name!] = data[field.name];
          } else if (field.type == ValueType.Progress &&
              data.containsKey(field.name)) {
            final value = ((AssignmentStatus.values
                        .firstOrNullWhere((t) => t.name == data[field.name])
                        ?.name ??
                    data[field.name])
                ?.toString());
            extractedValues[field.name!] =
                value != null ? Intl.message(value.toLowerCase()) : '-';
          } else if (field.type == ValueType.Team &&
              data.containsKey(field.name)) {
            extractedValues[field.name!] = activityModel.managedTeams
                    .firstOrNullWhere((t) => t.id == data[field.name])
                    ?.name ??
                data[field.name];
          } else if (field.type == ValueType.SelectOne &&
              data.containsKey(field.name)) {
            extractedValues[field.name!] = getItemLocalString(
                formTemplate.options
                    .firstOrNullWhere((t) => t.name == data[field.name])
                    ?.label
                    .unlock,
                defaultString: data[field.name] ?? '');
          } else if (data.containsKey(field.name)) {
            extractedValues[field.name!] = data[field.name];
          }
        }
      });
    }

    _extract(formData, formTemplate.fields);
    return extractedValues;
  }

  Map<String, double> _sumNumericResources(Map<String, dynamic> formData) {
    Map<String, double> subTotals = {};

    void _sumResources(Map<String, dynamic> data) {
      data.forEach((key, value) {
        if (value is num) {
          subTotals[key] = (subTotals[key] ?? 0) + value.toDouble();
        } else if (value is Map<String, dynamic>) {
          _sumResources(value);
        } else if (value is List) {
          value.forEach((element) {
            if (element is Map<String, dynamic>) {
              _sumResources(element);
            }
          });
        }
      });
    }

    _sumResources(formData);
    return subTotals;
  }

  Future<void> _showSyncDialog(
      BuildContext context, List<String> entityUids, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog(
          entityUids: entityUids,
          syncEntity: (uids) async {
            if (uids != null) {
              await ref
                  .read(formSubmissionsProvider(formId).notifier)
                  .syncEntities(uids);
            }
          },
        );
      },
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, String? uid, String message, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirm),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _showUndoSnackBar(context, uid, ref);
    }
  }

  void _showUndoSnackBar(
      BuildContext context, String? toDeleteUid, WidgetRef ref) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final listSubmissionsNotifier =
        ref.read(formSubmissionsProvider(formId).notifier);
    listSubmissionsNotifier.deleteSubmission([toDeleteUid]);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(S.of(context).itemRemoved),
        action: SnackBarAction(
          label: S.of(context).undo,
          onPressed: () {
            listSubmissionsNotifier.deleteSubmission([toDeleteUid]);
          },
        ),
      ),
    );
  }
}

Widget buildStatusIcon(SyncStatus? status) {
  switch (status) {
    case SyncStatus.SYNCED:
      return const Icon(Icons.cloud_done, color: Colors.green, size: 20);
    case SyncStatus.TO_POST:
      return const Icon(Icons.cloud_upload, color: Colors.blue, size: 20);
    case SyncStatus.TO_UPDATE:
      return const Icon(Icons.update, color: Colors.orange, size: 20);
    case SyncStatus.ERROR:
      return const Icon(Icons.error, color: Colors.red, size: 20);
    default:
      return const Icon(Icons.all_inclusive, size: 20);
  }
}

String _formatDate(String? dateStr) {
  if (dateStr == null) return '';
  final dateTime = DateTime.tryParse(dateStr)?.toLocal();
  if (dateTime == null) {
    return '';
  }
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}
