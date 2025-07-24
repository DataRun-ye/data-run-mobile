// import 'package:datarunmobile/commons/custom_widgets/reactive_valid_button.dart';
// import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
// import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
// import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
// import 'package:datarunmobile/features/form_submission/application/form_widget_factory.dart';
// import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
// import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
// import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
// import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
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
// class EditPanel extends ConsumerStatefulWidget {
//   EditPanel(
//       {required this.repeatInstance,
//       required this.item,
//       this.title,
//       required this.onSave});
//
//   final String? title;
//
//   final void Function(FormGroup form, EditActionType action) onSave;
//
//   final RepeatItemInstance item;
//
//   final RepeatSection repeatInstance;
//
//   @override
//   EditPanelState createState() => EditPanelState();
// }
//
// class EditPanelState extends ConsumerState<EditPanel> {
//   GlobalKey globalKey = GlobalKey();
//   late final ScrollController scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController = ScrollController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     scrollController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final formGroup = ReactiveForm.of(context);
//     final FormInstance formInstance = ref
//         .watch(
//             formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
//         .requireValue;
//
//     if (formGroup is! FormGroup) {
//       throw FormControlParentNotFoundException(widget);
//     }
//
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const SizedBox(height: 10),
//           Text(widget.title ?? S.of(context).edit),
//           const Divider(),
//           const SizedBox(height: 10),
//           Flexible(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: PopupFormElementWidgetFactory.createWidget(
//                     widget.item, formInstance.fieldKeysRegistery),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Wrap(
//             spacing: 4,
//             runSpacing: 4,
//             // runAlignment: WrapAlignment.center,
//             alignment: WrapAlignment.spaceBetween,
//             children: <Widget>[
//               ReactiveValidButton(
//                 color: cs.primary,
//                 onPressed: () =>
//                     widget.onSave(formGroup, EditActionType.SAVE_AND_CLOSE),
//                 label: Text(S.of(context).saveAndClose),
//                 toolTip: S.of(context).saveAndClose,
//                 icon: Icon(MdiIcons.contentSaveCheck),
//               ),
//               ReactiveValidButton(
//                 label: Text(S.of(context).addNew),
//                 onPressed: () => widget.onSave(
//                     formGroup, EditActionType.SAVE_AND_ADD_ANOTHER),
//                 icon: Icon(MdiIcons.contentSaveMove),
//                 color: cs.secondary,
//                 toolTip: S.of(context).addNew,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//         ],
//       ),
//     );
//   }
// }
