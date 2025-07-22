import 'package:datarunmobile/selectable_org_unit/model/org_unit_node.dart';
import 'package:flutter/material.dart';
import 'package:recursive_tree_flutter/functions/tree_update_functions.dart';
import 'package:recursive_tree_flutter/models/abstract_node_type.dart';
import 'package:recursive_tree_flutter/models/tree_type.dart';
import 'package:recursive_tree_flutter/views/expandable_tree_mixin.dart';

class OrgUnitNodeWidget extends StatefulWidget {
  const OrgUnitNodeWidget(
    this.tree, {
    required this.onNodeDataChanged,
  });

  final TreeType<OrgUnitNode> tree;

  /// IMPORTANT: Because this library **DOESN'T** use any state management
  /// library, therefore I need to use call back function like this - although
  /// it is more readable if using `Provider`.
  final VoidCallback onNodeDataChanged;

  @override
  State<OrgUnitNodeWidget> createState() => _OrgUnitNodeWidgetState();
}

class _OrgUnitNodeWidgetState<T extends AbsNodeType>
    extends State<OrgUnitNodeWidget>
    with SingleTickerProviderStateMixin, ExpandableTreeMixin<OrgUnitNode> {
  final Tween<double> _turnsTween = Tween<double>(begin: -0.25, end: 0.0);

  @override
  initState() {
    super.initState();
    initTree();
    initRotationController();
    if (tree.data.isExpanded) {
      rotationController.forward();
    }
  }

  @override
  void initTree() {
    tree = widget.tree;
  }

  @override
  void initRotationController() {
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant OrgUnitNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (tree.data.isExpanded) {
      rotationController.forward();
    } else {
      rotationController.reverse();
    }
  }

  @override
  void dispose() {
    super.disposeRotationController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => buildView();

  @override
  Widget buildNode() {
    if (!widget.tree.data.isShowedInSearching) return const SizedBox.shrink();

    return InkWell(
      onTap: updateStateToggleExpansion,
      child: Row(
        children: [
          buildRotationIcon(),
          Expanded(child: buildTitle()),
          buildTrailing(),
        ],
      ),
    );
  }

  //* __________________________________________________________________________

  Widget buildRotationIcon() {
    return RotationTransition(
      turns: _turnsTween.animate(rotationController),
      child: tree.isLeaf
          ? Container()
          : IconButton(
              iconSize: 16,
              icon: const Icon(Icons.expand_more, size: 16.0),
              onPressed: updateStateToggleExpansion,
            ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        tree.data.title + (tree.isLeaf ? '' : ' (${tree.children.length})'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: tree.data.isBlurred ? Colors.grey : Colors.black,
            ),
      ),
    );
  }

  Widget buildTrailing() {
    if (tree.data.isUnavailable) {
      return const Icon(Icons.close_rounded, color: Colors.red);
    }

    if (tree.isLeaf) {
      return Checkbox(
        value: tree.data.isChosen, // leaves always is true or false
        onChanged: (value) {
          updateTreeSingleChoice(tree, !tree.data.isChosen!);
          widget.onNodeDataChanged();
        },
      );
    }

    return const SizedBox.shrink();
  }

  //* __________________________________________________________________________

  @override
  List<Widget> generateChildrenNodesWidget(List<TreeType<OrgUnitNode>> list) =>
      List.generate(
        list.length,
        (int index) => OrgUnitNodeWidget(
          list[index],
          onNodeDataChanged: widget.onNodeDataChanged,
        ),
      );

  // /// Toggle selection of a leaf node
  // void _onLeafToggled(TreeType<OrgUnitNode> node) {
  //   final id = node.data.id as String;
  //   setState(() {
  //     if (_selectedIds.contains(id)) {
  //       _selectedIds.remove(id);
  //       node.data.isChosen = false;
  //     } else {
  //       _selectedIds.add(id);
  //       node.data.isChosen = true;
  //     }
  //     widget.onSelectionChanged(_selectedIds);
  //   });
  // }

  @override
  void updateStateToggleExpansion() => setState(() => toggleExpansion());
}
