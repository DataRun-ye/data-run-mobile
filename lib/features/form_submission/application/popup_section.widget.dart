// import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
// import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
// import 'package:datarunmobile/features/form_submission/application/form_widget_factory.dart';
// import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// class PopupSectionWidget extends StatefulHookConsumerWidget {
//   PopupSectionWidget({super.key, required this.element, String path = ''});
//
//   final Section element;
//
//   @override
//   PopupSectionWidgetState createState() => PopupSectionWidgetState();
// }
//
// class PopupSectionWidgetState extends ConsumerState<PopupSectionWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final formInstance = ref
//         .watch(
//         formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
//         .requireValue;
//     return ReactiveForm(
//       formGroup: formInstance.form.control(
//           widget.element.elementPath!) as FormGroup,
//       child: Column(
//         children: widget.element.elements.values.map((childElement) {
//           return PopupFormElementWidgetFactory.createWidget(
//               childElement, formInstance.fieldKeysRegistery);
//         }).toList(),
//       ),
//     );
//   }
// }
//
