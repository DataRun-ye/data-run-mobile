// import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
// import 'package:flutter/material.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// typedef ReactiveTableConsumerBuilder = Widget Function(
//     BuildContext context,
//     FormArray<Map<String, Object?>> formArray,
//     RepeatInstance repeat,
//     Widget? child);
//
// class ReactiveTableBuilder extends StatefulWidget {
//   final RepeatInstance repeatInstance;
//   final ReactiveTableConsumerBuilder builder;
//   final Widget? child;
//
//   const ReactiveTableBuilder({
//     super.key,
//     required this.repeatInstance,
//     required this.builder,
//     this.child,
//   });
//
//   @override
//   ReactiveTableBuilderState createState() => ReactiveTableBuilderState();
// }
//
// class ReactiveTableBuilderState extends State<ReactiveTableBuilder> {
//   late RepeatInstance _repeatInstance;
//   late FormArray<Map<String, Object?>> _formArray;
//
//   @override
//   void initState() {
//     _repeatInstance = widget.repeatInstance;
//     _formArray = _repeatInstance.elementControl;
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     _repeatInstance = widget.repeatInstance;
//     _formArray = _repeatInstance.elementControl;
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(
//       context,
//       ReactiveForm.of(context)! as FormArray<Map<String, Object?>>,
//       _repeatInstance,
//       widget.child,
//     );
//   }
// }
