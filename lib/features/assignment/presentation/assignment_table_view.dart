// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:datarunmobile/features/assignment/presentation/assignment_list_viewmodel.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// class AssignmentTableView extends StatelessWidget {
//   const AssignmentTableView(
//       {super.key, required this.onTab, required this.scope});
//
//   final Function(AssignmentModel assignment) onTab;
//   final EntityScope scope;
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<AssignmentListViewModel>.reactive(
//       viewModelBuilder: () => AssignmentListViewModel(),
//       builder: (context, viewModel, child) {
//         if (viewModel.isBusy) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (viewModel.hasError) {
//           return Center(child: Text(viewModel.modelError!));
//         }
//         return Scaffold(
//           appBar: AppBar(title: Text(S.of(context).assignmentList)),
//           body: ListView.builder(
//             itemCount: viewModel.items.length + 1,
//             itemBuilder: (context, index) {
//               if (index == viewModel.items.length) {
//                 return viewModel.isBusy
//                     ? const Center(child: CircularProgressIndicator())
//                     : viewModel.hasMore
//                         ? TextButton(
//                             onPressed: viewModel.loadItems,
//                             child: Text(S.of(context).loadMore),
//                           )
//                         : Center(
//                             child: Text(S.of(context).noMoreItems),
//                           );
//               }
//               return ListTile(
//                 title: Text(viewModel.items[index].orgUnit.name!),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
