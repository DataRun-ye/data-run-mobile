// import 'package:flutter/material.dart';
// class OrgUnitPickerField extends StatefulWidget {
//   const OrgUnitPickerField(
//       {Key? key,
//       this.initialValueUid,
//       this.onSubmitted,
//       this.errorInvalidText,
//       this.fieldHintText,
//       this.labelText,
//       this.onChanged,
//       this.focusNode,
//       this.decoration = const InputDecoration(),
//       this.enabled = true,
//       this.onSaved})
//       : super(key: key);
//
//   final String? initialValueUid;
//   final ValueChanged<String?>? onSubmitted;
//
//   final InputDecoration decoration;
//   final ValueChanged<String?>? onSaved;
//   final ValueChanged<String?>? onChanged;
//
//   final String? errorInvalidText;
//   final String? fieldHintText;
//
//   final String? labelText;
//
//   final bool enabled;
//
//   final FocusNode? focusNode;
//
//   @override
//   _OrgUnitPickerFieldState createState() => _OrgUnitPickerFieldState();
// }
//
// class _OrgUnitPickerFieldState extends State<OrgUnitPickerField/*<T>*/ > {
//   late final TextEditingController _controller;
//   String? _selectedNode;
//
//   TreeNode? _getNode(String? uid) {
//     return widget.dataSource.getNode(uid);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.initialValueUid == null &&
//         widget.dataSource.getSelectableNodesUids().length == 1) {
//       _selectedNode = widget.dataSource.getSelectableNodesUids().first;
//     } else {
//       _selectedNode = widget.initialValueUid;
//     }
//
//     _controller = TextEditingController();
//     final node = _getNode(_selectedNode);
//     _controller.text = node?.displayName ?? node?.name ?? '';
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didUpdateWidget(OrgUnitPickerField oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.initialValueUid != oldWidget.initialValueUid) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         setState(() {
//           _selectedNode = widget.initialValueUid;
//           final node = _getNode(_selectedNode);
//           _controller.text =
//               _selectedNode == null ? '' : (node?.displayName ?? node?.name)!;
//         });
//         widget.onChanged?.call(_selectedNode);
//         widget.onSubmitted?.call(_selectedNode);
//       });
//     }
//   }
//
//   void _clearValue() {
//     setState(() {
//       _controller.text = '';
//       _selectedNode = null;
//     });
//     widget.onChanged?.call(null);
//     widget.onSubmitted?.call(null);
//   }
//
//   Future<void> onShowPicker() async {
//     final selectedOrgUnit = await _showOrgUnitPickerDialog(_selectedNode);
//
//     if (selectedOrgUnit != null) {
//       final node = _getNode(selectedOrgUnit);
//       setState(() {
//         _controller.text = node!.displayName ?? node.name ?? '';
//         _selectedNode = selectedOrgUnit;
//       });
//       widget.onChanged?.call(selectedOrgUnit);
//       widget.onSubmitted?.call(selectedOrgUnit);
//     }
//   }
//
//   Future<String?> _showOrgUnitPickerDialog(String? currentValue) async {
//     return showDialog<String?>(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: OrgUnitPickerDialog(
//             cancelText: S.of(context).cancel,
//             confirmText: S.of(context).confirm,
//             dataSource: widget.dataSource,
//             initialNode: currentValue,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final bool useMaterial3 = theme.useMaterial3;
//     final DatePickerThemeData datePickerTheme = theme.datePickerTheme;
//     // final InputDecorationTheme inputTheme = theme.inputDecorationTheme;
//     final effectiveDecoration =
//         widget.decoration.applyDefaults(theme.inputDecorationTheme);
//
//     final InputBorder effectiveInputBorder =
//         datePickerTheme.inputDecorationTheme?.border ??
//             theme.inputDecorationTheme.border ??
//             (useMaterial3
//                 ? const OutlineInputBorder()
//                 : const UnderlineInputBorder());
//
//     return TextField(
//       enabled: widget.enabled,
//       readOnly: true,
//       decoration: effectiveDecoration.copyWith(
//           enabled: widget.enabled,
//           isDense: true,
//           suffixIcon: _selectedNode != null
//               ? IconButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: _clearValue,
//                   icon: Icon(Icons.close))
//               : null,
//           prefixIcon: Icon(Icons.account_tree),
//           errorText: widget.errorInvalidText,
//           hintText: widget.fieldHintText ?? S.of(context).orgUnitHelpText,
//           labelText: widget.labelText ?? S.of(context).orgUnitInputLabel),
//       controller: _controller,
//       focusNode: widget.focusNode,
//       style: Theme.of(context).textTheme.bodyMedium,
//       onTap: onShowPicker,
//     );
//   }
// }
