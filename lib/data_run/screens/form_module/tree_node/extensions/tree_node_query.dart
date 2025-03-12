// import 'package:d2_remote/core/utilities/list_extensions.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/extensions/tree_traverse.dart';
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/tree_node_mixin/tree_node_mixin.dart';
//
// extension TreeNodeGroupQueryingUtility<N extends AbstractTreeNode> on N {
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
// }
