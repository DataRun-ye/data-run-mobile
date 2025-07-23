import 'package:datarunmobile/app/theme/color_scheme_extension.dart';
import 'package:flutter/material.dart';
import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';

class OrgUnitSearchableTreeView<T extends AbsNodeType> extends StatefulWidget {
  const OrgUnitSearchableTreeView({
    Key? key,
    required this.tree,
    this.selectedIds = const [],
    this.singleChoice = true,
    required this.buildLeadingWidget,
  }) : super(key: key);

  final TreeType<T> tree;
  final List<String> selectedIds;
  final FunctionBuildLeadingWidget<T> buildLeadingWidget;

  final bool singleChoice;

  @override
  State<OrgUnitSearchableTreeView<T>> createState() =>
      _OrgUnitSearchableTreeViewState<T>();
}

class _OrgUnitSearchableTreeViewState<T extends AbsNodeType>
    extends State<OrgUnitSearchableTreeView<T>> {
  final TextEditingController _textController = TextEditingController();
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.selectedIds;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedIds.isNotEmpty) {
        setState(() {
          // initialize chosen state
          for (final id in _selectedIds) {
            final node = findTreeWithId(widget.tree, id);
            if (node != null) node.data.isChosen = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: OrgUnitNodeWidgetVts<T>(
                widget.tree,
                onNodeDataChanged: () => setState(() {}),
                buildLeadingWidget: widget.buildLeadingWidget,
                singleChoice: widget.singleChoice,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'PRESS ENTER TO UPDATE',
              ),
              onFieldSubmitted: (value) {
                updateTreeWithSearchingTitle(widget.tree, value);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

//? ____________________________________________________________________________

class OrgUnitNodeWidgetVts<T extends AbsNodeType> extends StatefulWidget {
  const OrgUnitNodeWidgetVts(
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
  State<OrgUnitNodeWidgetVts<T>> createState() => _OrgUnitNodeWidgetVtsState<T>();
}

class _OrgUnitNodeWidgetVtsState<T extends AbsNodeType>
    extends State<OrgUnitNodeWidgetVts<T>>
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
    if (!widget.tree.data.isShowedInSearching) return const SizedBox.shrink();
    if (widget.tree.isRoot) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        tree.isLeaf
            ? widget.singleChoice
                ? updateTreeSingleChoiceDms4(tree, !tree.data.isChosen!)
                : updateTreeMultipleChoice(tree, !(tree.data.isChosen ?? false))
            : updateStateToggleExpansion();
        widget.onNodeDataChanged();
      },
      child: Row(
        children: [
          Expanded(child: buildTitle()),
          buildRotationIcon(),
        ],
      ),
    );
  }

  //* __________________________________________________________________________

  Widget buildRotationIcon() {
    return tree.isLeaf
        ? Container()
        : IconButton(
            icon: RotationTransition(
              turns: Tween<double>(begin: -0.25, end: 0.0)
                  .animate(rotationController),
              child: const Icon(Icons.expand_more),
            ),
            onPressed: updateStateToggleExpansion,
          );
  }

  Widget buildTitle() {
    final ct = Theme.of(context).chipTheme;
    final isDark = Theme.of(context).colorScheme.isDark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: tree.data.isChosen == true
            ? ct.secondarySelectedColor
            : ct.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tree.data.title + (tree.isLeaf ? '' : ' (${tree.children.length})'),
            maxLines: 1,
            style: ct.secondaryLabelStyle,
            overflow: TextOverflow.ellipsis,
          ),
          buildCheckMark(),
        ],
      ),
    );
  }

  Widget buildCheckMark() {
    final ct = Theme.of(context).chipTheme;

    if (tree.data.isChosen == true) {
      return Icon(Icons.check, color: ct.checkmarkColor);
    } else {
      return const SizedBox.shrink();
    }
  }

  //* __________________________________________________________________________
  @override
  Widget buildChildrenNodes({final EdgeInsets? padding = const EdgeInsets.only(left: 24)}) {
    return SizeTransition(
      sizeFactor: rotationController,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(children: generateChildrenNodesWidget(tree.children)),
      ),
    );
  }

  @override
  List<Widget> generateChildrenNodesWidget(List<TreeType<T>> list) =>
      List.generate(
        list.length,
        (int index) => OrgUnitNodeWidgetVts<T>(
          list[index],
          onNodeDataChanged: widget.onNodeDataChanged,
          buildLeadingWidget: widget.buildLeadingWidget,
        ),
      );

  @override
  void updateStateToggleExpansion() => setState(() => toggleExpansion());
}
