import 'package:datarunmobile/database/shared/assignment_model.dart';
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
  const AssignmentScreen({
    super.key,
    required this.activityId,
  });

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
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
              ref.read(filterQueryProvider.notifier).updateSearchQuery(
                    searchQuery,
                  );
            },
          ),
          IconButton(
            tooltip: S.of(context).toggleBetweenListAndCardView,
            icon: Icon(ref.watch(
                    filterQueryProvider.select((value) => value.isCardView))
                ? Icons.view_list
                : Icons.view_module),
            onPressed: () {
              ref.read(filterQueryProvider.notifier).toggleCardTableView(
                  !ref.watch(
                      filterQueryProvider.select((value) => value.isCardView)));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ActiveFiltersWidget(),
            Expanded(
              child: ref.watch(
                      filterQueryProvider.select((value) => value.isCardView))
                  ? AssignmentsCardView(
                      key: const ValueKey('cardView'),
                      activityId: activityId,
                      onViewDetails: (assignment) =>
                          _navigateToDetails(context, assignment),
                    )
                  : AssignmentTableView(
                      key: const ValueKey('tableView'),
                      activityId: activityId,
                      onViewDetails: (assignment) =>
                          _navigateToDetails(context, assignment),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, AssignmentModel assignment) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AssignmentDetailPage(
          assignment: assignment,
        ),
      ),
    );
  }
}
