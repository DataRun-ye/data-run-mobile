// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/features/shared/application/extensions.dart';
// import 'package:datarunmobile/features/shared/presentation/form_selection/form_selection_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// class FormSelection extends StatelessWidget {
//   final ValueChanged<FormTemplate> onFormSelected;
//   final String? assignment;
//
//   const FormSelection({
//     this.assignment,
//     required this.onFormSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<FormSelectionViewmodel>.reactive(
//       viewModelBuilder: () => FormSelectionViewmodel(assignment),
//       builder: (context, model, child) {
//         if (model.isBusy) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (model.hasError) {
//           return Center(child: Text(model.modelError!));
//         }
//         return GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1.5,
//           ),
//           itemCount: model.forms.length,
//           itemBuilder: (context, index) => Card(
//             child: InkWell(
//               onTap: () => onFormSelected(model.forms[index]),
//               child: Column(
//                 children: [
//                   Icon(Icons.description),
//                   Text(model.forms[index].displayLabel),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
