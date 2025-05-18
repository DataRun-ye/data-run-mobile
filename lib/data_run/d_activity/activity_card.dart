import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'activity_model.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({required this.activity, required this.onTap, super.key});

  final ActivityModel activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                activity.activity?.name ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 8.0),

              // Assigned Team
              if (activity.assignedTeam?.name != null)
                Row(
                  children: [
                    const Icon(Icons.group, color: Colors.grey),
                    const SizedBox(width: 8.0),
                    Text(
                      '${S.of(context).assignedTeam}: ${activity.assignedTeam!.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

              const SizedBox(height: 12.0),
              Divider(color: Colors.grey.shade300, thickness: 1.0),

              // Managed Teams and Assignments
              _infoRow(
                context,
                icon: Icons.groups,
                label: S.of(context).managedTeams,
                value: activity.managedTeams.length.toString(),
              ),
              _infoRow(
                context,
                icon: Icons.assignment,
                label: S.of(context).assignedAssignments,
                value: activity.assignedAssignments.toString(),
              ),
              _infoRow(
                context,
                icon: Icons.assignment_turned_in,
                label: S.of(context).managedAssignments,
                value: activity.managedAssignments.toString(),
              ),

              // Start Date and End Date
              if (activity.startDate != null)
                _infoRow(
                  context,
                  icon: Icons.calendar_today,
                  label: S.of(context).startDate,
                  value: MaterialLocalizations.of(context).formatFullDate(
                    activity.startDate!,
                  ),
                ),
              if (activity.endDate != null)
                _infoRow(
                  context,
                  icon: Icons.event,
                  label: S.of(context).endDate,
                  value: MaterialLocalizations.of(context).formatFullDate(
                    activity.endDate!,
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
          Icon(icon, size: 20, color: Colors.grey),
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

// String formatDate(DateTime date, BuildContext context) {
//   return MaterialLocalizations.of(context).formatFullDate(date);
// }
