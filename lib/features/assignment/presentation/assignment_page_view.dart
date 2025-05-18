import 'package:auto_route/auto_route.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_list_view.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_page_viewmodel.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_table_view.dart';
import 'package:datarunmobile/features/assignment/presentation/widgets/active_filters_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class AssignmentPageView extends StatelessWidget {
  const AssignmentPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentPageViewModel>.reactive(
      viewModelBuilder: () => AssignmentPageViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: [
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: model.searchController,
                decoration: InputDecoration(
                  hintText: S.of(context).search,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints:
                      const BoxConstraints(maxWidth: 200, maxHeight: 40),
                  suffixIcon: model.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            model.clearSearchQuery();
                            FocusScope.of(context).unfocus();
                          },
                        )
                      : null,
                ),
                onChanged: model.updateSearchQuery,
              ),
            ),
            IconButton(
              tooltip: S.of(context).toggleBetweenListAndCardView,
              icon:
                  Icon(model.isCardView ? Icons.view_list : Icons.view_module),
              onPressed: () => model.toggleCardTableView(!model.isCardView),
            ),
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () => model.showFilterBottomSheet(context),
            )
          ],
        ),
        body: Column(
          children: [
            const ActiveFiltersView(),
            Expanded(
              child: model.isCardView
                  ? AssignmentListView(
                      key: const ValueKey('cardView'),
                      scope: EntityScope.Assigned,
                      onTab: model.navigateToAssignmentDetails,
                    )
                  : AssignmentTableView(
                      key: const ValueKey('tableView'),
                      scope: EntityScope.Assigned,
                      onTab: model.navigateToAssignmentDetails,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
