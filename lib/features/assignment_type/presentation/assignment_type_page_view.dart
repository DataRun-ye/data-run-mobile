import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/assignment_type/presentation/assignment_type_list_view.dart';
import 'package:datarunmobile/features/assignment_type/presentation/assignment_type_page_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AssignmentTypePageView extends StatelessWidget {
  const AssignmentTypePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentTypePageViewModel>.reactive(
      viewModelBuilder: () => AssignmentTypePageViewModel(),
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
            Expanded(
                child: AssignmentTypeListView(
              key: const ValueKey('cardView'),
              scope: EntityScope.Assigned,
              onTab: model.navigateToAssignmentDetails,
            )),
          ],
        ),
      ),
    );
  }
}
