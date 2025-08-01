import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({required this.activity, required this.onTap, super.key});

  final ActivityModel activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity Name
              Text(
                activity.displayLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 12.0),
              const Divider(),
              // Assigned Team
              if (activity.assignedTeam?.name != null)
                Row(
                  children: [
                    Icon(Icons.group, color: cs.secondary),
                    const SizedBox(width: 8.0),
                    Text(
                      '${S.of(context).assignedTeam}: ${activity.assignedTeam!.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

              // Managed Teams and Assignments
              if(activity.managedTeams.length > 0)
              _infoRow(
                context,
                icon: Icons.groups,
                label: S.of(context).managedTeams,
                value: activity.managedTeams.length.toString(),
              ),
              if(activity.assignedAssignments > 0)
              _infoRow(
                context,
                icon: Icons.assignment,
                label: S.of(context).assignedAssignments,
                value: activity.assignedAssignments.toString(),
              ),
              if(activity.managedAssignments > 0)
              _infoRow(
                context,
                icon: Icons.assignment_turned_in,
                label: S.of(context).managedAssignments,
                value: activity.managedAssignments.toString(),
              ),

              // Start Date and End Date
              if (activity.properties['startDate'] != null)
                _infoRow(
                  context,
                  icon: Icons.calendar_today,
                  label: S.of(context).startDate,
                  value: formatDateString(
                    activity.properties['startDate'],
                    context,
                  ),
                ),
              if (activity.properties['endDate'] != null)
                _infoRow(
                  context,
                  icon: Icons.event,
                  label: S.of(context).endDate,
                  value: formatDateString(
                    activity.properties['endDate'],
                    context,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '$label: $value',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date, BuildContext context) {
  return MaterialLocalizations.of(context).formatFullDate(date);
}

String formatDateString(String date, BuildContext context) {
  final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", 'en_US');
  final formattedDate = dateFormat.tryParse(date);
  if (formattedDate == null) return '';
  return MaterialLocalizations.of(context).formatFullDate(formattedDate);
}
