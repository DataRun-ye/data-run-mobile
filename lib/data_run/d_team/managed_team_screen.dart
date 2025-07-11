import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:datarunmobile/data_run/d_team/team_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageTeamsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = teamSummaries; //ref.watch(teamListProvider);
    final expandedTeams = ref.watch(expandedTeamsProvider);
    final filter = ref.watch(filterProvider);
    final sort = ref.watch(sortProvider);

    // Apply filter and sorting logic
    final filteredTeams = teams
        .where((team) => filter == null || team.name.contains(filter))
        .toList()
      ..sort((a, b) {
        if (sort == 'Alphabetical') return a.name.compareTo(b.name);
        if (sort == 'Overdue Count')
          return b.assignmentsOverdue.compareTo(a.assignmentsOverdue);
        return 0;
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Teams'),
        actions: [
          // Filter Button
          PopupMenuButton<String>(
            onSelected: (value) =>
                ref.read(filterProvider.notifier).state = value,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Overdue', child: Text('Overdue')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
            ],
          ),
          // Sort Button
          PopupMenuButton<String>(
            onSelected: (value) =>
                ref.read(sortProvider.notifier).state = value,
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'Alphabetical', child: Text('Alphabetical')),
              const PopupMenuItem(
                  value: 'Overdue Count', child: Text('Overdue Count')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTeams.length,
        itemBuilder: (context, index) {
          final team = filteredTeams[index];
          final isExpanded = expandedTeams.contains(team.id);

          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(team.name),
                  subtitle: Text('Assignments: ${team.assignmentsTotal}'),
                  trailing: IconButton(
                    icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () => ref
                        .read(expandedTeamsProvider.notifier)
                        .toggle(team.id),
                  ),
                ),
                if (isExpanded) _buildExpandedDetails(context, team, ref),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandedDetails(
      BuildContext context, TeamSummary team, WidgetRef ref) {
    return Column(
      children: [
        // Assignment Breakdown
        ListTile(
          title: Text('Completed: ${team.assignmentsCompleted}'),
          subtitle: Text('Overdue: ${team.assignmentsOverdue}'),
        ),
        // Resource Details
        DataTable(
            columns: [
              const DataColumn(label: Text('Resource')),
              const DataColumn(label: Text('Allocated')),
              const DataColumn(label: Text('Used')),
            ],
            rows: team.resources.map((resource) {
              return DataRow(cells: [
                DataCell(Text(resource.name)),
                DataCell(Text(resource.allocated.toString())),
                DataCell(Text(resource.used.toString())),
              ]);
            }).toList()),
        // Reallocate Button
        TextButton(
          onPressed: () => _showReallocateModal(context, team, ref),
          child: const Text('Reallocate Resources'),
        ),
        // Activity Feed
        ...team.activities.map((activity) => ListTile(
              title: Text(activity.title),
              subtitle: Text(activity.timestamp),
            )),
      ],
    );
  }

  void _showReallocateModal(
      BuildContext context, TeamSummary team, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ResourceReallocationModal(team: team, ref: ref);
      },
    );
  }

  final List<TeamSummary> teamSummaries = [
    TeamSummary(
      id: 'team_001',
      name: 'Alpha Team',
      assignmentsTotal: 50,
      assignmentsCompleted: 45,
      assignmentsOverdue: 2,
      resources: [
        Resource(name: 'ITNs', allocated: 3000, used: 2500),
        Resource(name: 'MedKits', allocated: 150, used: 120),
      ],
      activities: [
        ActivityFeedItem(
            title: 'Completed distribution in Zone A',
            timestamp: '2024-01-15T08:30:00Z'),
        ActivityFeedItem(
            title: 'Started new survey in Zone B',
            timestamp: '2024-01-16T09:00:00Z'),
      ],
    ),
    TeamSummary(
      id: 'team_002',
      name: 'Beta Team',
      assignmentsTotal: 30,
      assignmentsCompleted: 28,
      assignmentsOverdue: 1,
      resources: [
        Resource(name: 'ITNs', allocated: 2000, used: 1800),
        Resource(name: 'MedKits', allocated: 100, used: 90),
      ],
      activities: [
        ActivityFeedItem(
            title: 'Completed survey in Zone C',
            timestamp: '2024-01-10T10:00:00Z'),
        ActivityFeedItem(
            title: 'Started distribution in Zone D',
            timestamp: '2024-01-12T11:30:00Z'),
      ],
    ),
    TeamSummary(
      id: 'team_003',
      name: 'Gamma Team',
      assignmentsTotal: 70,
      assignmentsCompleted: 65,
      assignmentsOverdue: 3,
      resources: [
        Resource(name: 'ITNs', allocated: 5000, used: 4500),
        Resource(name: 'MedKits', allocated: 200, used: 150),
      ],
      activities: [
        ActivityFeedItem(
            title: 'Training session completed',
            timestamp: '2024-01-05T12:00:00Z'),
        ActivityFeedItem(
            title: 'Started new survey in Zone E',
            timestamp: '2024-01-06T13:30:00Z'),
      ],
    ),
    TeamSummary(
      id: 'team_004',
      name: 'Delta Team',
      assignmentsTotal: 40,
      assignmentsCompleted: 35,
      assignmentsOverdue: 2,
      resources: [
        Resource(name: 'ITNs', allocated: 2500, used: 2200),
        Resource(name: 'MedKits', allocated: 120, used: 100),
      ],
      activities: [
        ActivityFeedItem(
            title: 'Completed campaign in Zone F',
            timestamp: '2024-01-20T14:00:00Z'),
        ActivityFeedItem(
            title: 'Preparing for next campaign',
            timestamp: '2024-01-21T15:30:00Z'),
      ],
    ),
    TeamSummary(
      id: 'team_005',
      name: 'Epsilon Team',
      assignmentsTotal: 100,
      assignmentsCompleted: 90,
      assignmentsOverdue: 5,
      resources: [
        Resource(name: 'ITNs', allocated: 8000, used: 7500),
        Resource(name: 'MedKits', allocated: 300, used: 250),
      ],
      activities: [
        ActivityFeedItem(
            title: 'Major distribution event',
            timestamp: '2024-01-25T16:00:00Z'),
        ActivityFeedItem(
            title: 'Started follow-up surveys',
            timestamp: '2024-01-26T17:30:00Z'),
      ],
    ),
  ];
}

class ResourceReallocationModal extends StatelessWidget {
  ResourceReallocationModal({required this.team, required this.ref});

  final TeamSummary team;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final resourceControllers = team.resources
        .map((resource) =>
            TextEditingController(text: resource.allocated.toString()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Reallocate Resources for ${team.name}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ...team.resources.asMap().entries.map((entry) {
            final index = entry.key;
            final resource = entry.value;

            return TextField(
              controller: resourceControllers[index],
              decoration: InputDecoration(labelText: resource.name),
              keyboardType: TextInputType.number,
            );
          }).toList(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final updatedResources =
                  team.resources.asMap().entries.map((entry) {
                final index = entry.key;
                final resource = entry.value;
                return Resource(
                  name: resource.name,
                  allocated: int.parse(resourceControllers[index].text),
                  used: resource.used,
                );
              }).toList();

              ref
                  .read(teamListProvider.notifier)
                  .updateResources(team.id, updatedResources);
              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
