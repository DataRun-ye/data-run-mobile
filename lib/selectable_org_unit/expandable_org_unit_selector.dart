// import 'package:datarunmobile/selectable_org_unit/model/org_unit_node.dart';
// import 'package:flutter/material.dart';
// import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';
//
// class ExpandableOrgUnitSelector extends StatefulWidget {
//   final TreeType<OrgUnitNode> tree;
//   final int selectableLevel;
//   final ValueChanged<List<OrgUnitNode>> onSelectionChanged;
//
//   const ExpandableOrgUnitSelector({
//     required this.tree,
//     required this.selectableLevel,
//     required this.onSelectionChanged,
//     super.key,
//   });
//
//   @override
//   _ExpandableOrgUnitSelectorState createState() =>
//       _ExpandableOrgUnitSelectorState();
// }
//
// class _ExpandableOrgUnitSelectorState extends State<ExpandableOrgUnitSelector>
//     with SingleTickerProviderStateMixin, ExpandableTreeMixin<OrgUnitNode> {
//   @override
//   void initState() {
//     super.initState();
//     initTree();                    // from mixin :contentReference[oaicite:4]{index=4}
//     initRotationController();      // from mixin :contentReference[oaicite:5]{index=5}
//   }
//
//   @override
//   void dispose() {
//     disposeRotationController();
//     super.dispose();
//   }
//
//   @override
//   void initTree() => tree = widget.tree;
//
//   @override
//   void initRotationController() {
//     rotationController = AnimationController(
//       duration: const Duration(milliseconds: 250),
//       vsync: this,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) => Column(
//     children: [
//       _buildBreadcrumbs(tree),    // custom context indicator :contentReference[oaicite:6]{index=6}
//       Expanded(child: SingleChildScrollView(child: buildView())),
//     ],
//   );
//
//   @override
//   Widget buildNode() {
//     final node = tree.data;
//     return InkWell(
//       onTap: updateStateToggleExpansion, // toggles isExpanded :contentReference[oaicite:7]{index=7}
//       child: Row(
//         children: [
//           buildRotationIcon(),           // arrow icon animation :contentReference[oaicite:8]{index=8}
//           Expanded(child: Text(node.title)),
//           if (node.level == widget.selectableLevel)
//             Checkbox(
//               value: node.isChosen!,
//               onChanged: (_) {
//                 updateTreeSingleChoice(tree, !node.isChosen!);
//                 widget.onSelectionChanged(
//                   returnChosenLeaves(widget.tree, []),
//                 );
//                 setState(() {});
//               },
//             ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   List<Widget> generateChildrenNodesWidget(
//       List<TreeType<OrgUnitNode>> list) =>
//       list
//           .map((sub) => ExpandableOrgUnitSelector(
//         tree: sub,
//         selectableLevel: widget.selectableLevel,
//         onSelectionChanged: widget.onSelectionChanged,
//       ))
//           .toList();
//
//   @override
//   void updateStateToggleExpansion() {
//     // TODO: implement updateStateToggleExpansion
//   }
// }
