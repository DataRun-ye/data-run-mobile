import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_list_card_view_item.dart';
import 'package:datarunmobile/features/shared/assignment_selection/assignment_list_viewmodel.dart';
import 'package:datarunmobile/features/shared/assignment_selection/presentation/search_input_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked/stacked.dart';

class AssignmentSelectionListView extends ConsumerWidget {
  const AssignmentSelectionListView({
    this.onAssignmentSelected,
  });

  final ValueChanged<String>? onAssignmentSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ViewModelBuilder<AssignmentListViewModel>.reactive(
      viewModelBuilder: () => AssignmentListViewModel(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }
        if (model.hasError) {
          return Center(child: Text(model.modelError!));
        }
        return CustomScrollView(
          slivers: [
            SearchInputSliver(
              onChanged: model.updateSearchTerm,
            ),
            PagingListener(
              controller: model.pagingController,
              builder: (context, state, fetchNextPage) =>
                  PagedSliverList<int, AssignmentModel>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) =>
                      AssignmentListCardViewItem(
                    onViewDetails: (assignment) {
                      // onViewDetails?.call(assignment.id);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
        ;
      },
    );
  }
}
