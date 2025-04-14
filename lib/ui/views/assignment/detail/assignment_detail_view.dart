// import 'package:datarunmobile/ui/views/assignment/detail/assignment_detail_viewmodel.dart';
// import 'package:datarunmobile/ui/views/assignment/detail/assignment_header_widget.dart';
// import 'package:datarunmobile/ui/views/assignment/detail/assignment_overview_tab.dart';
// import 'package:datarunmobile/ui/views/assignment/list_tab/assignment_forms_tab.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// class AssignmentDetailView extends StatelessWidget {
//   const AssignmentDetailView({Key? key, required this.assignment})
//       : super(key: key);
//   final String assignment;
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<AssignmentDetailViewModel>.reactive(
//       viewModelBuilder: () => AssignmentDetailViewModel(assignment),
//       builder: (context, model, child) {
//         if (model.isBusy) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (model.hasError) {
//           return Center(child: Text(model.modelError!));
//         }
//         return Scaffold(
//           appBar: AppBar(
//               title: Text(model.assignment?.name ?? 'Assignment Detail')),
//           body: Column(
//             children: [
//               AssignmentHeaderWidget(assignment: model.assignment!),
//               TabBarView(
//                 children: [
//                   AssignmentOverviewTab(assignment: model.assignment!.id),
//                   AssignmentFormsTab(forms: model.linkedForms),
//                 ],
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               // Trigger edit or submission
//             },
//             child: const Icon(Icons.edit),
//           ),
//         );
//       },
//     );
//   }
// }
