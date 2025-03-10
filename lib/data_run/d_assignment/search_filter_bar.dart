import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/assignment_provider.dart';
import 'package:datarun/data_run/d_team/team_model.dart';
import 'package:datarun/data_run/d_team/team_provider.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SearchFilterBar extends ConsumerWidget {
  const SearchFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.onStatusChanged,
    // required this.onScopeChanged,
    required this.onDayChanged,
    required this.onClearFilters,
    required this.onTeamChanged,
    required this.isCardView,
  });

  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onTeamChanged;
  final ValueChanged<AssignmentStatus?> onStatusChanged;

  // final ValueChanged<EntityScope?> onScopeChanged;
  final ValueChanged<int?> onDayChanged;
  final VoidCallback onClearFilters;
  final bool isCardView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(teamsProvider(EntityScope.Managed));
    final filterQuery = ref.watch(filterQueryProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            highlightColor: Theme.of(context).highlightColor,
            tooltip: S.of(context).clearFilters,
            onPressed: filterQuery.filters.isNotEmpty ? onClearFilters : null,
            icon: const Icon(Icons.clear, color:  Colors.orange,)),
        // Search Bar
        TextFormField(
          initialValue: filterQuery.searchQuery,

          decoration: InputDecoration(
            hintText: S.of(context).search,
            prefixIcon: const Icon(Icons.search, color: Colors.orange,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusColor: Theme.of(context).focusColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 30),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
          onChanged: onSearchChanged,
        ),
        const SizedBox(width: 8),
        AsyncValueWidget(
          value: teamsAsync,
          valueBuilder: (IList<TeamModel> teams) {
            return DropdownButton<String>(
                value: filterQuery.filters['teams']?.isNotEmpty == true
                    ? filterQuery.filters['teams'].first
                    : null,
                hint: Text(
                  S.of(context).team,
                  softWrap: true,
                ),
                onChanged: onTeamChanged,
                items: teams.map((TeamModel team) {
                  return DropdownMenuItem<String>(
                    value: team.id,
                    child: Text(
                      team.name!,
                      softWrap: true,
                    ),
                  );
                }).toList());
          },
        ),
        const SizedBox(width: 8),
        DropdownButton<int>(
          value: filterQuery.filters['days']?.isNotEmpty == true
              ? filterQuery.filters['days'].first
              : null,
          hint: Text(
            S.of(context).dueDay,
            softWrap: true,
          ),
          onChanged: onDayChanged,
          items: [1, 2, 3, 4, 5, 6].map((value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                '${S.of(context).day} $value',
                softWrap: true,
              ),
            );
          }).toList(),
        ),
        const SizedBox(width: 8),
        // Status Filter
        DropdownButton<AssignmentStatus>(
          value: filterQuery.filters['status'],
          hint: Text(
            S.of(context).status,
            softWrap: true,
          ),
          onChanged: onStatusChanged,
          items: AssignmentStatus.values.map((AssignmentStatus value) {
            return DropdownMenuItem<AssignmentStatus>(
              value: value,
              child: Text(Intl.message(value.name.toLowerCase())),
            );
          }).toList(),
        ),
        // const SizedBox(width: 8),
        // // Scope Filter
        // DropdownButton<EntityScope>(
        //   value: filterQuery.filters['scope'],
        //   hint: Text(
        //     S.of(context).scope,
        //     softWrap: true,
        //   ),
        //   onChanged: onScopeChanged,
        //   items: EntityScope.values.map((EntityScope value) {
        //     return DropdownMenuItem<EntityScope>(
        //       value: value,
        //       child: Text(
        //         Intl.message(value.name.toLowerCase()),
        //         softWrap: true,
        //       ),
        //     );
        //   }).toList(),
        // )
      ],
    );
  }
}

// class SearchFilterBar extends StatelessWidget {
//   const SearchFilterBar({
//     super.key,
//     required this.onSearchChanged,
//     required this.onStatusChanged,
//     required this.onScopeChanged,
//     required this.onDateRangeChanged,
//     required this.onToggleView,
//     required this.isCardView,
//   });
//
//   final ValueChanged<String> onSearchChanged;
//   final ValueChanged<AssignmentStatus?> onStatusChanged;
//   final ValueChanged<EntityScope?> onScopeChanged;
//   final ValueChanged<DateTimeRange?> onDateRangeChanged;
//   final ValueChanged<bool> onToggleView;
//   final bool isCardView;
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       alignment: WrapAlignment.spaceBetween,
//       children: [
//         IconButton(
//           tooltip: 'Toggle between List and Card view',
//           icon: Icon(isCardView ? Icons.view_list : Icons.view_module),
//           onPressed: () {
//             onToggleView(!isCardView);
//           },
//         ),
//         SizedBox(
//           width: 200,
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               prefixIcon: Icon(Icons.search),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: () => onSearchChanged(''),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             onChanged: onSearchChanged,
//           ),
//         ),
//         FilterChip(
//           label: Text('Status'),
//           onSelected: (isSelected) {
//             // Open a dropdown/modal for detailed filtering
//           },
//         ),
//         FilterChip(
//           label: Text('Scope'),
//           onSelected: (isSelected) {
//             // Open a dropdown/modal for detailed filtering
//           },
//         ),
//         IconButton(
//           tooltip: 'Select Date Range',
//           icon: Icon(Icons.date_range),
//           onPressed: () async {
//             final DateTimeRange? picked = await showDateRangePicker(
//               context: context,
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2101),
//             );
//             onDateRangeChanged(picked);
//           },
//         ),
//         TextButton.icon(
//           onPressed: () {
//             // Clear all filters logic
//           },
//           icon: Icon(Icons.clear_all),
//           label: Text('Clear Filters'),
//         ),
//       ],
//     );
//   }
// }

// class SearchFilterBar extends StatelessWidget {
//   const SearchFilterBar({
//     super.key,
//     required this.onSearchChanged,
//     required this.onStatusChanged,
//     required this.onScopeChanged,
//     required this.onDateRangeChanged,
//     required this.onToggleView,
//     required this.isCardView,
//   });
//
//   final ValueChanged<String> onSearchChanged;
//   final ValueChanged<AssignmentStatus?> onStatusChanged;
//   final ValueChanged<EntityScope?> onScopeChanged;
//   final ValueChanged<DateTimeRange?> onDateRangeChanged;
//   final ValueChanged<bool> onToggleView;
//   final bool isCardView;
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       alignment: WrapAlignment.spaceBetween,
//       children: [
//         IconButton(
//           tooltip: 'Toggle between List and Card view',
//           icon: Icon(isCardView ? Icons.view_list : Icons.view_module),
//           onPressed: () {
//             onToggleView(!isCardView);
//           },
//         ),
//         SizedBox(
//           width: 200,
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               prefixIcon: Icon(Icons.search),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: () => onSearchChanged(''),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             onChanged: onSearchChanged,
//           ),
//         ),
//         FilterChip(
//           label: Text('Status'),
//           onSelected: (isSelected) {
//             // Open a dropdown/modal for detailed filtering
//           },
//         ),
//         FilterChip(
//           label: Text('Scope'),
//           onSelected: (isSelected) {
//             // Open a dropdown/modal for detailed filtering
//           },
//         ),
//         IconButton(
//           tooltip: 'Select Date Range',
//           icon: Icon(Icons.date_range),
//           onPressed: () async {
//             final DateTimeRange? picked = await showDateRangePicker(
//               context: context,
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2101),
//             );
//             onDateRangeChanged(picked);
//           },
//         ),
//         TextButton.icon(
//           onPressed: () {
//             // Clear all filters logic
//           },
//           icon: Icon(Icons.clear_all),
//           label: Text('Clear Filters'),
//         ),
//       ],
//     );
//   }
// }
