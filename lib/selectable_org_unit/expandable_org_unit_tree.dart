import 'package:datarunmobile/selectable_org_unit/model/build_tree.dart';
import 'package:datarunmobile/selectable_org_unit/model/org_unit_node.dart';
import 'package:flutter/material.dart';
import 'package:recursive_tree_flutter/recursive_tree_flutter.dart';

/// A widget that displays an org-unit picker as a single tree under a dummy root.
/// Supports single- or multiple-choice via [singleChoice].
class OrgUnitPicker extends StatefulWidget {
  const OrgUnitPicker({
    Key? key,
    this.initialLeafIds = const [],
    this.singleChoice = false,
    required this.onSelectionChanged,
  }) : super(key: key);
  final List<String> initialLeafIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool singleChoice;

  @override
  _OrgUnitPickerState createState() => _OrgUnitPickerState();
}

class _OrgUnitPickerState extends State<OrgUnitPicker> {
  TreeType<OrgUnitNode>? _root;
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.of(widget.initialLeafIds);
    buildOrgUnitTree(_selectedIds).then((tree) {
      setState(() {
        _root = tree;
        // initialize chosen state
        for (final id in _selectedIds) {
          final node = findTreeWithId(_root!, id);
          if (node != null) node.data.isChosen = true;
        }
      });
    });
  }

  void _onLeafToggled(TreeType<OrgUnitNode> node) {
    if (_root == null) return;
    if (widget.singleChoice) {
      updateTreeSingleChoice(node, !node.data.isChosen!);
    } else {
      updateTreeMultipleChoice(node, !node.data.isChosen!,
          isUpdatingParentRecursion: true);
    }
    setState(() {
      final chosen = <String>[];
      final List<TreeType<OrgUnitNode>> chosenNodes = [];
      returnChosenLeaves<OrgUnitNode>(_root!, chosenNodes);
      chosenNodes.forEach((n) => chosen.add(n.data.id as String));
      widget.onSelectionChanged(chosen);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_root == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: ExpandableTreeWidget<OrgUnitNode>(_root!),
    );
  }
}
