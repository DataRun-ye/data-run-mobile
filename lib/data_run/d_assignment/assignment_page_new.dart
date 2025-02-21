import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/active_filters_widget.dart';
import 'package:datarun/data_run/d_assignment/assignment_detail/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/assignment_table_view.dart';
import 'package:datarun/data_run/d_assignment/assignments_card_view.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/d_team/team_provider.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AssignmentPageNew extends HookConsumerWidget {
  const AssignmentPageNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isCardView = filterQuery.isCardView;
    final controller = useTextEditingController();
    final update = ref.watch(filterQueryProvider).searchQuery;
    useEffect(() {
      controller.text = update;
    }, [update]);

    final focusNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 200,
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              // initialValue: ref.watch(filterQueryProvider).searchQuery,
              decoration: InputDecoration(
                hintText: S.of(context).search,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                constraints: BoxConstraints(maxWidth: 200, maxHeight: 40),
                suffixIcon: ref
                        .watch(filterQueryProvider
                            .select((value) => value.searchQuery))
                        .isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          ref
                              .read(filterQueryProvider.notifier)
                              .updateSearchQuery('');
                          focusNode.unfocus();
                        })
                    : null,
              ),
              onChanged: (searchQuery) {
                ref.read(filterQueryProvider.notifier).updateSearchQuery(
                      searchQuery,
                    );
              },
            ),
          ),
          IconButton(
            tooltip: S.of(context).toggleBetweenListAndCardView,
            icon: Icon(ref.watch(
                    filterQueryProvider.select((value) => value.isCardView))
                ? Icons.view_list
                : Icons.view_module),
            onPressed: () {
              // onToggleView(!isCardView);
              ref.read(filterQueryProvider.notifier).toggleCardTableView(
                  !ref.watch(
                      filterQueryProvider.select((value) => value.isCardView)));
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              showFilterBottomSheet(context, ref);
            },
          )
        ],
      ),
      body: Column(
        children: [
          // if (activeFilters.isNotEmpty)
          const ActiveFiltersWidget(),

          Expanded(
            child: ref.watch(
                    filterQueryProvider.select((value) => value.isCardView))
                ? AssignmentsCardView(
                    key: const ValueKey('cardView'),
                    scope: EntityScope.Assigned,
                    onViewDetails: (assignment) =>
                        _navigateToDetails(context, assignment),
                  )
                : AssignmentTableView(
                    key: const ValueKey('tableView'),
                    scope: EntityScope.Assigned,
                    onViewDetails: (assignment) =>
                        _navigateToDetails(context, assignment),
                  ),
          ),
        ],
      ),
    );
  }

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

  void showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(teamsProvider(EntityScope.Assigned));
    final Map<String, dynamic> activeFilters = ref.watch(filterQueryProvider
        .select((assignmentFilter) => assignmentFilter.filters));

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final Map<String, dynamic> selectedFilters = activeFilters;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).filters,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16.0),
                  AsyncValueWidget(
                    value: teamsAsync,
                    valueBuilder: (teams) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final filters = [
                            FilterModel(
                                label: S.of(context).teams,
                                options: teams.map((t) => t.name!).toList(),
                                isMultiSelect: true),
                            FilterModel(
                                label: S.of(context).status,
                                options: AssignmentStatus.values
                                    .asNameMap()
                                    .keys
                                    .toList())
                          ];
                          final filter = filters[index];
                          return ExpansionTile(
                            title: Text(filter.label),
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: filter.options.map((option) {
                                  final isSelected = activeFilters[filter.label]
                                          ?.contains(option) ??
                                      false;
                                  return ChoiceChip(
                                    label: Text(option),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        selectedFilters[filter.label] ??= [];
                                        if (selected) {
                                          selectedFilters[filter.label]
                                              .add(option);
                                        } else {
                                          selectedFilters[filter.label]
                                              .remove(option);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              selectedFilters.clear();
                            });
                          },
                          icon: Icon(Icons.filter_alt_off),
                          label: Text(S.of(context).reset),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // onApply(selectedFilters);
                            ref
                                .read(filterQueryProvider.notifier)
                                .updateFilters(selectedFilters);
                            Navigator.pop(context);
                          },
                          label: Text(S.of(context).apply),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          icon: Icon(Icons.filter_alt,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
