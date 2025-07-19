import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:datarunmobile/features/activity/presentation/activity_inherited_widget.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/active_filters_widget.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_card_view/assignments_card_view.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/assignment_table_view.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_page.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignmentScreen extends HookConsumerWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    // final value = useState<String>('');
    // // final update = ref.watch(filterQueryProvider).searchQuery;
    // useEffect(() {
    //   controller.text = value.value;
    //   return null;
    // }, [value.value]);

    final focusNode = useFocusNode();
    final InputDecoration effectiveDecoration = InputDecoration(
      hintText: S.of(context).search,
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: const BoxConstraints(maxWidth: 200, maxHeight: 40),
      suffixIcon: ref
              .watch(filterQueryProvider.select((value) => value.searchQuery))
              .isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                // value.value = '';
                controller.text = '';
                ref.read(filterQueryProvider.notifier).updateSearchQuery('');
                focusNode.unfocus();
              })
          : null,
    ).applyDefaults(Theme.of(context).inputDecorationTheme);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            decoration: effectiveDecoration,
            onChanged: (searchQuery) {
              // value.value = searchQuery;
              ref.read(filterQueryProvider.notifier).updateSearchQuery(
                    searchQuery,
                  );
            },
          ),
          // SizedBox(
          //   width: 200,
          //   child: TextFormField(
          //     focusNode: focusNode,
          //     controller: controller,
          //     // initialValue: ref.watch(filterQueryProvider).searchQuery,
          //     decoration: effectiveDecoration,
          //     onChanged: (searchQuery) {
          //       ref.read(filterQueryProvider.notifier).updateSearchQuery(
          //             searchQuery,
          //           );
          //     },
          //   ),
          // ),
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
          // IconButton(
          //   icon: const Icon(Icons.filter_alt),
          //   onPressed: () {
          //     showFilterBottomSheet(context, ref);
          //   },
          // )
        ],
      ),
      body: Column(
        children: [
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
    // final activityModel = ActivityInheritedWidget.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => AssignmentDetailPage(assignment: assignment)),
    );
  }

  // void showFilterBottomSheet(BuildContext context, WidgetRef ref) async {
  //   final teamsAsync = ref
  //       .watch(teamsProvider(activity: ActivityInheritedWidget.of(context).id));
  //   final Map<String, dynamic> activeFilters = ref.watch(filterQueryProvider
  //       .select((assignmentFilter) => assignmentFilter.filters));
  //
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           final Map<String, dynamic> selectedFilters = activeFilters;
  //
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   S.of(context).filters,
  //                   style: Theme.of(context).textTheme.titleMedium,
  //                 ),
  //                 const SizedBox(height: 16.0),
  //                 AsyncValueWidget(
  //                   value: teamsAsync,
  //                   valueBuilder: (teams) {
  //                     return ListView.builder(
  //                       shrinkWrap: true,
  //                       itemCount: 2,
  //                       itemBuilder: (context, index) {
  //                         final t = teams.map((t) => t.name).toList();
  //                         final filters = [
  //                           FilterModel(
  //                               label: S.of(context).teams,
  //                               options: teams.map((t) => t.name).toList(),
  //                               isMultiSelect: true),
  //                           FilterModel(
  //                               label: S.of(context).status,
  //                               options: AssignmentStatus.values
  //                                   .asNameMap()
  //                                   .keys
  //                                   .toList())
  //                         ];
  //                         final filter = filters[index];
  //                         return ExpansionTile(
  //                           title: Text(filter.label),
  //                           children: [
  //                             Wrap(
  //                               spacing: 8.0,
  //                               children: filter.options.map((option) {
  //                                 final isSelected = activeFilters[filter.label]
  //                                         ?.contains(option) ??
  //                                     false;
  //                                 return ChoiceChip(
  //                                   label: Text(option),
  //                                   selected: isSelected,
  //                                   onSelected: (selected) {
  //                                     setState(() {
  //                                       selectedFilters[filter.label] ??= [];
  //                                       if (selected) {
  //                                         selectedFilters[filter.label]
  //                                             .add(option);
  //                                       } else {
  //                                         selectedFilters[filter.label]
  //                                             .remove(option);
  //                                       }
  //                                     });
  //                                   },
  //                                 );
  //                               }).toList(),
  //                             ),
  //                           ],
  //                         );
  //                       },
  //                     );
  //                   },
  //                 ),
  //                 const SizedBox(height: 16.0),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Expanded(
  //                       flex: 1,
  //                       child: TextButton.icon(
  //                         onPressed: () {
  //                           setState(() {
  //                             selectedFilters.clear();
  //                           });
  //                         },
  //                         icon: const Icon(Icons.filter_alt_off),
  //                         label: Text(S.of(context).reset),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 2,
  //                       child: ElevatedButton.icon(
  //                         onPressed: () {
  //                           ref
  //                               .read(filterQueryProvider.notifier)
  //                               .updateFilters(selectedFilters);
  //                           Navigator.pop(context);
  //                         },
  //                         label: Text(S.of(context).apply),
  //                         style: ElevatedButton.styleFrom(
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 16.0, vertical: 12.0),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                           ),
  //                         ),
  //                         icon: Icon(Icons.filter_alt,
  //                             color: Theme.of(context).primaryColorDark),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
