// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:datarunmobile/ui/views/assignment/assignment_page_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:stacked_hooks/stacked_hooks.dart';
//
// class SearchInputView extends StackedHookView<AssignmentPageViewModel> {
//   SearchInputView({super.key}) : super(reactive: false);
//
//   @override
//   Widget builder(BuildContext context, AssignmentPageViewModel model) {
//     return TextField(
//       focusNode: model.focusNode,
//       controller: model.searchController,
//       decoration: InputDecoration(
//         hintText: S.of(context).search,
//         prefixIcon: const Icon(Icons.search),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         constraints: const BoxConstraints(maxWidth: 200, maxHeight: 40),
//         suffixIcon: model.searchQuery.isNotEmpty
//             ? IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () {
//                   model.clearSearchQuery();
//                   FocusScope.of(context).unfocus();
//                 },
//               )
//             : null,
//       ),
//       onChanged: model.updateSearchQuery,
//     );
//   }
// }
