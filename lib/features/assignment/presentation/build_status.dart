import 'package:datarunmobile/database/shared/assignment_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildStatusBadge(AssignmentStatus status,
    [double? size, ValueKey<dynamic>? key]) {
  IconData statusIcon;
  Color badgeColor;

  switch (status) {
    case AssignmentStatus.NOT_STARTED:
      statusIcon = Icons.schedule;
      badgeColor = Colors.grey;
      break;
    case AssignmentStatus.IN_PROGRESS:
      statusIcon = Icons.timelapse;
      badgeColor = Colors.blue;
      break;
    case AssignmentStatus.DONE:
      statusIcon = Icons.check_circle;
      badgeColor = Colors.green;
      break;
    case AssignmentStatus.RESCHEDULED:
      statusIcon = Icons.event_repeat;
      badgeColor = Colors.orange;
      break;
    case AssignmentStatus.CANCELLED:
      statusIcon = Icons.cancel;
      badgeColor = Colors.red;
      break;
    case AssignmentStatus.MERGED:
      statusIcon = Icons.merge_type;
      badgeColor = Colors.blueGrey;
      break;
    case AssignmentStatus.REASSIGNED:
      statusIcon = Icons.assignment_ind;
      badgeColor = Colors.deepPurpleAccent;
      break;
    default:
      statusIcon = Icons.help_outline;
      badgeColor = Colors.black;
  }

  return Tooltip(
    key: key,
    message: Intl.message(status.name.toLowerCase()),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        statusIcon,
        color: Colors.white,
        size: size,
      ),
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
