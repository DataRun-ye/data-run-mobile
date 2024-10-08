// import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:mass_pro/data_run/utils/get_item_local_string.dart';
//
// class QChoiceChip extends StatefulWidget {
//   const QChoiceChip({super.key, required this.fieldModel});
//
//   final QFieldModel fieldModel;
//
//   @override
//   State<QChoiceChip> createState() => _QChoiceChipState();
// }
//
// class _QChoiceChipState extends State<QChoiceChip> {
//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderChoiceChip<FormOption>(
//       key: ValueKey(widget.fieldModel.name),
//       valueTransformer: (FormOption? option) => option?.name,
//       selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
//       onReset: () => widget.fieldModel.onClear(),
//       name: widget.fieldModel.name,
//       enabled: widget.fieldModel.disabled,
//       validator: widget.fieldModel.isMandatory
//           ? FormBuilderValidators.required()
//           : null,
//       initialValue: widget.fieldModel.getOption(),
//       options: _getChipOptions(
//           widget.fieldModel.optionConfiguration!.optionsToDisplay,
//           wide: false),
//       onChanged: (FormOption? value) {
//         widget.fieldModel.onSaveOption(value);
//       },
//       decoration: InputDecoration(
//         border: const OutlineInputBorder(gapPadding: 20),
//         contentPadding: const EdgeInsets.all(16),
//         labelText: widget.fieldModel.formattedLabel,
//         labelStyle: Theme.of(context).textTheme.titleLarge,
//         // fillColor: Colors.red.shade200,
//       ),
//     );
//   }
//
//   List<FormBuilderChipOption<FormOption>> _getChipOptions(
//       List<FormOption> options,
//       {bool? wide}) {
//
//     return options!.map((FormOption option) => FormBuilderChipOption<FormOption>(
//               value: option,
//               child: wide ?? false
//                   ? Container(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Column(children: <Widget>[
//                         Text(getItemLocalString(option.label))
//                       ]))
//                   : Text(getItemLocalString(option.label)),
//             )).toList();
//   }
// }
