import 'package:d_sdk/database/app_database.dart';
import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';

/// Wraps OrgUnit Drift data in an AbsNodeType so it be part of
/// the tree node picker.
class OrgUnitNode extends AbsNodeType {
  OrgUnitNode(this.org)
      : super(
          id: org.id,
          title: org.name,
          isInner: true,
          // assume inner; we’ll flip to false if no children
          isUnavailable: false,
          isChosen: false,
          isExpanded: false,
          isFavorite: false,
          isShowedInSearching: true,
          isBlurred: false,
        );
  final OrgUnit org;

  @override
  T clone<T extends AbsNodeType>() {
    final copy = OrgUnitNode(org)..title = title;
    copy.isInner = isInner;
    copy.isChosen = isChosen;
    copy.isExpanded = isExpanded;
    copy.isUnavailable = isUnavailable;
    copy.isFavorite = isFavorite;
    return copy as T;
  }
}
