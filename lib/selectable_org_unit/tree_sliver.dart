// import 'package:flutter/material.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:flutter/rendering.dart';
//
// /// A slick, reusable reactive form field for picking a single leaf node from a TreeSliver.
// class ReactiveTreePickerField<T> extends ReactiveFormField<T, T> {
//   ReactiveTreePickerField({
//     Key? key,
//     required String formControlName,
//     required this.nodes,
//     this.controller,
//     this.searchHint = 'Search…',
//     this.dialogTitle = 'Select Item',
//     this.hintText,
//     this.dialogHeight = 400,
//   }) : super(
//     key: key,
//     formControlName: formControlName,
//     builder: (field) {
//       final state = field as _ReactiveTreePickerFieldState<T>;
//       return InputDecorator(
//         decoration: InputDecoration(
//           hintText: hintText,
//           errorText: field.errorText,
//           suffixIcon: const Icon(Icons.arrow_drop_down),
//           filled: true,
//           fillColor: Colors.grey.shade50,
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         isEmpty: field.value == null,
//         child: InkWell(
//           onTap: state._openDialog,
//           child: Text(
//             field.value?.toString() ?? '',
//             style: TextStyle(
//               color: field.value == null
//                   ? Colors.grey.shade600
//                   : Colors.black,
//             ),
//           ),
//         ),
//       );
//     },
//   );
//
//   /// Pre-built tree structure for display.
//   final List<TreeSliverNode<T>> nodes;
//   final TreeSliverController? controller;
//   final String searchHint;
//   final String dialogTitle;
//   final String? hintText;
//   final double dialogHeight;
//
//   @override
//   ReactiveFormFieldState<T, T> createState() => _ReactiveTreePickerFieldState<T>();
// }
//
// class _ReactiveTreePickerFieldState<T>
//     extends ReactiveFormFieldState<T, T> {
//   late final TreeSliverController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = (widget as ReactiveTreePickerField<T>).controller ??
//         TreeSliverController();
//   }
//
//   Future<void> _openDialog() async {
//     final picker = widget as ReactiveTreePickerField<T>;
//     // Local variable moved outside the builder to persist state
//     T? selected;
//
//     final key = GlobalKey();
//     final sliverKey = GlobalKey();
//     final result = await showModalBottomSheet<T>(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//       builder: (ctx) => SafeArea(
//         child: StatefulBuilder(
//           builder: (c, setState) {
//             return FractionallySizedBox(
//               heightFactor: 0.7,
//               child: Container(
//                 height: picker.dialogHeight,
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Column(
//                   children: [
//                     // Header
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(picker.dialogTitle,
//                               style: Theme.of(c).textTheme.headlineMedium),
//                           IconButton(
//                             icon: const Icon(Icons.close),
//                             onPressed: () => Navigator.of(ctx).pop(),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Search placeholder
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: picker.searchHint,
//                           prefixIcon: const Icon(Icons.search),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                         ),
//                         onChanged: (q) {
//                           // TODO: implement filtering
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // TreeSliver
//                     Expanded(
//                       child: CustomScrollView(
//                         key: key,
//                         slivers: [
//                           TreeSliver<T>(
//                             key: sliverKey,
//                             tree: picker.nodes,
//                             controller: _controller,
//                             treeNodeBuilder: (BuildContext context,
//                                 TreeSliverNode<Object?> node,
//                                 AnimationStyle anim) {
//                               final content = node.content as T;
//                               final isLeaf = node.children.isEmpty;
//                               final base = TreeSliver.defaultTreeNodeBuilder(
//                                   context, node, anim);
//                               final isSelected = selected == content;
//                               return GestureDetector(
//                                 onTap: isLeaf
//                                     ? () => setState(() {
//                                   selected = content;
//                                 })
//                                     : null,
//                                 child: DecoratedBox(
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? Theme.of(context).primaryColorLight
//                                         : Colors.transparent,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Expanded(child: base),
//                                       if (isLeaf)
//                                         Padding(
//                                           padding:
//                                           const EdgeInsets.only(right: 8),
//                                           child: Icon(
//                                             isSelected
//                                                 ? Icons.check_circle
//                                                 : Icons.radio_button_unchecked,
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Action buttons
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () => Navigator.of(ctx).pop(),
//                               child: const Text('Cancel'),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: selected == null
//                                   ? null
//                                   : () => Navigator.of(ctx).pop(selected),
//                               child: const Text('OK'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//
//     if (result != null) {
//       control.value = result;
//       control.markAsTouched();
//     }
//   }
// }
//
// // Usage demo remains unchanged
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Tree Picker Demo')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ReactiveForm(
//             formGroup: FormGroup({'unit': FormControl<String>(value: null)}),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ReactiveTreePickerField<String>(
//                   formControlName: 'unit',
//                   hintText: 'Choose a fruit',
//                   dialogTitle: 'Select a Fruit',
//                   nodes: <TreeSliverNode<String>>[
//                     TreeSliverNode('Citrus', children: [
//                       TreeSliverNode('Orange'),
//                       TreeSliverNode('Lemon'),
//                     ], expanded: true),
//                     TreeSliverNode('Berries', children: [
//                       TreeSliverNode('Strawberry'),
//                       TreeSliverNode('Blueberry'),
//                     ]),
//                     TreeSliverNode('Tropical', children: [
//                       TreeSliverNode('Mango'),
//                       TreeSliverNode('Pineapple'),
//                     ]),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ReactiveFormConsumer(
//                   builder: (context, form, child) {
//                     final val = form.control('unit').value;
//                     return Text('Selected: ${val ?? 'none'}');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
