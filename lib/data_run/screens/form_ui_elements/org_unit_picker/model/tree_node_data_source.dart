// import 'package:d_sdk/d_sdk.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.extension.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
//   // BaseQuery getQuery() {
//   //   return D2Remote.organisationUnitModuleD.orgUnit;
//   // }
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
//   Future<List<OrgUnit>> fetchTreeNodeList() async {
//     final List<OrgUnit> selectedOrgUnits = await DSdk.db.managers.orgUnits
//         .filter((f) => f.id.isIn(_selectableNodesUids))
//         .get();
//
//     final allUids = selectedOrgUnits.getPathsUids();
//
//     final List<OrgUnit> combinedUnits = await DSdk.db.managers.orgUnits
//         .filter((f) => f.id.isIn(allUids.toList()))
//         .get();
//     return combinedUnits;
//   }
//
//   Map<String, TreeNode> _composeTreeMap(List<OrgUnit> nodes) {
//     final IMap<String, TreeNode> nodeMap =
//         IMap.fromIterable<String, TreeNode, OrgUnit>(nodes,
//             keyMapper: (o) => o.id,
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
