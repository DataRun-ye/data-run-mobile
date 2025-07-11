// import 'package:d_sdk/core/utilities/list_extensions.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/extensions/tree_node_query.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/extensions/tree_node_select.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/tree_node_mixin/tree_node_mixin.dart';
//
// mixin TreeNodeGroupScopedLookup<N extends AbstractTreeNode> {
//   List<N> get children;
//   /// fiend a node by name from the passed [node] path, finding the closest node
//   /// starting from the parent of the node and go up untill root then look globally
//   /// in level 1 of the tree children
//   N? findNodeByNameScoped(N node, String dependencyName, N root) {
//     N? resolveInGroup(N group) {
//       return children.firstOrNullWhere((child) => child.name == dependencyName);
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
//     return children.firstOrNullWhere((child) => child.name == dependencyName);
//   }
//
//   N? findNodeByPath(String targetPath) {
//     return depthFirstTraversal()
//         .firstOrNullWhere((node) => node.path == targetPath);
//   }
//
//   List<N> getAllDescendants() {
//     return depthFirstTraversal().where((node) => node.path != path).toList();
//   }
//
//   int countNodes() {
//     return depthFirstTraversal().length;
//   }
//
//   List<N> filterNodes(bool Function(N) predicate) {
//     return depthFirstTraversal().where(predicate).toList();
//   }
//
//
//   List<N> getPathDescendants(String nodePath, List<N> allNodes) {
//     return allNodes
//         .where((node) => node.path!.startsWith('$nodePath.'))
//         .toList();
//   }
//
//   Iterable<AbstractTreeNode> getPathImmediateChildren(
//       String? nodePath, Iterable<N> allNodes) {
//     if (nodePath == null) return allNodes;
//     final depth = nodePath.split('.').length + 1;
//     return allNodes.where((node) {
//       return node.path!.startsWith('$nodePath.') &&
//           node.path!.split('.').length == depth;
//     }).toList();
//   }
//
//   N? getPathParent(String path, List<N> allNodes) {
//     final parentPath = path.split('.')..removeLast();
//     if (parentPath.isEmpty) return null; // Root node has no parent
//     return allNodes.firstOrNullWhere((n) => n.path == parentPath.join('.'));
//   }
//
// }
