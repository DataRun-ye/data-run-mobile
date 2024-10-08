import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mass_pro/commons/prefs/preference_provider.dart';
import 'package:mass_pro/main.reflectable.dart';
import 'package:mass_pro/temp_testing/main_app_tree.dart';
import 'package:mass_pro/tree_examples/custom_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

const showSnackBar = true;
const expandChildrenOnReady = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();

  await PreferenceProvider.initialize();

  await D2Remote.initialize(
      /*
      databaseFactory: kIsWeb ? databaseFactoryFfiWeb : null*/
      );
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyNewApp());
}

class TreeViwPage1 extends StatefulWidget {
  const TreeViwPage1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  TreeViwPage1State createState() => TreeViwPage1State();
}

class TreeViwPage1State extends State<TreeViwPage1> {
  TreeViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: sampleTree.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (sampleTree.isExpanded) {
                _controller?.collapseNode(TreeNode(key: '0C1C2A3A'));
              } else {
                _controller?.expandAllChildren(sampleTree);
              }
            },
            label: isExpanded
                ? const Text('Collapse all')
                : const Text('Expand all'),
          );
        },
      ),
      body: TreeView.simple(
        tree: sampleTree,
        showRootNode: true,
        expansionIndicatorBuilder: (context, node) =>
            ChevronIndicator.rightDown(
          tree: node,
          color: Colors.blue[700],
          padding: const EdgeInsets.all(8),
        ),
        indentation: const Indentation(style: IndentStyle.squareJoint),
        onItemTap: (item) {
          if (kDebugMode) print('Item tapped: ${item.key}');

          if (showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item tapped: ${item.key}'),
                duration: const Duration(milliseconds: 750),
              ),
            );
          }
        },
        onTreeReady: (controller) {
          _controller = controller;
          if (expandChildrenOnReady) controller.expandAllChildren(sampleTree);
        },
        builder: (context, node) => Card(
          color: colorMapper[node.level.clamp(0, colorMapper.length - 1)],
          child: ListTile(
            title: CustomFields(),
            // subtitle: Text('Level ${node.level}'),
          ),
        ),
      ),
    );
  }
}

final sampleTree = TreeNode.root()
  ..addAll([
    TreeNode(key: '0A')..add(TreeNode(key: '0A1A')),
    TreeNode(key: '0C')
      ..addAll([
        TreeNode(key: '0C1A'),
        TreeNode(key: '0C1B'),
        TreeNode(key: '0C1C')
          ..addAll([
            TreeNode(key: '0C1C2A')
              ..addAll([
                TreeNode(key: '0C1C2A3A'),
                TreeNode(key: '0C1C2A3B'),
                TreeNode(key: '0C1C2A3C'),
              ]),
          ]),
      ]),
    TreeNode(key: '0D'),
    TreeNode(key: '0E'),
  ]);

final Map<int, Color> colorMapper = {
  0: Colors.white,
  1: Colors.blueGrey[50]!,
  2: Colors.blueGrey[100]!,
  3: Colors.blueGrey[200]!,
  4: Colors.blueGrey[300]!,
  5: Colors.blueGrey[400]!,
  6: Colors.blueGrey[500]!,
  7: Colors.blueGrey[600]!,
  8: Colors.blueGrey[700]!,
  9: Colors.blueGrey[800]!,
  10: Colors.blueGrey[900]!,
};

extension ColorUtil on Color {
  Color byLuminance() =>
      computeLuminance() > 0.4 ? Colors.black87 : Colors.white;
}
