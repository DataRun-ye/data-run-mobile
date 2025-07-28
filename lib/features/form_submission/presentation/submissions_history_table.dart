import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/form/tree/element_tree_service.dart';
import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.dialogs.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/status_icon.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/submission_sync_dialog.widget.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class SubmissionsHistoryTable extends HookConsumerWidget {
  const SubmissionsHistoryTable({
    super.key,
    required this.template,
    this.assignment,
  });

  final String? assignment;
  final FormTemplateRepository template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submissionAsync =
    ref.watch(formSubmissionsProvider(template.template.id));
    if (submissionAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (submissionAsync.hasError) {
      return getErrorWidget(submissionAsync.error, submissionAsync.stackTrace);
    }
    final submissions = submissionAsync.requireValue;

    // Prepare column headers
    final columnHeaders =
    template.template.fields.where((f) => f.mainField).toList();
    final totalColumns = 2 +
        columnHeaders.length +
        3; // status, edit + data cols + created, modified, delete

    // Scroll controllers
    final hController = useScrollController();
    final vController = useScrollController();

    return TableView.builder(
      columnCount: totalColumns,
      rowCount: submissions.length + 1,
      // +1 for header row

      // Freeze the header row
      rowBuilder: (int rowIndex) {
        return TableSpan(
          extent: const FixedTableSpanExtent(56),
          backgroundDecoration: SpanDecoration(
            color: rowIndex == 0 ? Theme.of(context).dividerColor : null,
          ),
          // pinned: rowIndex == 0,
        );
      },

      // Define each column's width
      columnBuilder: (int colIndex) {
        // first two columns narrow
        if (colIndex == 0 || colIndex == 1) {
          return const TableSpan(extent: FixedTableSpanExtent(48));
        }
        // last three columns
        if (colIndex >= totalColumns - 3) {
          return const TableSpan(extent: FixedTableSpanExtent(120));
        }
        // data columns flexible
        return const TableSpan(extent: FractionalTableSpanExtent(0.15));
      },

      // Build each cell
      cellBuilder: (BuildContext ctx, TableVicinity vic) {
        final row = vic.row;
        final col = vic.column;

        // Header row
        if (row == 0) {
          Widget label;
          switch (col) {
            case 0:
              label = const Center(child: Text('Status'));
              break;
            case 1:
              label = const Center(child: Text('Edit'));
              break;
            default:
              final dataCol = col - 2;
              if (dataCol < columnHeaders.length) {
                label = Center(
                  child: Text(getItemLocalString(
                    columnHeaders[dataCol].label.unlock,
                    defaultString: columnHeaders[dataCol].name,
                  )),
                );
              } else {
                final tail = dataCol - columnHeaders.length;
                label = Center(
                  child: Text(
                    tail == 0
                        ? 'Created'
                        : tail == 1
                        ? 'Modified'
                        : 'Delete',
                  ),
                );
              }
          }
          return TableViewCell(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.titleMedium!,
              child: label,
            ),
          );
        }

        // Data rows
        final submission = submissions[row - 1];
        Widget cellContent;
        switch (col) {
          case 0:
            cellContent = GestureDetector(
              onTap: submission.syncState.isSyncFailed
                  ? () => buildShowDialog(context, submission)
                  : null,
              child: StatusIcon(syncState: submission.syncState),
            );
            break;
          case 1:
            cellContent = IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: submission.deleted
                    ? null
                    : () async {
                  goToDataEntryForm(
                      context, ref.read(assignmentProvider), submission);
                });
            break;
          default:
            final dataCol = col - 2;
            if (dataCol < columnHeaders.length) {
              final values =
              _extractValues(submission.formData ?? {}, template);
              final text =
                  values[columnHeaders[dataCol].name]?.toString() ?? '';
              cellContent = Text(text);
            } else {
              final tail = dataCol - columnHeaders.length;
              if (tail == 0) {
                cellContent = Text(_formatDate(submission.createdDate));
              } else if (tail == 1) {
                cellContent = Text(_formatDate(submission.lastModifiedDate));
              } else {
                cellContent = IconButton(
                  icon: Icon(
                    submission.deleted
                        ? Icons.settings_backup_restore
                        : Icons.delete,
                    size: 20,
                  ),
                  onPressed: () => _confirmDelete(
                    context,
                    submission.id,
                    submission.deleted ? 'Restore' : 'Delete',
                    ref,
                  ),
                );
              }
            }
        }

        return TableViewCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(child: cellContent),
          ),
        );
      },

      // Link scroll controllers if needed
      horizontalDetails: ScrollableDetails.horizontal(controller: hController),
      verticalDetails: ScrollableDetails.vertical(controller: vController),
    );
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final selectedSubmissions = useState<IList<DataInstance>>(IList());
  //   final toSync = selectedSubmissions.value
  //       .where((s) =>
  //           SubmissionListUtil.getSyncStatus(s) == SyncStatus.TO_POST ||
  //           SubmissionListUtil.getSyncStatus(s) == SyncStatus.ERROR)
  //       .map((s) => s.id)
  //       .toList();
  //   final _sortColumnIndex = useState<int?>(null);
  //   final _sortAscending = useState(true);
  //   final ScrollController _horizontalController = useScrollController();
  //
  //   final submissionAsync =
  //       ref.watch(formSubmissionsProvider(template.template.id));
  //   if (submissionAsync.isLoading) {
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  //   if (submissionAsync.hasError) {
  //     return getErrorWidget(submissionAsync.error, submissionAsync.stackTrace);
  //   }
  //   // .where((s) => assignment != null ? s.assignment == assignment : true)
  //   // .toList();
  //   final submissions = useState(submissionAsync.requireValue);
  //
  //   void _sort<T>(Comparable<T> Function(DataInstance d) getField,
  //       int columnIndex, bool ascending) {
  //     submissions.value.sort((a, b) {
  //       final aValue = getField(a);
  //       final bValue = getField(b);
  //       return ascending
  //           ? Comparable.compare(aValue, bValue)
  //           : Comparable.compare(bValue, aValue);
  //     });
  //     _sortColumnIndex.value = columnIndex;
  //     _sortAscending.value = ascending;
  //   }
  //
  //   final columnHeaders = template.template.fields.where((entry) {
  //     final field = entry;
  //     return field.mainField;
  //   }).toList();
  //   final title = getItemLocalString(template.template.label,
  //       defaultString: template.template.name);
  //
  //   return DataTable2(
  //     horizontalScrollController: ScrollController(),
  //     key: ValueKey('${assignment}_submissions_table'),
  //     sortAscending: _sortAscending.value,
  //     sortColumnIndex: _sortColumnIndex.value,
  //     columns: <DataColumn>[
  //       DataColumn(
  //         label: Text(S.of(context).status),
  //         onSort: (columnIndex, ascending) {
  //           _sort<String>((d) => d.syncState.name, columnIndex, ascending);
  //         },
  //       ),
  //       DataColumn(label: Text(S.of(context).edit)),
  //       ...columnHeaders.map((header) => DataColumn(
  //           label: Text(getItemLocalString(header.label.unlock,
  //               defaultString: header.name)))),
  //       DataColumn(
  //         label: Text(S.of(context).createdDate),
  //         onSort: (columnIndex, ascending) {
  //           _sort<DateTime>((d) => d.createdDate ?? DateTime.now(),
  //               columnIndex, ascending);
  //         },
  //       ),
  //       DataColumn(
  //         label: Text(S.of(context).lastmodifiedDate),
  //         onSort: (columnIndex, ascending) {
  //           _sort<DateTime>((d) => d.lastModifiedDate ?? DateTime.now(),
  //               columnIndex, ascending);
  //         },
  //       ),
  //       DataColumn(label: Text(S.of(context).deleteRestore)),
  //     ],
  //     rows: submissions.value.map((submission) {
  //       final deleted = (submission.deleted);
  //       final textStyle = deleted
  //           ? const TextStyle(decoration: TextDecoration.lineThrough)
  //           : null;
  //       Map<String, dynamic> extractedValues = {};
  //       // Map<String, dynamic> totalResources = {};
  //       try {
  //         extractedValues =
  //             _extractValues(submission.formData ?? {}, template);
  //         // totalResources = _sumNumericResources(submission.formData ?? {});
  //       } catch (e, s) {
  //         // log
  //         debugPrintStack(stackTrace: s);
  //       }
  //
  //       return DataRow(
  //         color: deleted ? WidgetStateProperty.all(Colors.grey[700]) : null,
  //         selected: selectedSubmissions.value.contains(submission),
  //         onSelectChanged: (selected) {
  //           if (selected == true) {
  //             selectedSubmissions.value =
  //                 selectedSubmissions.value.add(submission);
  //           } else {
  //             selectedSubmissions.value =
  //                 selectedSubmissions.value.remove(submission);
  //           }
  //         },
  //         cells: <DataCell>[
  //           DataCell(GestureDetector(
  //             onTap: submission.syncState.isSyncFailed
  //                 ? () => buildShowDialog(context, submission)
  //                 : null,
  //             child: StatusIcon(syncState: submission.syncState),
  //           )),
  //           DataCell(IconButton(
  //             onPressed: !deleted
  //                 ? () async {
  //               final assignmentModel = ref.read(assignmentProvider);
  //               goToDataEntryForm(
  //                   context, assignmentModel, submission);
  //               // ref.invalidate(assignmentsProvider);
  //             }
  //                 : null,
  //             icon: const Icon(Icons.edit),
  //             // label: Text(S.of(context).edit),
  //           )),
  //           ...columnHeaders.map(
  //                 (header) => DataCell(
  //               Text(extractedValues[header.name]?.toString() ?? '',
  //                   style: textStyle),
  //             ),
  //           ),
  //           DataCell(Text(_formatDate(submission.createdDate),
  //               style: textStyle)),
  //           DataCell(Text(_formatDate(submission.lastModifiedDate),
  //               style: textStyle)),
  //           DataCell(IconButton(
  //             icon: Icon(
  //                 deleted ? Icons.settings_backup_restore : Icons.delete,
  //                 size: 20),
  //             onPressed: () => _confirmDelete(
  //                 context,
  //                 submission.id,
  //                 deleted
  //                     ? S.of(context).restoreItem
  //                     : S.of(context).deleteConfirmationMessage,
  //                 ref),
  //             tooltip: deleted
  //                 ? S.of(context).restoreItem
  //                 : S.of(context).deleteItem,
  //           )),
  //         ],
  //       );
  //     }).toList(),
  //   );
  // }

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
      fields.forEach((Template field) {
        if (field.name != null) {
          if (field is SectionTemplate && data.containsKey(field.name)) {
            if (field.repeatable && data[field.name] is List) {
              final items = data[field.name]
                  .map<Map<String, dynamic>>(
                      (item) => Map<String, dynamic>.of(item))
                  .toList();
              _extract(_sumNumericResources(items), field.children);
            } else {
              _extract(
                  data[field.name],
                  ElementTreeService.getImmediateChildren(
                      field.path, field.children));
            }
          } else if (field.type == ValueType.Progress &&
              data.containsKey(field.name)) {
            final value = ((AssignmentStatus.values
                .firstOrNullWhere((t) => t.name == data[field.name])
                ?.name ??
                data[field.name])
                ?.toString());
            extractedValues[field.name!] =
            value != null ? Intl.message(value.toLowerCase()) : '-';
          }
          /*else if (field.type == ValueType.Team &&
              data.containsKey(field.name)) {
            extractedValues[field.name!] = activityModel.managedTeams
                    .firstOrNullWhere((t) => t.id == data[field.name])
                    ?.name ??
                data[field.name];
          }*/
          else if (field is FieldTemplate &&
              field.type.isSelectType == true &&
              field.optionSet != null &&
              data.containsKey(field.name)) {
            final optionMap = formTemplate.optionMap;
            final String? optionSetName =
                formTemplate.optionSets[field.optionSet!]?.name;
            final List<DataOption> options = optionMap[optionSetName] ?? [];
            final List<DataOption> option = options
                .where((o) =>
            o.name == data[field.name] || o.code == data[field.name])
                .toList();
            extractedValues[field.name!] = option
                .map((o) => getItemLocalString(o.label, defaultString: ''))
                .join(',');
          } else if (data.containsKey(field.name)) {
            extractedValues[field.name!] = data[field.name];
          }
        }
      });
    }

    _extract(
        formData, [...formTemplate.template.fields, ...formTemplate.sections]);
    return extractedValues;
  }

  Map<String, double> _sumNumericResources(
      List<Map<String, dynamic>> formData) {
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

    for (var formData in formData) {
      _sumResources(formData);
    }

    // _sumResources(formData);
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
                  .read(formSubmissionsProvider(template.template.id).notifier)
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
    ref.read(formSubmissionsProvider(template.template.id).notifier);
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

// Map<String, dynamic> _extractValues(
//     Map<String, dynamic> formData, FormTemplateRepository formTemplate) {
//   Map<String, dynamic> extractedValues = {};
//
//   void _extract(Map<String, dynamic> data, Iterable<Template> fields) {
//     fields.forEach((field) {
//       // if (field.name != null) {
//       if (field.repeatable && data.containsKey(field.name)) {
//         _sumNumericResources(formData);
//         _extract(data[field.name], field.children);
//         // extractedValues[field.name!] = data[field.name];
//       } else if (field is SectionTemplate && data.containsKey(field.name)) {
//         _extract(data[field.name], field.children.toList());
//       } else if (field.type == ValueType.Progress &&
//           data.containsKey(field.name)) {
//         final value = ((AssignmentStatus.getType(data[field.name])?.name ??
//                 data[field.name])
//             ?.toString());
//         extractedValues[field.name!] =
//             value != null ? Intl.message(value.toLowerCase()) : '-';
//         // } else if (field.type == ValueType.Team &&
//         //     data.containsKey(field.name)) {
//         //   extractedValues[field.name!] = activityModel.managedTeams
//         //           .firstOrNullWhere((t) => t.id == data[field.name])
//         //           ?.name ??
//         //       data[field.name];
//       } else if (field.type?.isSelectType == true &&
//           formTemplate.optionSets[field.optionSet] != null &&
//           data.containsKey(field.name)) {
//         extractedValues[field.name!] = data[field.name];
//       } else if (field.type?.isDateTime == true) {
//         final value = data[field.name];
//         extractedValues[field.name!] = value != null
//             ? DateHelper.getEffectiveUiFormat(field.type)
//                 .tryParse(data[field.name])
//             : value;
//       } else if (field.name != null) {
//         extractedValues[field.name!] = data[field.name];
//       }
//       // }
//     });
//   }
//
//   _extract(formData, formTemplate.rootSection.children);
//   return extractedValues;
// }
}

String _formatDate(DateTime? dateStr) {
  if (dateStr == null) return '';
  final dateTime = dateStr.toLocal();
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}
