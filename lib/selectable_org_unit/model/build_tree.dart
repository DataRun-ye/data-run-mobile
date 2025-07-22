import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';

import 'org_unit_node.dart';

/// Builds a recursive tree of OrgUnitNodes given a set of leaf IDs.
///
/// - [leafIds] is the list of OrgUnit.id values that the user selected (leaves).
///
/// Returns the root nodes of the resulting forest (could be one tree or multiple).
Future<TreeType<OrgUnitNode>> buildOrgUnitTree(List<String> leafIds,
    {List<String> selectedIds = const []}) async {
  final db = DSdk.db;

  final leaves =
      await db.managers.orgUnits.filter((f) => f.id.isIn(leafIds)).get();
  final allIds = <String>{
    for (final leaf in leaves) leaf.id,
    for (final leaf in leaves)
      ...leaf.path.split(',').where((id) => id.isNotEmpty),
  };

  final allUnits = await db.managers.orgUnits
      .filter((f) => f.id.isIn(allIds.toList()))
      .get();

  final nodeMap = <String, TreeType<OrgUnitNode>>{};
  for (final unit in allUnits) {
    nodeMap[unit.id] =
        TreeType(data: OrgUnitNode(unit), children: [], parent: null);
  }
  for (final node in nodeMap.values) {
    final pid = node.data.org.parent;
    if (pid != null && nodeMap.containsKey(pid)) {
      node.parent = nodeMap[pid];
      nodeMap[pid]!.children.add(node);
    }
  }
  for (final node in nodeMap.values) {
    node.children.sort((a, b) => a.data.org.name.compareTo(b.data.org.name));
    // node.data.isInner = node.children.isNotEmpty;
    node.data.isInner = leafIds.contains(node.data.id as String);
    node.data.isChosen = selectedIds.contains(node.data.id);
  }
  final top = nodeMap.values.where((n) => n.parent == null).toList();
  final rootOrg = OrgUnit(
      id: 'ROOT',
      name: 'All Units',
      path: '',
      level: 0,
      parent: null,
      translations: []);
  final root = TreeType(
      data: OrgUnitNode(rootOrg)..isExpanded = true,
      children: top,
      parent: null);
  for (final c in top) c.parent = root;
  return root;
}

// Future<TreeType<OrgUnitNode>> buildOrgUnitTree(List<String> leafIds) async {
//   final AppDatabase db = DSdk.db;
//
//   // Load all leaf OrgUnit records
//   final List<OrgUnit> leaves =
//   await db.managers.orgUnits.filter((f) => f.id.isIn(leafIds)).get();
//
//   // Extract all ancestor IDs from path fields
//   final Set<String> allIds = {
//     for (final leaf in leaves) leaf.id,
//     for (final leaf in leaves)
//       ...leaf.path.split(',').where((id) => id.isNotEmpty).toList().distinct(),
//   };
//
//   // Fetch all relevant orgUnits (leaves + ancestors)
//   final allOrgUnits = await db.managers.orgUnits
//       .filter((f) => f.id.isIn(allIds.toList()))
//       .get();
//
//   // Build a map for quick lookup
//   final Map<String, OrgUnit> recordMap = {
//     for (final unit in allOrgUnits) unit.id: unit,
//   };
//
//   // Convert all records to OrgUnitNode and build parent-child relationships
//   final Map<String, TreeType<OrgUnitNode>> nodeMap = {};
//   for (final data in recordMap.values) {
//     nodeMap[data.id] = TreeType<OrgUnitNode>(
//       data: OrgUnitNode(data),
//       children: [],
//       parent: null,
//     );
//   }
//
//   // Wire up the tree: assign parent and add to children list
//   for (final node in nodeMap.values) {
//     final parentId = node.data.org.parent;
//     if (parentId != null && nodeMap.containsKey(parentId)) {
//       final parentNode = nodeMap[parentId]!;
//       node.parent = parentNode;
//       parentNode.children.add(node);
//       parentNode.data.isInner = true;
//     } else {
//       // no parent => root of a tree
//       node.data.isInner = true;
//     }
//   }
//
//   // Sort children alphabetically by name for a predictable UI
//   for (final node in nodeMap.values) {
//     if (node.children.isNotEmpty) {
//       node.children.sort(
//             (a, b) => a.data.org.name.compareTo(b.data.org.name),
//       );
//     }
//   }
//
//   // Determine leaf status: nodes with no children
//   for (final node in nodeMap.values) {
//     if (node.children.isEmpty) {
//       node.data.isInner = false;
//     }
//   }
//
//   final topLevel = nodeMap.values.where((n) => n.parent == null).toList();
//
//   // Create a dummy root to hold all top-level
//   final dummyUnit = OrgUnit(
//     id: 'ROOT',
//     name: 'All Units',
//     path: '',
//     level: 0,
//     parent: null,
//     translations: [],
//   );
//   final dummyNode = TreeType<OrgUnitNode>(
//     data: OrgUnitNode(dummyUnit)..isExpanded = true,
//     children: topLevel,
//     parent: null,
//   );
//   for (final child in topLevel) {
//     child.parent = dummyNode;
//   }
//
//   return dummyNode;
// }
