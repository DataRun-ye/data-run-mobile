import 'package:flutter/material.dart';
import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';

/// This widget displays the whole tree using [SingleChildScrollView]
class OrgUnitTreeView<T extends AbsNodeType> extends StatefulWidget {
  const OrgUnitTreeView(
    this.tree, {
    super.key,
    required this.buildLeadingWidget,
    this.selectedIds = const [],
    this.singleChoice = true,
  });

  final TreeType<T> tree;
  final List<String> selectedIds;
  final FunctionBuildLeadingWidget<T> buildLeadingWidget;

  final bool singleChoice;

  @override
  State<OrgUnitTreeView<T>> createState() => _OrgUnitTreeViewState<T>();
}

class _OrgUnitTreeViewState<T extends AbsNodeType>
    extends State<OrgUnitTreeView<T>> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.selectedIds;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // initialize chosen state
        for (final id in _selectedIds) {
          final node = findTreeWithId(widget.tree, id);
          if (node != null) node.data.isChosen = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _OrgUnitNodeWidget<T>(
        widget.tree,
        onNodeDataChanged: () => setState(() {}),
        buildLeadingWidget: widget.buildLeadingWidget,
      ),
    );
  }
}

//? ____________________________________________________________________________

class _OrgUnitNodeWidget<T extends AbsNodeType> extends StatefulWidget {
  const _OrgUnitNodeWidget(
    this.tree, {
    required this.onNodeDataChanged,
    required this.buildLeadingWidget,
    this.singleChoice = true,
  });

  final TreeType<T> tree;

  /// IMPORTANT: Because this library **DOESN'T** use any state management
  /// library, therefore I need to use call back function like this - although
  /// it is more readable if using `Provider`.
  final VoidCallback onNodeDataChanged;
  final bool singleChoice;

  /// Each node has its own style of leading widget, root or inner node or leaf
  /// may have different UI.
  final FunctionBuildLeadingWidget<T> buildLeadingWidget;

  @override
  State<_OrgUnitNodeWidget<T>> createState() => _OrgUnitNodeWidgetState<T>();
}

class _OrgUnitNodeWidgetState<T extends AbsNodeType>
    extends State<_OrgUnitNodeWidget<T>>
    with SingleTickerProviderStateMixin, ExpandableTreeMixin<T> {
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
  void dispose() {
    super.disposeRotationController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => buildView();

  @override
  Widget buildNode() {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: widget.tree.data.isUnavailable ? null : updateStateToggleExpansion,
      child: Row(
        children: [
          widget.buildLeadingWidget(widget.tree, () => setState(() {})),
          //? Title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                widget.tree.data.title +
                    (widget.tree.isLeaf
                        ? ''
                        : ' (${widget.tree.children.length})'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          //? Check box
          Checkbox(
            tristate: !widget.tree.isLeaf,
            side: widget.tree.data.isUnavailable
                ? const BorderSide(color: Colors.grey, width: 1.0)
                : BorderSide(color: cs.primary, width: 1.0),
            value: widget.tree.data.isUnavailable
                ? false
                : widget.tree.data.isChosen,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            activeColor:
                widget.tree.data.isUnavailable ? Colors.grey : cs.primary,
            onChanged: widget.tree.data.isUnavailable
                ? null
                : (value) {
                    widget.tree.data.isChosen = value;
                    widget.singleChoice
                        ? updateTreeSingleChoice(widget.tree, value ?? false)
                        : updateTreeMultipleChoice(widget.tree, value);
                    widget.onNodeDataChanged();
                  },
          ),
        ],
      ),
    );
  }

  //? __________________________________________________________________________

  @override
  List<Widget> generateChildrenNodesWidget(List<TreeType<T>> list) =>
      List.generate(
        list.length,
        (int index) => _OrgUnitNodeWidget<T>(
          list[index],
          onNodeDataChanged: widget.onNodeDataChanged,
          buildLeadingWidget: widget.buildLeadingWidget,
          singleChoice: widget.singleChoice,
        ),
      );

  @override
  void updateStateToggleExpansion() => setState(() => toggleExpansion());
}
