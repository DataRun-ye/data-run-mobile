// import 'package:d_sdk/core/utilities/list_extensions.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/extensions/tree_node_query.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/tree_node_mixin/tree_node_mixin.dart';
//
// extension TreeNodeSelect<N extends AbstractTreeNode> on N {
//   N? getPathParent(List<N> allNodes) {
//     final List<String>? parentPath = path?.split('.')?..removeLast();
//     if ((parentPath ?? []).isEmpty) return null; // Root node has no parent
//     return allNodes.firstOrNullWhere((n) => n.path == parentPath!.join('.'));
//   }
//
//   N? findNodeByNameScoped(N node,
//       String dependencyName, N root) {
//     N? resolveInGroup(N group) {
//       return group.children
//           .firstOrNullWhere((child) => child.name == dependencyName);
//     }
//
//     N? resolveInParentGroups(N current) {
//       N? parent = current.getPathParent(
//           root.getAllDescendants()); // Get the parent of the current group
//       while (parent != null) {
//         final found = resolveInGroup(parent);
//         if (found != null) return found;
//         parent =
//             parent.getPathParent(root.getAllDescendants()); // Move up the tree
//       }
//       return null;
//     }
//
//     // Scoped Resolution Strategy
//     // 1. Check current group
//     final currentGroup = node.getPathParent(root.getAllDescendants());
//     if (currentGroup != null) {
//       final foundInGroup = resolveInGroup(currentGroup);
//       if (foundInGroup != null) return foundInGroup;
//     }
//
//     // 2. Check parent groups and their siblings
//     final foundInParents = resolveInParentGroups(currentGroup!);
//     if (foundInParents != null) return foundInParents;
//
//     // 3. Check globally at the root level
//     return root.children
//         .firstOrNullWhere((child) => child.name == dependencyName);
//   }
// }
//
// extension TreeNodeGroupChildrenSelect<N extends AbstractTreeNode> on N {
//   List<N> getPathDescendants(
//       String nodePath, List<N> allNodes) {
//     return allNodes
//         .where((node) => node.path!.startsWith('$nodePath.'))
//         .toList();
//   }
//
//   Iterable<N> getPathImmediateChildren(
//       String? nodePath, Iterable<N> allNodes) {
//     if (nodePath == null) return allNodes;
//     final depth = nodePath.split('.').length + 1;
//     return allNodes.where((node) {
//       return node.path!.startsWith('$nodePath.') &&
//           node.path!.split('.').length == depth;
//     }).toList();
//   }
// }
