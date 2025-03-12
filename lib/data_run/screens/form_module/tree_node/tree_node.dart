//
// import 'package:datarunmobile/data_run/screens/form_module/tree_node/tree_node_mixin/tree_node_mixin.dart';
//
// abstract class AbstractTreeNode extends DependencyAwareNode {
//   final String? path;
//
//   /// for all elements type == path, except for repeated elements which need to be sorted
//   /// a template path `parent.{keyUsed}.child`, keyUsed is replaced at runtime
//   /// by either an index or uid, this is
//   /// used for the case of repeated elements
//   String? templatePath;
//
//   final String? name;
//   final int order;
//   Map<String, dynamic> _metadata = {};
//   List<String> _dependencies = [];
//
//   AbstractTreeNode({this.path, this.name, this.order = 0, this.templatePath});
//
//   void setMetadata(Map<String, dynamic> metadata) {
//     _metadata.clear();
//     _metadata.addAll(metadata);
//   }
//
//   void setDependencies(List<String> dependencies) {
//     _dependencies.clear();
//     _dependencies.addAll(dependencies);
//   }
//
//   @override
//   List<String> get dependencies => List.unmodifiable(_dependencies)
//     ..sort()
//     ..toList();
//
//   @override
//   bool evaluateDependencies(Map<String, dynamic> context) {
//     return false;
//   }
//
//   Map<String, dynamic> get metadata => Map.unmodifiable(_metadata);
// }
//
// /// A Structured tree Group Mixin
// abstract class AbstractTreeNodeGroup extends AbstractTreeNode
//    /* with TreeNodeMixin*/ {
//   final List<AbstractTreeNode> _children = [];
//
//   AbstractTreeNodeGroup({super.path, required super.name, super.order = 0});
//
//   @override
//   List<AbstractTreeNode> get children => List.unmodifiable(_children);
//   //
//   // void setChildren(List<AbstractTreeNode> children) {
//   //   _children.clear();
//   //   _children.addAll(children);
//   //   _descendantsCache.clear();
//   //   _descendantsCache.addAll(_getDescendants());
//   // }
//
//   /// Indexing by Path: Use a Map<String, TreeNode> to
//   /// speed up queries by storing nodes indexed by their path.
//   final Map<String, AbstractTreeNode> _descendantsCache = {};
//   //
//   // /// get all descendants of this node sorted by path for faster queries.
//   // Map<String, AbstractTreeNode> _getDescendants() {
//   //   final descendants = {
//   //     for (var x
//   //         in depthFirstTraversal().where((e) => e.path != null).toList()
//   //           ..sort((a, b) => a.path!.compareTo(b.path!)))
//   //       x.path!: x
//   //   };
//   //   return descendants;
//   // }
//   //
//   // /// get all descendants of this node sorted by path for faster queries.
//   // Map<String, AbstractTreeNode> getCachedDescendants([bool cached = true]) {
//   //   if (_descendantsCache.isEmpty || !cached) {
//   //     _descendantsCache.clear();
//   //     _descendantsCache.addAll(_getDescendants());
//   //   }
//   //
//   //   return _descendantsCache;
//   // }
// }
