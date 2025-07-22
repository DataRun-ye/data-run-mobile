// import 'package:datarunmobile/selectable_org_unit/helper/empty_page.dart';
// import 'package:datarunmobile/selectable_org_unit/helper/error_page.dart';
// import 'package:datarunmobile/selectable_org_unit/model/build_tree.dart';
// import 'package:datarunmobile/selectable_org_unit/model/org_unit_node.dart';
// import 'package:datarunmobile/selectable_org_unit/vts/show_org_unit_selection_sheet.dart';
// import 'package:datarunmobile/selectable_org_unit/widgets/dash_line.dart';
// import 'package:datarunmobile/selectable_org_unit/widgets/default_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';
//
// class OrgUnitSelectionInput extends StatefulWidget {
//   const OrgUnitSelectionInput({
//     Key? key,
//     this.initialLeafIds = const [],
//     this.singleChoice = false,
//     this.onSelectionChanged,
//   }) : super(key: key);
//
//   final List<String> initialLeafIds;
//   final ValueChanged<List<String>>? onSelectionChanged;
//   final bool singleChoice;
//
//   @override
//   State<OrgUnitSelectionInput> createState() => _OrgUnitSelectionInputState();
// }
//
// class _OrgUnitSelectionInputState extends State<OrgUnitSelectionInput> {
//   late List<String> _selectedIds;
//   late Future<TreeType<OrgUnitNode>?> funcParseDataToTree;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedIds = List.of(widget.initialLeafIds);
//     funcParseDataToTree = buildOrgUnitTree(_selectedIds).then((tree) {
//       setState(() {
//         _root = tree;
//         for (final id in _selectedIds) {
//           final n = findTreeWithId(_root!, id);
//           if (n != null) n.data.isChosen = true;
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Example VTS Department Tree')),
//       body: Center(
//         child: OutlinedButton(
//           onPressed: () => showOrgUnitSelectionSheet<OrgUnitNode>(
//             context: context,
//             sheetTitle: 'BRUH BRUH LMAO LMAO',
//             sheetTitleStyle: kDefaultSheetTitleStyle,
//             titleLeadingWidget: const DefaultLeadingWidget(),
//             titleTrailingWidget: const DefaultTrailingWidget('Add'),
//             loadingWidget: const DefaultLoadingWidget(),
//             emptyPage: const EmptyPage(),
//             errorPage: const ErrorPage(),
//             handleBar: const DefaultHandleBar(),
//             funcParseDataToTree: funcParseDataToTree,
//             funcWhenComplete: funcWhenComplete,
//             buildLeadingWidgetNode: _buildLeadingWidgetNode,
//           ),
//           child: const Text('Press me'),
//         ),
//       ),
//     );
//   }
//
//   void _onLeafToggled(TreeType<OrgUnitNode> node) {
//     if (_root == null) return;
//     final id = node.data.id as String;
//
//     if (widget.singleChoice) {
//       // clear previous selection
//       _selectedIds = [id];
//       updateTreeSingleChoice(node, true);
//     } else {
//       // toggle in list
//       if (_selectedIds.contains(id)) {
//         _selectedIds.remove(id);
//         updateTreeMultipleChoice(
//           node,
//           false,
//           isUpdatingParentRecursion: true,
//         );
//       } else {
//         _selectedIds.add(id);
//         updateTreeMultipleChoice(
//           node,
//           true,
//           isUpdatingParentRecursion: true,
//         );
//       }
//     }
//
//     setState(() {
//       // emit current selections
//       widget.onSelectionChanged?.call(List.of(_selectedIds));
//     });
//   }
//
//   void funcWhenComplete(TreeType<OrgUnitNode> tree) {
//     List<TreeType<OrgUnitNode>> result = [];
//     returnChosenLeaves(tree, result);
//     String resultTxt = 'WHICH LEAVES ARE CHOSEN?';
//     for (var e in result) {
//       resultTxt += '\n${e.data.title}';
//     }
//     if (result.isEmpty) resultTxt += '\nnone';
//
//     resultTxt += '\n\nWHICH LEAVES ARE IN FAVORITE LIST?';
//     result.clear();
//     returnFavoriteNodes(tree, result);
//     for (var e in result) {
//       resultTxt += '\n${e.data.title}';
//     }
//     if (result.isEmpty) resultTxt += '\nnone';
//
//     var snackBar = SnackBar(content: Text(resultTxt));
//     widget.onSelectionChanged
//         ?.call(result.map((node) => node.data.id as String).toList());
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   //? __________________________________________________________________________
//
//   Widget _buildLeadingWidgetNode(
//       TreeType<OrgUnitNode> tree, VoidCallback setStateCallback) {
//     if (tree.isRoot) {
//       return _buildLeadingRoot(tree);
//     } else if (tree.isLeaf) {
//       return _buildLeadingLeafWithFavoriteIcon(tree, setStateCallback);
//     } else {
//       return _buildLeadingInnerNode(tree);
//     }
//   }
//
//   Widget _buildLeadingRoot(TreeType<OrgUnitNode> tree) {
//     return Row(
//       children: [
//         const SizedBox(width: 20),
//         tree.data.isExpanded
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   AnimatedRotation(
//                     turns: tree.data.isExpanded ? 0.25 : 0,
//                     duration: const Duration(milliseconds: 300),
//                     child:
//                         SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
//                   ),
//                   CustomPaint(
//                     painter: BottomDashedLinePainterWhenClicked(),
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.025,
//                       width: MediaQuery.of(context).size.width * 0.02,
//                     ),
//                   ),
//                 ],
//               )
//             : AnimatedRotation(
//                 turns: tree.data.isExpanded ? 0.25 : 0,
//                 duration: const Duration(milliseconds: 300),
//                 child: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
//               ),
//         const SizedBox(width: 8),
//       ],
//     );
//   }
//
//   Widget _buildLeadingInnerNode(TreeType<OrgUnitNode> tree) {
//     if (tree.data.isExpanded) {
//       return SizedBox(
//         width: 40,
//         height: 50,
//         child: Row(
//           children: [
//             CustomPaint(
//               painter: TopDashedLinePainterWhenClicked(),
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width * 0.05,
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 AnimatedRotation(
//                   turns: tree.data.isExpanded ? 0.25 : 0,
//                   duration: const Duration(milliseconds: 300),
//                   child: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
//                 ),
//                 CustomPaint(
//                   painter: BottomDashedLinePainterWhenClicked(),
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.025,
//                     width: MediaQuery.of(context).size.width * 0.02,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     } else {
//       return SizedBox(
//         width: 30,
//         height: 50,
//         child: Row(
//           children: [
//             CustomPaint(
//               painter: tree.data.toString() ==
//                       findRightmostOfABranch(tree).data.toString()
//                   ? TopDashedLinePainterWhenClicked()
//                   : DashedLinePainter(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.05,
//                 height: MediaQuery.of(context).size.height * 0.08,
//               ),
//             ),
//             AnimatedRotation(
//               turns: tree.data.isExpanded ? 0.25 : 0,
//               duration: const Duration(milliseconds: 300),
//               child: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   Widget _buildLeadingLeafWithFavoriteIcon(
//       TreeType<OrgUnitNode> tree, VoidCallback setStateCallback) {
//     return Row(
//       children: [
//         SizedBox(
//           height: 70.0,
//           width: 35.0,
//           child: Row(
//             children: [
//               CustomPaint(
//                 painter: tree.data.toString() ==
//                         findRightmostOfABranch(tree).data.toString()
//                     ? TopDashedLinePainterWhenClicked()
//                     : DashedLinePainter(),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.04,
//                   height: MediaQuery.of(context).size.height * 0.08,
//                 ),
//               ),
//               SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
//             ],
//           ),
//         ),
//         const SizedBox(width: 8),
//         //? no display favorite icon if current tree is a inner node
//         InkWell(
//           onTap: () {
//             tree.data.isFavorite = !tree.data.isFavorite;
//             setStateCallback();
//           },
//           child: SizedBox(
//             width: 25,
//             height: 25,
//             child: tree.data.isFavorite
//                 ? SvgPicture.asset('assets/app/ic_filled_heart.svg')
//                 : SvgPicture.asset('assets/app/ic_heart.svg'),
//           ),
//         ),
//       ],
//     );
//   }
// }
