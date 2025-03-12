// import 'package:datarunmobile/data_run/screens/form_module/tree_node/tree_node_mixin/tree_node_mixin.dart';
//
// extension ConcreteDescendants<N extends AbstractTreeNode> on N {
//   List<N> getDescendants(List<N> allNodes) {
//     return allNodes.where((node) => node.path!.startsWith(this.path!)).toList();
//   }
// }
//
// extension DepthFirstTraversal on AbstractTreeNode {
//   Iterable<N> depthFirstTraversal() sync* {
//     if (this is N) {
//       yield this as N; // Start with the root node
//     }
//     for (final child in children) {
//       yield* child.depthFirstTraversal();
//     }
//   }
// }
//
// extension BreadthFirstTraversal on AbstractTreeNode {
//   Iterable<AbstractTreeNode> breadthFirstTraversal() sync* {
//     final queue = <AbstractTreeNode>[this];
//     while (queue.isNotEmpty) {
//       final node = queue.removeAt(0);
//       yield node;
//
//       queue.addAll(node.children);
//     }
//   }
// }
