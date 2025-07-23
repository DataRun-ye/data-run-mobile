// import 'package:d_sdk/d_sdk.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:flutter/material.dart';
//
// /// Given `selectableIds` and an optional `initialId`, pull every OrgUnit
// /// whose `id` is in `selectableIds` or appears in the path of one of them.
// Future<List<OrgUnit>> loadTreeData({
//   required List<String> selectableIds,
//   String? initialId,
// }) async {
//   final db = DSdk.db;
//   // 1. Query all OrgUnits matching selectableIds:
//   final leaves = await (db.managers.orgUnits
//       .filter((o) => o.id.isIn(selectableIds))).get();
//   // 2. Collect all ancestor IDs:
//   final ancestorIds = <String>{};
//   for (var leaf in leaves) {
//     ancestorIds.addAll(leaf.path.split(',').where((p) => p.isNotEmpty));
//   }
//   // 3. Query those ancestors:
//   final ancestors =
//       await (db.managers.orgUnits.filter((o) => o.id.isIn(ancestorIds))).get();
//   return [...ancestors, ...leaves];
// }
//
// List<TreeSliverNode<OrgUnit>> buildOrgUnitTree({
//   required List<OrgUnit> allUnits,
//   required Set<String> selectableIds,
//   String? initiallySelectedId,
// }) {
//   // Map each id → OrgUnit for quick lookup
//   final byId = { for (var u in allUnits) u.id : u };
//   // Recursive helper to build a node and its children
//   TreeSliverNode<OrgUnit> makeNode(String id) {
//     final unit = byId[id]!;
//     final node = TreeSliverNode<OrgUnit>(
//       unit,
//       // mark leaf as selectable by wrapping default builder
//       builder: (ctx, n, anim) => GestureDetector(
//         onTap: selectableIds.contains(unit.id)
//             ? () => Navigator.pop(ctx, unit)
//             : null,
//         child: TreeSliver.defaultTreeNodeBuilder(ctx, n, anim),
//       ),
//       expanded: unit.path.split(',').contains(initiallySelectedId),
//     );
//     // find direct children in our fetched list
//     final children = allUnits
//         .where((u) => u.path == '${unit.path},${u.id}')
//         .map((u) => makeNode(u.id))
//         .toList();
//     if (children.isNotEmpty) node.children.addAll(children);
//     return node;
//   }
//
//   // Top‑level (level == 1)
//   return allUnits
//       .where((u) => u.level == 1)
//       .map((u) => makeNode(u.id))
//       .toList();
// }
