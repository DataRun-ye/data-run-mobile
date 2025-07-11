// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/shared/entities/identifiable_tree_node.entity.dart';
// import 'package:d_sdk/shared/queries/base.query.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.extension.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.dart';
//
// class TreeNodeDataSource {
//   TreeNodeDataSource({required List<String> selectableNodesUids})
//       : _selectableNodesUids = selectableNodesUids;
//
//   IMap<String, TreeNode> _treeNodeCache = IMap();
//
//   IMap<String, TreeNode> _allNodesCache = IMap();
//
//   List<String> _selectableNodesUids;
//
//   BaseQuery getQuery() {
//     return D2Remote.organisationUnitModuleD.orgUnit;
//   }
//
//   List<String> getSelectableNodesUids() {
//     return _selectableNodesUids;
//   }
//
//   IMap<String, TreeNode> getTreeNodeMap() => _allNodesCache;
//
//   TreeNode? getNode(String? uid) {
//     final node = uid != null ? _allNodesCache.get(uid) : null;
//     return node;
//   }
//
//   TreeNode? fetchEntityByUid(String uid) {
//     return _allNodesCache.get(uid);
//   }
//
//   List<TreeNode> getRoots() {
//     return _treeNodeCache.values.toList();
//   }
//
//   Future<IMap<String, TreeNode>> initTreeNodeMap() async {
//     final list = await fetchTreeNodeList();
//
//     _treeNodeCache = _composeTreeMap(list).lock;
//
//     final commonAncestorUid = list.getCommonAncestorUid();
//
//     if (_treeNodeCache.isNotEmpty && commonAncestorUid == null) {
//       throw Exception('No common ancestor found');
//     }
//
//     return _treeNodeCache;
//   }
//
//   Future<List<IdentifiableTreeNode>> fetchTreeNodeList() async {
//     final List<IdentifiableTreeNode> selectedOrgUnits =
//         await getQuery().byIds(_selectableNodesUids).get();
//     final allUids = selectedOrgUnits.getPathsUids();
//
//     final List<IdentifiableTreeNode> combinedUnits =
//         await getQuery().byIds(allUids.toList()).get();
//     return combinedUnits;
//   }
//
//   Map<String, TreeNode> _composeTreeMap(List<IdentifiableTreeNode> nodes) {
//     final IMap<String, TreeNode> nodeMap =
//         IMap.fromIterable<String, TreeNode, IdentifiableTreeNode>(nodes,
//             keyMapper: (o) => o.id!,
//             valueMapper: (o) {
//               return o.toTreeNode(
//                   selectable: _selectableNodesUids.contains(o.id));
//             });
//
//     _allNodesCache = nodeMap;
//     // Build the roots structure
//     final Map<String, TreeNode> roots = {};
//     for (final node in nodeMap.values) {
//       if (node.parent == null) {
//         roots[node.id!] = node;
//       } else {
//         final parent = nodeMap[node.parent!];
//         parent?.children.add(node);
//       }
//     }
//
//     return roots;
//   }
// }
