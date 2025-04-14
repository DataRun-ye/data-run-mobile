// import 'package:flutter/material.dart';
// import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
// import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node.dart';
//
// class TreeTile extends StatefulWidget {
//   const TreeTile({
//     super.key,
//     required this.entry,
//     required this.match,
//     required this.searchPattern,
//     this.onTap,
//     this.selectedColor,
//     this.isSelected = false,
//   });
//
//   final TreeEntry<TreeNode> entry;
//   final TreeSearchMatch? match;
//   final Pattern? searchPattern;
//   final void Function(String)? onTap;
//   final Color? selectedColor;
//
//   final bool isSelected;
//
//   @override
//   State<TreeTile> createState() => _TreeTileState();
// }
//
// class _TreeTileState extends State<TreeTile> {
//   late InlineSpan titleSpan;
//
//   TextStyle? dimStyle;
//   TextStyle? highlightStyle;
//
//   bool get shouldShowBadge =>
//       !widget.entry.isExpanded && (widget.match?.subtreeMatchCount ?? 0) > 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final _selectedColor = widget.selectedColor ?? Colors.blue.withOpacity(0.2);
//     final expandable = widget.entry.node.children.length > 0;
//     final expandIcon = switch (expandable) {
//       true => ExpandIcon(
//           key: GlobalObjectKey(widget.entry.node),
//           isExpanded: widget.entry.isExpanded,
//           onPressed: (_) => TreeViewScope.of<TreeNode>(context)
//             ..controller.toggleExpansion(widget.entry.node),
//         ),
//       _ => const SizedBox.shrink()
//     };
//
//     return TreeIndentation(
//       entry: widget.entry,
//       child: GestureDetector(
//         onTap: () {
//           if (expandable)
//             TreeViewScope.of<TreeNode>(context)
//               ..controller.toggleExpansion(widget.entry.node);
//           widget.onTap?.call(widget.entry.node.id!);
//         },
//         child: Card(
//           child: ListTile(
//             title: Container(
//               color: widget.isSelected
//                   ? _selectedColor // Highlight color
//                   : Colors.transparent, // Default background color
//               child: Row(
//                 children: [
//                   expandIcon,
//                   if (shouldShowBadge)
//                     Padding(
//                       padding: const EdgeInsetsDirectional.only(end: 8),
//                       child: Badge(
//                         label: Text('${widget.match?.subtreeMatchCount}'),
//                       ),
//                     ),
//                   Flexible(
//                     child: Text.rich(
//                       titleSpan,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     setupTextStyles();
//     titleSpan = buildTextSpan();
//   }
//
//   @override
//   void didUpdateWidget(covariant TreeTile oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.searchPattern != widget.searchPattern ||
//         oldWidget.entry.node.name != widget.entry.node.name) {
//       titleSpan = buildTextSpan();
//     }
//   }
//
//   void setupTextStyles() {
//     final TextStyle style = DefaultTextStyle.of(context).style;
//     final Color highlightColor = Theme.of(context).colorScheme.primary;
//     highlightStyle = style.copyWith(
//       color: highlightColor,
//       decorationColor: highlightColor,
//       decoration: TextDecoration.underline,
//     );
//     dimStyle = style.copyWith(color: style.color?.withAlpha(128));
//   }
//
//   InlineSpan buildTextSpan() {
//     final String title = widget.entry.node.name!;
//
//     if (widget.searchPattern == null) {
//       return TextSpan(text: title);
//     }
//
//     final List<InlineSpan> spans = <InlineSpan>[];
//     bool hasAnyMatches = false;
//
//     title.splitMapJoin(
//       widget.searchPattern!,
//       onMatch: (Match match) {
//         hasAnyMatches = true;
//         spans.add(TextSpan(text: match.group(0), style: highlightStyle));
//         return '';
//       },
//       onNonMatch: (String text) {
//         spans.add(TextSpan(text: text));
//         return '';
//       },
//     );
//
//     if (hasAnyMatches) {
//       return TextSpan(children: spans);
//     }
//
//     return TextSpan(text: title, style: dimStyle);
//   }
// }
