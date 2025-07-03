import 'package:d_sdk/database/database.dart';
import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';

class OrgUnitNode extends AbsNodeType {
  OrgUnitNode({
    required dynamic id,
    required dynamic title,
    bool isInner = true,
    bool isUnavailable = false,
    bool isChosen = false,
    bool isExpanded = false,
  }) : super(
          id: id,
          title: title,
          isInner: isInner,
          isUnavailable: isUnavailable,
          isChosen: isChosen,
          isExpanded: isExpanded,
        );

  OrgUnitNode.sampleInner(OrgUnit ou,
      {bool isExpanded = false, bool isChosen = false})
      : super(
            id: ou.id,
            title: ou.name,
            isExpanded: isExpanded,
            isChosen: isExpanded,
            isShowedInSearching: false);

  OrgUnitNode.sampleLeaf(OrgUnit ou, {bool isChosen = false})
      : super(
            id: ou.id,
            title: ou.name,
            isInner: false,
            isChosen: isChosen,
            isShowedInSearching: true);

  @override
  T clone<T extends AbsNodeType>() {
    final node = OrgUnitNode(
      id: id,
      title: title,
      isInner: isInner,
      isUnavailable: isUnavailable,
      isChosen: isChosen!,
      isExpanded: isExpanded,
    );
    node.isBlurred = isBlurred;
    node.isFavorite = isFavorite;
    node.isShowedInSearching = isShowedInSearching;

    return node as T;
  }
}
//
// Future<TreeType<OrgUnitNode>> buildOrgUnitTree(int startLevel) async {
//   final List<OrgUnit> allUnits = [];
//
//   // final mapByParent = groupBy(allUnits, (u) => u.parentUid);
//   final Map<String?, List<OrgUnit>> mapByParent =
//       allUnits.groupListsBy((u) => u.parent);
//   TreeType<OrgUnitNode>? build(String? parentUid) {
//     final childrenDtos = mapByParent[parentUid] ?? [];
//     return TreeType(
//       data: OrgUnitNode(
//         id: parentUid ?? 'root',
//         name: parentUid == null
//             ? 'All Units'
//             : childrenDtos.firstWhere((d) => d.id == parentUid).name,
//         level: parentUid == null ? 0 : childrenDtos.first.level,
//         path: parentUid == null ? '' : childrenDtos.first.path,
//         hasChildren: childrenDtos.isNotEmpty,
//       ),
//       children: childrenDtos
//           .where((d) => d.level >= startLevel)
//           .map((d) => build(d.id)!)
//           .toList(),
//       parent: null,
//     );
//   }
//
//   return build(null)!;
// }
