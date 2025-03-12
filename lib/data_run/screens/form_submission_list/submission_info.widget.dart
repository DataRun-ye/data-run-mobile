import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/section_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/template.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:datarunmobile/core/form/element_iterator/field_template_traverse.extension.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/sync_status_icon.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarunmobile/data/submission_list.provider.dart';
import 'package:datarunmobile/data_run/form/form_submission/submission_summary.model.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/q_sync_icon_button.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';

class SubmissionInfo extends ConsumerStatefulWidget {
  const SubmissionInfo({
    super.key,
    required this.rootSection,
    this.onTap,
    required this.submissionEntity,
    this.onSyncPressed,
  });

  final GestureTapCallback? onTap;
  final DataFormSubmission submissionEntity;
  final SectionTemplate rootSection;
  final Function(String uid)? onSyncPressed;

  @override
  SubmissionInfoState createState() => SubmissionInfoState();
}

class SubmissionInfoState extends ConsumerState<SubmissionInfo> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<SubmissionItemSummaryModel> submissionSummaryModelValue =
        ref.watch(submissionInfoProvider(
            formMetadata: FormMetadataWidget.of(context)));

    return submissionSummaryModelValue.when(
      error: (error, stackTrace) => getErrorWidget(error, stackTrace),
      data: (submissionSummary) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              child: buildStatusIcon(submissionSummary.syncStatus),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
            const SizedBox(height: 4),
            Text(
              'V${widget.submissionEntity.version}',
              style: Theme.of(context).textTheme.bodySmall,
              softWrap: true,
            ),
          ],
        ),
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                submissionSummary.orgUnit,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: () =>
                  _confirmDelete(context, widget.submissionEntity.id),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (submissionSummary.code != null)
              Text(
                'Code: ${submissionSummary.code}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            Text(
              generateFormSummary(
                  submissionSummary.formData.unlockView, widget.rootSection),
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: QSyncIconButton(
          state: submissionSummary.syncStatus,
          onUnsyncedPressed: () =>
              widget.onSyncPressed?.call(widget.submissionEntity.id!),
        ),
        onTap: widget.onTap,
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }

  Future<void> _confirmDelete(BuildContext context, String? uid) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirm),
          content: Text(S.of(context).deleteConfirmationMessage),
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
      _showUndoSnackBar(context, uid);
    }
  }

  void _showUndoSnackBar(BuildContext context, String? toDeleteUid) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final formMetadata = FormMetadataWidget.of(context);

    ref
        .read(formSubmissionsProvider(formMetadata.formId).notifier)
        .deleteSubmission([toDeleteUid]);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: const Text('Item removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Code to undo deletion
          },
        ),
      ),
    );
  }

  String generateFormSummary(
      Map<String, dynamic> fields, SectionTemplate rootSection,
      [int itemsToTake = 5]) {
    final flatFormValue = flattenValueMap(fields);

    final flatTemplate =
        getDfsTemplateIterator(rootSection).where((t) => t.mainField);
    Map<String, dynamic> labelsMap = Map.fromIterable(flatTemplate,
        key: (t) => t.path,
        value: (t) =>
            getItemLocalString((t.label as IMap<String, String?>).unlockView));

    final labelsValueMap = labelsMap.entries
        .map((e) => '${e.value}, ${flatFormValue[e.key]}')
        .toList();

    logDebug('flatFormValue: ${flatFormValue}');
    logDebug('labelsMap: ${labelsMap}');
    logDebug('labelsValueMap: ${labelsValueMap}');

    final String fieldSummary =
        // fields.entries
        //     .where((MapEntry<String, dynamic> entry) =>
        //         entry.key != 'name' &&
        //         entry.value != null &&
        //         !(entry.value is List) &&
        //         !syncableVariable.contains(entry.key))
        //     .take(itemsToTake)
        //     .map((MapEntry<String, dynamic> entry) => '${entry.key}: ${entry.value}')
        labelsValueMap.join(', ');

    return fieldSummary.isNotEmpty ? fieldSummary : 'No additional data';
  }
}

//
// final List<String> syncableVariable = <String>[
//   'id',
//   'lastSyncMessage',
//   'uid',
//   'code',
//   'name',
//   'orgUnit',
//   'createdDate',
//   'lastModifiedDate',
//   'deleted',
//   'synced',
//   'syncFailed',
//   'lastSyncSummary',
//   'lastSyncDate',
//   'startEntryTime',
//   'finishedEntryTime',
//   'activity',
//   'team',
//   'status',
//   'geometry',
//   'dirty',
//   'version',
//   'form',
//   'formData',
// ];

Map<String, dynamic> flattenValueMap(Map<String, dynamic> formValue,
    {String prefix = ''}) {
  Map<String, dynamic> flatMap = {};

  formValue.forEach((key, value) {
    String newKey = prefix.isEmpty ? key : '$prefix.$key';

    if (value is Map<String, dynamic>) {
      // If the value is a map, recursively flatten it
      flatMap.addAll(flattenValueMap(value, prefix: newKey));
    } else if (value is List) {
      // If the value is a list, iterate through each item and flatten
      for (int i = 0; i < value.length; i++) {
        flatMap.addAll(
            flattenValueMap({i.toString(): value[i]}, prefix: '$newKey.$i'));
      }
    } else {
      // Otherwise, it's a leaf node (error value), add it to the flatMap
      flatMap[newKey] = value;
    }
  });

  return flatMap;
}

List<dynamic> extractValues(
  Map<String, dynamic> formValues,
  List<Template> templates, {
  bool Function(Template)? criteria,
}) {
  final extractedValues = <dynamic>[];

  for (final template in templates) {
    // Check if this template matches the criteria
    if (criteria == null || criteria(template)) {
      if (formValues.containsKey(template.name)) {
        final value = formValues[template.name];
        if (template is SectionTemplate &&
            template.fields.isNotEmpty &&
            value is Map<String, dynamic>) {
          // If the value is a nested Map, recurse into it
          extractedValues.addAll(extractValues(
              value, template.fields.unlockView,
              criteria: criteria));
        } else if (template is SectionTemplate &&
            template.fields.isNotEmpty &&
            value is List) {
          // If the value is a List, iterate through it
          for (final item in value) {
            if (item is Map<String, dynamic>) {
              extractedValues.addAll(extractValues(
                  item, template.fields.unlockView,
                  criteria: criteria));
            } else {
              extractedValues.add(item);
            }
          }
        } else {
          // Otherwise, collect the value
          extractedValues.add(value);
        }
      }
    }
  }

  return extractedValues;
}
