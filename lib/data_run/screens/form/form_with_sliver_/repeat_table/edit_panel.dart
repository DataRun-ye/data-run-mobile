// import 'package:datarun/commons/custom_widgets/reactive_valid_button.dart';
// import 'package:datarun/data_run/screens/form/element/control_model/element_extended_control.dart';
// import 'package:datarun/data_run/screens/form/element/form_element.dart';
// import 'package:datarun/data_run/screens/form/element_widgets/form_widget_factory.dart';
// import 'package:datarun/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// enum EditActionType {
//   SAVE_AND_ADD_ANOTHER,
//   SAVE_AND_CLOSE,
//   SAVE_AND_EDIT_NEXT,
//   EXIT_WITHOUT_SAVING,
// }
//
// class EditPanel extends StatelessWidget {
//   final ElementExtendedControl control;
//   final String? title;
//   final void Function(FormGroup form, EditActionType action) onSave;
//
//   final RepeatInstance repeatInstance;
//
//   EditPanel(
//       {required this.repeatInstance,
//       required this.control,
//       this.title,
//       required this.onSave});
//
//   @override
//   Widget build(BuildContext context) {
//     final formGroup = ReactiveForm.of(context);
//     if (formGroup is! FormGroup) {
//       throw FormControlParentNotFoundException(this);
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const SizedBox(height: 10),
//           Text(title ?? S.of(context).edit),
//           const Divider(),
//           const SizedBox(height: 10),
//           Flexible(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: PopupFormElementWidgetFactory.createWidget(control.item),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ReactiveValidButton(
//                 label: Text(S.of(context).saveAndAddAnother),
//                 onPressed: () =>
//                     onSave(formGroup, EditActionType.SAVE_AND_ADD_ANOTHER),
//                 icon: Icon(MdiIcons.contentSavePlus),
//               ),
//               ReactiveValidButton(
//                 onPressed: () =>
//                     onSave(formGroup, EditActionType.SAVE_AND_CLOSE),
//                 label: Text(S.of(context).saveAndClose),
//                 icon: Icon(MdiIcons.contentSaveCheck),
//               ),
//               // ReactiveValidButton(
//               //   onPressed: () {
//               //     if(formGroup.dirty) {
//               //       onSave(formGroup, EditActionType.EXIT_WITHOUT_SAVING);
//               //     }
//               //     formGroup.markAllAsTouched();
//               //   },
//               //   label: Text(S.of(context).cancel),
//               //   icon: Icon(MdiIcons.contentSaveCheck),
//               // ),
//               // ElevatedButton.icon(
//               //   onPressed: () =>
//               //       onSave(formGroup, EditActionType.SAVE_AND_ADD_ANOTHER),
//               //   label: Text(S.of(context).saveAndAddAnother),
//               //   icon: Icon(MdiIcons.contentSavePlus),
//               // ),
//               // ElevatedButton.icon(
//               //   onPressed: () =>
//               //       onSave(formGroup, EditActionType.SAVE_AND_CLOSE),
//               //   label: Text(S.of(context).saveAndClose),
//               //   icon: Icon(MdiIcons.contentSaveCheck),
//               // ),
//               // ElevatedButton.icon(
//               //   onPressed: () =>
//               //       onSave(formGroup, EditActionType.SAVE_AND_EDIT_NEXT),
//               //   label: Text(S.of(context).saveAndEditNext),
//               //   icon: Icon(MdiIcons.contentSaveMove),
//               // ),
//             ],
//           ),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//
//     // return ReactiveFormBuilder(
//     //   form: () => control.itemFormGroup,
//     //   builder: (BuildContext context, FormGroup formGroup, Widget? child) {
//     //     return Padding(
//     //       padding: const EdgeInsets.all(16.0),
//     //       child: Column(
//     //         mainAxisSize: MainAxisSize.min,
//     //         children: <Widget>[
//     //           const SizedBox(height: 10),
//     //           Text(title ?? S.of(context).edit),
//     //           const Divider(),
//     //           const SizedBox(height: 10),
//     //           Flexible(
//     //             child: SingleChildScrollView(
//     //               child: Padding(
//     //                 padding: const EdgeInsets.all(8.0),
//     //                 child: PopupFormElementWidgetFactory.createWidget(
//     //                     control.item),
//     //               ),
//     //             ),
//     //           ),
//     //           const SizedBox(height: 20),
//     //           Row(
//     //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //             children: <Widget>[
//     //               ElevatedButton.icon(
//     //                 onPressed: () =>
//     //                     onSave(formGroup, EditActionType.SAVE_AND_ADD_ANOTHER),
//     //                 label: Text(S.of(context).saveAndAddAnother),
//     //                 icon: Icon(MdiIcons.contentSavePlus),
//     //               ),
//     //               ElevatedButton.icon(
//     //                 onPressed: () =>
//     //                     onSave(formGroup, EditActionType.SAVE_AND_CLOSE),
//     //                 label: Text(S.of(context).saveAndClose),
//     //                 icon: Icon(MdiIcons.contentSaveCheck),
//     //               ),
//     //               // ElevatedButton.icon(
//     //               //   onPressed: () =>
//     //               //       onSave(formGroup, EditActionType.SAVE_AND_EDIT_NEXT),
//     //               //   label: Text(S.of(context).saveAndEditNext),
//     //               //   icon: Icon(MdiIcons.contentSaveMove),
//     //               // ),
//     //             ],
//     //           ),
//     //           const SizedBox(height: 10),
//     //         ],
//     //       ),
//     //     );
//     //   },
//     // );
//   }
// }
