// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node_data_source.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/tree_tile.widget.dart';
// import 'package:datarunmobile/generated/l10n.dart';
//
// // The M3 sizes are coming from the tokens, but are hand coded,
// // as the current token DB does not contain landscape versions.
// // const Size _inputPortraitDialogSizeM2 = Size(330.0, 470.0);
// // const Size _inputPortraitDialogSizeM3 = Size(328.0, 470.0);
// // const Size _inputLandscapeDialogSize = Size(496, 160.0);
// // const double _kMaxTextScaleFactor = 1.3;
//
// class OrgUnitPickerDialog extends ConsumerStatefulWidget {
//   const OrgUnitPickerDialog(
//       {super.key,
//       required this.dataSource,
//       this.onChange,
//       this.initialNode,
//       this.restorationId,
//       this.cancelText,
//       this.confirmText,
//       this.helpText});
//
//   final TreeNodeDataSource dataSource;
//
//   final void Function(String?)? onChange;
//
//   final String? restorationId;
//
//   final String? initialNode;
//
//   /// The text that is displayed on the cancel button.
//   final String? cancelText;
//
//   /// The text that is displayed on the confirm button.
//   final String? confirmText;
//
//   /// The text that is displayed at the top of the header.
//   ///
//   /// This is used to indicate to the user what they are selecting a date for.
//   final String? helpText;
//
//   // final TextEditingController? controller;
//
//   @override
//   ConsumerState<OrgUnitPickerDialog> createState() =>
//       _OrgUnitPickerDialogState();
// }
//
// class _OrgUnitPickerDialogState
//     extends ConsumerState<OrgUnitPickerDialog> /*with RestorationMixin*/ {
//   late TextEditingController _textFieldController = TextEditingController();
//
//   late final TreeController<TreeNode> treeController;
//
//   TreeSearchResult<TreeNode>? filter;
//   Pattern? searchPattern;
//
//   String? _selectedNode;
//
//   // late final RestorableStringN _selectedNode =
//   //     RestorableStringN(widget.initialNode);
//
//   final GlobalKey _nodePickerKey = GlobalKey();
//   final GlobalKey _searchFieldKey = GlobalKey();
//
//   // @override
//   // String? get restorationId => widget.restorationId;
//
//   // @override
//   // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//   //   registerForRestoration(_selectedNode, 'selected_tree_node_id');
//   //   // if (widget.initialNode != null) {
//   //   _selectedNode.value = widget.initialNode;
//   //   // }
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // // if (widget.initialNode != null) {
//     _selectedNode = widget.initialNode;
//     // // }
//
//     treeController = TreeController<TreeNode>(
//       roots: widget.dataSource.getRoots(),
//       childrenProvider: getChildren,
//       parentProvider: (node) => _getNode(node.parent),
//     )..collapseAll();
//     _textFieldController.addListener(onSearchQueryChanged);
//   }
//
//   @override
//   void dispose() {
//     filter = null;
//     searchPattern = null;
//     treeController.dispose();
//     _textFieldController.dispose();
//     // _selectedNode.dispose();
//     super.dispose();
//   }
//
//   // Size _dialogSize(BuildContext context) {
//   //   final bool useMaterial3 = Theme.of(context).useMaterial3;
//   //   final Orientation orientation = MediaQuery.orientationOf(context);
//   //
//   //   return switch (orientation) {
//   //     (Orientation.portrait) when useMaterial3 => _inputPortraitDialogSizeM3,
//   //     (Orientation.portrait) => _inputPortraitDialogSizeM2,
//   //     (Orientation.landscape) => _inputLandscapeDialogSize,
//   //   };
//   // }
//
//   void _handleOk() {
//     Navigator.pop(context, _selectedNode);
//     // Navigator.pop(context, _getNode(_selectedNode));
//   }
//
//   void _handleCancel() {
//     Navigator.pop(context);
//   }
//
//   void _handleNodeChanged(String id) {
//     final isSelectable = _isSelectable(id);
//     if (isSelectable) _vibrate();
//     setState(() {
//       logDebug('is Selectable: ${_isSelectable(id)}');
//       if (isSelectable) {
//         _selectedNode = id;
//         widget.onChange?.call(id);
//       }
//     });
//   }
//
//   Iterable<TreeNode> getChildren(TreeNode node) {
//     if (filter case TreeSearchResult<TreeNode> filter?) {
//       return node.children.where(filter.hasMatch);
//     }
//     return node.children;
//   }
//
//   void search(String query) {
//     filter = null;
//
//     Pattern pattern;
//     try {
//       pattern = RegExp(query, caseSensitive: false); // case-insensitive search
//     } on FormatException {
//       pattern = query;
//     }
//     searchPattern = pattern;
//
//     filter = treeController.search((TreeNode node) {
//       // Check if either `code` or `name` contains the search pattern
//       return node.id?.contains(pattern) == true ||
//           node.id?.contains(pattern) == true;
//     });
//
//     treeController.rebuild();
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   void clearSearch() {
//     if (filter == null) return;
//
//     setState(() {
//       filter = null;
//       searchPattern = null;
//       treeController.rebuild();
//       _textFieldController.clear();
//     });
//   }
//
//   void onSearchQueryChanged() {
//     final String query = _textFieldController.text.trim();
//
//     if (query.isEmpty) {
//       clearSearch();
//       return;
//     }
//
//     search(query);
//   }
//
//   TreeNode? _getNode(String? uid) {
//     return widget.dataSource.getNode(uid);
//   }
//
//   bool _isSelectable(String id) {
//     final node = _getNode(id);
//     return node!.selectable;
//   }
//
//   void _vibrate() {
//     switch (Theme.of(context).platform) {
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         HapticFeedback.vibrate();
//       case TargetPlatform.iOS:
//       case TargetPlatform.macOS:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final bool useMaterial3 = theme.useMaterial3;
//     final MaterialLocalizations localizations =
//         MaterialLocalizations.of(context);
//     final DatePickerThemeData datePickerTheme = DatePickerTheme.of(context);
//     final DatePickerThemeData defaults = DatePickerTheme.defaults(context);
//     // const double fontSizeToScale = 14.0;
//     // final double textScaleFactor = MediaQuery.textScalerOf(context)
//     //         .clamp(maxScaleFactor: _kMaxTextScaleFactor)
//     //         .scale(fontSizeToScale) /
//     //     fontSizeToScale;
//     // final Size dialogSize = _dialogSize(context) * textScaleFactor;
//
//     final Widget actions = Container(
//       alignment: AlignmentDirectional.centerEnd,
//       constraints: const BoxConstraints(minHeight: 52.0),
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: OverflowBar(
//         spacing: 8,
//         children: <Widget>[
//           TextButton(
//             style:
//                 datePickerTheme.cancelButtonStyle ?? defaults.cancelButtonStyle,
//             onPressed: _handleCancel,
//             child: Text(widget.cancelText ??
//                 (useMaterial3
//                     ? localizations.cancelButtonLabel
//                     : localizations.cancelButtonLabel.toUpperCase())),
//           ),
//           TextButton(
//             style: datePickerTheme.confirmButtonStyle ??
//                 defaults.confirmButtonStyle,
//             onPressed: _handleOk,
//             child: Text(widget.confirmText ?? localizations.okButtonLabel),
//           ),
//         ],
//       ),
//     );
//
//     Widget _buildSearchField() {
//       return SearchBar(
//         key: _searchFieldKey,
//         controller: _textFieldController,
//         hintText: S.of(context).searchOrgUnitsHelpText,
//         leading: const Padding(
//           padding: EdgeInsets.all(8),
//           child: Icon(Icons.filter_list),
//         ),
//         trailing: [
//           Badge(
//             isLabelVisible: filter != null,
//             label: Text(
//               '${filter?.totalMatchCount}/${filter?.totalNodeCount}',
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.clear),
//             onPressed: clearSearch,
//           )
//         ],
//       );
//     }
//
//     Widget _buildTreeNodes() {
//       return Container(
//         constraints: const BoxConstraints(maxHeight: 300),
//         child: AnimatedTreeView<TreeNode>(
//           key: _nodePickerKey,
//           treeController: treeController,
//           nodeBuilder: (BuildContext context, TreeEntry<TreeNode> entry) {
//             return TreeTile(
//               entry: entry,
//               match: filter?.matches[entry.node],
//               searchPattern: searchPattern,
//               onTap: _handleNodeChanged,
//               isSelected: entry.node.id == _selectedNode,
//             );
//           },
//           duration: const Duration(milliseconds: 300),
//         ),
//       );
//     }
//
//     // Widget _buildTreeView() {
//     //   return Container(
//     //     width: dialogSize.width,
//     //     height: dialogSize.height,
//     //     decoration: BoxDecoration(
//     //       color: Colors.white,
//     //       borderRadius: BorderRadius.circular(12),
//     //       boxShadow: [
//     //         BoxShadow(
//     //           color: Colors.black12,
//     //           blurRadius: 8,
//     //           offset: Offset(0, 4),
//     //         ),
//     //       ],
//     //     ),
//     //     child: ClipRRect(
//     //       borderRadius: BorderRadius.circular(12),
//     //       child: Column(
//     //         children: [],
//     //       ),
//     //     ),
//     //   );
//     // }
//
//     return Column(
//       children: [
//         _buildSearchField(),
//         const SizedBox(
//           height: 32,
//         ),
//         Expanded(child: _buildTreeNodes()),
//         const SizedBox(
//           height: 32,
//         ),
//         actions,
//       ],
//     );
//   }
// }
