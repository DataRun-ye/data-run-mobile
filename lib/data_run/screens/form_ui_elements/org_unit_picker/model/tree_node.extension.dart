// import 'package:d_sdk/shared/entities/identifiable_tree_node.entity.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.dart';
//
// extension TreeNodeExtension<T extends IdentifiableTreeNode> on T {
//   TreeNode toTreeNode({bool selectable = false}) {
//     return TreeNode(
//         id: this.id,
//         code: this.code,
//         name: this.name,
//         displayName: this.displayName,
//         parent: this.parent,
//         path: this.path,
//         selectable: selectable);
//   }
// }
//
// extension OrgUnitList on List<IdentifiableTreeNode> {
//   Iterable<String> orgUnitsPaths() {
//     return this.map((o) => o.path!);
//   }
//
//   Iterable<String> getPathsUids() {
//     final Set<String> allUids = {};
//
//     for (final unit in this) {
//       final List<String> ancestors = _splitPath(unit.path!);
//       allUids.addAll(ancestors);
//     }
//
//     return allUids;
//   }
//
//   String? getCommonAncestorUid() {
//     // Extract ancestors for each selected orgUnit
//     final ancestorPaths =
//         orgUnitsPaths().map((path) => _splitPath(path)).toList();
//
//     // Find the common ancestor uid
//     return _findDeepestCommonAncestor(ancestorPaths);
//   }
//
//   List<String> getChildren(String parentUid) {
//     final Set<String> children = {};
//     for (final path in orgUnitsPaths()) {
//       final List<String> uids = _splitPath(path);
//       final int index = uids.indexOf(parentUid);
//       if (index != -1 && index + 1 < uids.length) {
//         children.add(uids[index + 1]);
//       }
//     }
//     return children.toList();
//   }
//
//   List<String> _splitPath(String path) {
//     return path.trim().split(',').where((uid) => uid.isNotEmpty).toList();
//   }
//
//   String? _findDeepestCommonAncestor(List<List<String>> ancestorPaths) {
//     if (ancestorPaths.isEmpty) return null;
//
//     // Get the shortest path length to avoid index errors
//     final minPathLength = ancestorPaths
//         .map((path) => path.length)
//         .reduce((a, b) => a < b ? a : b);
//
//     String? lastCommonAncestor;
//
//     // Iterate over each level
//     for (int i = 0; i < minPathLength; i++) {
//       final currentAncestor = ancestorPaths[0][i];
//
//       // Check if the current ancestor is common in all paths
//       final isCommon =
//           ancestorPaths.every((path) => path[i] == currentAncestor);
//
//       if (isCommon) {
//         lastCommonAncestor = currentAncestor;
//       } else {
//         break; // As soon as a mismatch is found, stop the loop
//       }
//     }
//
//     return lastCommonAncestor;
//   }
// }
