import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarunmobile/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/assignment_detail_page.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_table_view.dart';
import 'package:datarunmobile/data_run/d_assignment/assignments_card_view.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/data/activity/assignment.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/search_filter_bar.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignmentPage extends HookConsumerWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Toggle View Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  ref.watch(filterQueryProvider
                          .select((value) => value.isCardView))
                      ? Icons.table_chart
                      : Icons.view_agenda,
                ),
                onPressed: () {
                  ref.read(filterQueryProvider.notifier).toggleCardTableView();
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SearchFilterBar(
              onSearchChanged: (query) => ref
                  .read(filterQueryProvider.notifier)
                  .updateSearchQuery(query),
              onStatusChanged: (status) => ref
                  .read(filterQueryProvider.notifier)
                  .updateFilter('status', status),
              onDayChanged: (day) {
                ref
                    .read(filterQueryProvider.notifier)
                    .updateFilter('days', [day]);
              },
              onClearFilters: () =>
                  ref.read(filterQueryProvider.notifier).clearAllFilters(),
              isCardView: ref.watch(
                  filterQueryProvider.select((value) => value.isCardView)),
              onTeamChanged: (String? team) {
                ref
                    .read(filterQueryProvider.notifier)
                    .updateFilter('teams', [team]);
              },
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: S.of(context).assigned),
              Tab(text: S.of(context).managed),
            ],
            onTap: (index) {
              final scope =
                  index == 0 ? EntityScope.Assigned : EntityScope.Managed;
              ref
                  .read(filterQueryProvider.notifier)
                  .updateFilter('scope', scope);
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAssignmentList(context, ref, EntityScope.Assigned),
          _buildAssignmentList(context, ref, EntityScope.Managed),
        ],
      ),
    );
  }

  Widget _buildAssignmentList(
      BuildContext context, WidgetRef ref, EntityScope? scope) {
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceOut,
      duration: const Duration(milliseconds: 300),
      child: ref.watch(filterQueryProvider.select((value) => value.isCardView))
          ? AssignmentsCardView(
              key: const ValueKey('cardView'),
              scope: scope,
              onViewDetails: (assignment) =>
                  _navigateToDetails(context, assignment),
            )
          : AssignmentTableView(
              key: const ValueKey('tableView'),
              scope: scope,
              onViewDetails: (assignment) =>
                  _navigateToDetails(context, assignment),
            ),
    );
  }

  // Widget _buildDraggableMap(BuildContext context, WidgetRef ref) {
  //   return DraggableScrollableSheet(
  //     initialChildSize: 0.5,
  //     minChildSize: 0.2,
  //     maxChildSize: 0.8,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return Container(
  //         color: Colors.white,
  //         child: AssignmentMapPage(),
  //       );
  //     },
  //   );
  // }

  void _navigateToDetails(BuildContext context, AssignmentModel assignment) {
    final activityModel = ActivityInheritedWidget.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActivityInheritedWidget(
            activityModel: activityModel,
            child: AssignmentDetailPage(assignment: assignment)),
      ),
    );
  }
}
