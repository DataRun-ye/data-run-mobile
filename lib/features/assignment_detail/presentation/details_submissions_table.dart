import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.dialogs.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list_util.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/status_icon.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/submission_sync_dialog.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class DetailSubmissionsTable extends HookConsumerWidget {
  const DetailSubmissionsTable(
      {super.key,
      required this.assignment,
      required this.formId,
      required this.index});

  final AssignmentModel assignment;
  final String formId;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubmissions = useState<IList<DataInstance>>(IList());
    final toSync = selectedSubmissions.value
        .where((s) =>
            SubmissionListUtil.getSyncStatus(s) == SyncStatus.TO_POST ||
            SubmissionListUtil.getSyncStatus(s) == SyncStatus.ERROR)
        .map((s) => s.id)
        .toList();
    final formAsync = ref.watch(latestFormTemplateProvider(formId: formId));
    final _sortColumnIndex = useState<int?>(null);
    final _sortAscending = useState(true);
    final ScrollController _horizontalController = useScrollController();

    final submissions = useState(ref
        .watch(formSubmissionsProvider(formId))
        .requireValue
        .where((s) => s.assignment == assignment.id)
        .toList());

    void _sort<T>(Comparable<T> Function(DataInstance d) getField,
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
        valueBuilder: (FormTemplateRepository template) {
          final columnHeaders = template.template.fields.where((entry) {
            final field = entry;
            return field.mainField;
          }).toList();
          final title = getItemLocalString(template.template.label,
              defaultString: template.template.name);

          return Column(
            key: ValueKey('${assignment.id}_cold'),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${index + 1}. $title',
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
                            '${S.of(context).syncSubmissions(toSync.length)}'))
                  ],
                ),
              SizedBox(
                height: 8,
              ),
              submissions.value.isNotEmpty
                  ? LayoutBuilder(builder: (context, constraints) {
                      return Scrollbar(
                        interactive: true,
                        controller: _horizontalController,
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.only(bottom: 24),
                          scrollDirection: Axis.horizontal,
                          controller: _horizontalController,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: constraints.maxWidth),
                            child: DataTable(
                              key: ValueKey('${assignment}_submissions_table'),
                              sortAscending: _sortAscending.value,
                              sortColumnIndex: _sortColumnIndex.value,
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text(S.of(context).status),
                                  onSort: (columnIndex, ascending) {
                                    _sort<String>((d) => d.syncState.name,
                                        columnIndex, ascending);
                                  },
                                ),
                                DataColumn(label: Text(S.of(context).edit)),
                                ...columnHeaders.map((header) => DataColumn(
                                    label: Text(getItemLocalString(
                                        header.label.unlock,
                                        defaultString: header.name)))),
                                DataColumn(
                                  label: Text(S.of(context).createdDate),
                                  onSort: (columnIndex, ascending) {
                                    _sort<DateTime>(
                                        (d) => d.createdDate ?? DateTime.now(),
                                        columnIndex,
                                        ascending);
                                  },
                                ),
                                DataColumn(
                                  label: Text(S.of(context).lastmodifiedDate),
                                  onSort: (columnIndex, ascending) {
                                    _sort<DateTime>(
                                        (d) =>
                                            d.lastModifiedDate ??
                                            DateTime.now(),
                                        columnIndex,
                                        ascending);
                                  },
                                ),
                                DataColumn(
                                    label: Text(S.of(context).deleteRestore)),
                              ],
                              rows: submissions.value.map((submission) {
                                final deleted = (submission.deleted);
                                final textStyle = deleted
                                    ? const TextStyle(
                                        decoration: TextDecoration.lineThrough)
                                    : null;
                                Map<String, dynamic> extractedValues = {};
                                Map<String, dynamic> totalResources = {};
                                try {
                                  extractedValues = _extractValues(
                                      submission.formData ?? {}, template);
                                  totalResources = _sumNumericResources(
                                      submission.formData ?? {});
                                } catch (e) {
                                  // log
                                }

                                return DataRow(
                                  color: deleted
                                      ? WidgetStateProperty.all(
                                          Colors.grey[700])
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
                                    DataCell(GestureDetector(
                                      onTap: submission.syncState.isSyncFailed
                                          ? () => buildShowDialog(
                                              context, submission)
                                          : null,
                                      child: StatusIcon(
                                          syncState: submission.syncState),
                                    )),
                                    DataCell(IconButton(
                                      onPressed: !deleted
                                          ? () async {
                                              goToDataEntryForm(context,
                                                  assignment, submission);
                                              // ref.invalidate(assignmentsProvider);
                                            }
                                          : null,
                                      icon: const Icon(Icons.edit),
                                      // label: Text(S.of(context).edit),
                                    )),
                                    ...columnHeaders.map(
                                      (header) => DataCell(
                                        Text(
                                            extractedValues[header.name]
                                                    ?.toString() ??
                                                totalResources[header.name]
                                                    ?.toString() ??
                                                '',
                                            style: textStyle),
                                      ),
                                    ),
                                    DataCell(Text(
                                        _formatDate(submission.createdDate),
                                        style: textStyle)),
                                    DataCell(Text(
                                        _formatDate(
                                            submission.lastModifiedDate),
                                        style: textStyle)),
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
                                      tooltip: deleted
                                          ? S.of(context).restoreItem
                                          : S.of(context).deleteItem,
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

  Future<dynamic> buildShowDialog(
      BuildContext context, DataInstance submission) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text(S.of(context).errorSubmittingForm),
                content: Text(S
                    .of(context)
                    .submissionError(submission.lastSyncMessage ?? '')),
                actions: <Widget>[
                  TextButton(
                      child: Text(S.of(context).ok),
                      onPressed: () {
                        appLocator<NavigationService>().back();
                      })
                ]));
  }

  Map<String, dynamic> _extractValues(
      Map<String, dynamic> formData, FormTemplateRepository formTemplate) {
    Map<String, dynamic> extractedValues = {};

    void _extract(Map<String, dynamic> data, Iterable<Template> fields) {
      fields.forEach((field) {
        // if (field.name != null) {
        if (field.repeatable && data.containsKey(field.name)) {
          _extract(data[field.name], field.children.toList());
          // extractedValues[field.name!] = data[field.name];
        } else if (field is SectionTemplate && data.containsKey(field.name)) {
          _extract(data[field.name], field.children.toList());
        } else if (field.type == ValueType.Progress &&
            data.containsKey(field.name)) {
          final value = ((AssignmentStatus.getType(data[field.name])?.name ??
                  data[field.name])
              ?.toString());
          extractedValues[field.name!] =
              value != null ? Intl.message(value.toLowerCase()) : '-';
          // } else if (field.type == ValueType.Team &&
          //     data.containsKey(field.name)) {
          //   extractedValues[field.name!] = activityModel.managedTeams
          //           .firstOrNullWhere((t) => t.id == data[field.name])
          //           ?.name ??
          //       data[field.name];
        } else if (field.type?.isSelectType == true &&
            formTemplate.optionSets[field.optionSet] != null &&
            data.containsKey(field.name)) {
          extractedValues[field.name!] = data[field.name];
        } else if (field.name != null) {
          extractedValues[field.name!] = data[field.name];
        }
        // }
      });
    }

    _extract(formData, formTemplate.rootSection.children);
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
      BuildContext context, List<String> entityIds, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog(
          entityIds: entityIds,
          syncEntity: (ids) async {
            if (ids != null) {
              await ref
                  .read(formSubmissionsProvider(formId).notifier)
                  .syncEntities(ids);
              await appLocator<NavigationService>().back();
            }
          },
        );
      },
    );
  }

  Future<void> _showSyncDialogTest(
      BuildContext context, List<String> entityIds, WidgetRef ref) async {
    await appLocator<DialogService>().showCustomDialog(
      variant: DialogType.infoAlert,
      title: Intl.message('Test version'),
      description:
          'This is a Version for testing, uploading to server is not permitted',
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, String id, String message, WidgetRef ref) async {
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
      _showUndoSnackBar(context, id, ref);
    }
  }

  void _showUndoSnackBar(
      BuildContext context, String toDeleteId, WidgetRef ref) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final listSubmissionsNotifier =
        ref.read(formSubmissionsProvider(formId).notifier);
    listSubmissionsNotifier.deleteSubmission([toDeleteId]);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(S.of(context).itemRemoved),
        action: SnackBarAction(
          label: S.of(context).undo,
          onPressed: () {
            listSubmissionsNotifier.deleteSubmission([toDeleteId]);
          },
        ),
      ),
    );
  }
}

String _formatDate(DateTime? dateStr) {
  if (dateStr == null) return '';
  final dateTime = dateStr.toLocal();
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}
