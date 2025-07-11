import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:datarunmobile/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form/form_tab_screen.widget.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget buildStatusBadge(AssignmentStatus status) {
  IconData statusIcon;
  Color badgeColor;

  switch (status) {
    case AssignmentStatus.NOT_STARTED:
      statusIcon = MdiIcons.progressClock; // More expressive icon
      badgeColor = Colors.grey;
      break;
    case AssignmentStatus.IN_PROGRESS:
      statusIcon = MdiIcons.circleSlice6; // More expressive icon
      badgeColor = Colors.blue;
      break;
    case AssignmentStatus.DONE:
      statusIcon = MdiIcons.checkCircle; // More expressive icon
      badgeColor = Colors.green;
      break;
    case AssignmentStatus.RESCHEDULED:
      statusIcon = MdiIcons.calendarArrowRight; // More expressive icon
      badgeColor = Colors.orange;
      break;
    case AssignmentStatus.CANCELLED:
      statusIcon = MdiIcons.bookCancel; // More expressive icon
      badgeColor = Colors.red;
      break;
    case AssignmentStatus.MERGED:
      statusIcon = MdiIcons.merge; // More expressive icon
      badgeColor = Colors.blueGrey;
      break;
    case AssignmentStatus.REASSIGNED:
      statusIcon = MdiIcons.clipboardAccount; // More expressive icon
      badgeColor = Colors.deepPurpleAccent;
      break;
    default:
      statusIcon = MdiIcons.helpCircleOutline; // More expressive icon
      badgeColor = Colors.black;
  }

  // return Badge(
  //   child: Icon(statusIcon, color: Colors.white),
  //   textColor: badgeColor,
  // );

  return Tooltip(
    message: Intl.message(status.name.toLowerCase()),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(statusIcon, color: Colors.white),
    ),
  );
}

Color? statusColor(AssignmentStatus? status) {
  switch (status) {
    case AssignmentStatus.IN_PROGRESS:
      return Colors.greenAccent.withValues(alpha: 0.5);
    case AssignmentStatus.DONE:
      return null;
    case AssignmentStatus.CANCELLED:
    case AssignmentStatus.MERGED:
    case AssignmentStatus.REASSIGNED:
      return Colors.orangeAccent.withValues(alpha: 0.5);
    case AssignmentStatus.NOT_STARTED:
    case AssignmentStatus.RESCHEDULED:
      return Colors.grey.withValues(alpha: 0.3);
    default:
      return Colors.grey.withValues(alpha: 0.3);
  }
}

Future<void> goToDataEntryForm(BuildContext context, AssignmentModel assignment,
    DataInstance submission, ActivityModel activityModel) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ActivityInheritedWidget(
                activityModel: activityModel,
                child: FormMetadataWidget(
                  formMetadata: FormMetadata(
                    assignmentModel: assignment,
                    versionUid: submission.templateVersion,
                    // formId: '${submission.form}_${submission.version}',
                    formId: submission.formTemplate,
                    // version: submission.templateVersion,
                    submission: submission.id,
                  ),
                  child: const FormSubmissionScreen(currentPageIndex: 1),
                ),
              )));
}
