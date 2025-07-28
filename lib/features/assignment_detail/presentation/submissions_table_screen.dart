// import 'package:d_sdk/core/form/element_template/element_template.dart';
// import 'package:d_sdk/database/shared/assignment_model.dart';
// import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
// import 'package:datarunmobile/data/form_template_repository.dart';
// import 'package:datarunmobile/features/assignment_detail/presentation/details_submissions_table_view.dart';
// import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class SubmissionsTableScreen extends ConsumerWidget {
//   const SubmissionsTableScreen({
//     super.key,
//     required this.assignment,
//     required this.formId,
//     this.index,
//   });
//
//   final AssignmentModel assignment;
//   final String formId;
//   final int? index;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formAsync = ref.watch(latestFormTemplateProvider(formId: formId));
//
//     return AsyncValueWidget(
//       value: formAsync,
//       valueBuilder: (FormTemplateRepository template) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               '${index != null ? (index! + 1) : ''}. ${getItemLocalString(
//                 template.template.label,
//                 defaultString: template.template.name,
//               )}',
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           body: DetailsSubmissionsTableView(
//             assignment: assignment,
//             template: template,
//           ),
//         );
//       },
//     );
//   }
// }
