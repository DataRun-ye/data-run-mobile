// import 'package:datarunmobile/core/sync_manager/sync_progress_event.dart';
// import 'package:datarunmobile/ui/views/sync_with_server/sync_resources_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:stacked/stacked.dart';
//
// class SyncResourcesView extends StackedView<SyncResourcesViewModel> {
//   @override
//   Widget builder(
//       BuildContext context, SyncResourcesViewModel viewModel, Widget? child) {
//     final global = viewModel.globalState;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sync Progress Dashboard'),
//       ),
//       body: Column(
//         children: [
//           // Global indicator
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 CircularProgressIndicator(
//                   value: global.percentage / 100,
//                   strokeWidth: 8,
//                   valueColor: AlwaysStoppedAnimation(
//                     global.overallState == SyncProgressState.FAILED
//                         ? Colors.red
//                         : global.overallState == SyncProgressState.SUCCEEDED
//                             ? Colors.green
//                             : Colors.blue,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Overall: ${global.percentage.toStringAsFixed(0)}%',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           Divider(),
//           // Detailed list of resource statuses
//           Expanded(
//             child: ListView.builder(
//               itemCount: viewModel.resourceStates.length,
//               itemBuilder: (context, index) {
//                 final res = viewModel.resourceStates[index];
//                 return ListTile(
//                   leading: Icon(
//                     res.state == SyncProgressState.SUCCEEDED
//                         ? Icons.check_circle
//                         : res.state == SyncProgressState.FAILED
//                             ? Icons.error
//                             : Icons.sync,
//                     color: res.state == SyncProgressState.SUCCEEDED
//                         ? Colors.green
//                         : res.state == SyncProgressState.FAILED
//                             ? Colors.red
//                             : Colors.blue,
//                   ),
//                   title: Text(res.name),
//                   subtitle: Text(res.message ?? ''),
//                   trailing: Text('${res.percentage.toStringAsFixed(0)}%'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   SyncResourcesViewModel viewModelBuilder(BuildContext context) =>
//       SyncResourcesViewModel();
//
//   @override
//   void onViewModelReady(SyncResourcesViewModel viewModel) =>
//       SchedulerBinding.instance
//           .addPostFrameCallback((timeStamp) => viewModel.triggerSync());
// }
