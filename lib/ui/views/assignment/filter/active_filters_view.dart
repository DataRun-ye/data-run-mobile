import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/ui/views/assignment/assignment_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ActiveFiltersView extends StackedView<AssignmentPageViewModel> {
  const ActiveFiltersView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, AssignmentPageViewModel viewModel, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          if (viewModel.filters.isNotEmpty)
            ActionChip(
              avatar: const Icon(Icons.clear_all),
              tooltip: S.of(context).clearAll,
              label: Text(S.of(context).clearAll),
              onPressed: viewModel.clearAllFilters,
            ),
          ...viewModel.filters.entries.map((entry) => Chip(
                label: Text('${entry.key}: ${entry.value}'),
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => viewModel.removeFilter(entry.key),
              )),
        ],
      ),
    );
  }

  @override
  AssignmentPageViewModel viewModelBuilder(BuildContext context) =>
      AssignmentPageViewModel();
}
