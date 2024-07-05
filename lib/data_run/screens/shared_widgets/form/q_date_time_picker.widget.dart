import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mass_pro/commons/date/date_utils.dart' as sdk;
import 'package:mass_pro/commons/extensions/string_extension.dart';
import 'package:mass_pro/data_run/screens/form/form_state/q_field.model.dart';
import 'package:mass_pro/sdk/core/common/value_type.dart';

class QDateTimePicker extends StatelessWidget {
  const QDateTimePicker({super.key, required this.fieldModel});

  final QFieldModel fieldModel;

  @override
  Widget build(BuildContext context) {
    final inputType = fieldModel.valueType == ValueType.Date
        ? InputType.date
        : fieldModel.valueType == ValueType.Time
            ? InputType.time
            : InputType.both;
    return FormBuilderDateTimePicker(
      key: ValueKey(fieldModel.uid),
      // format: sdk.DateUtils.uiDateFormat(),
      initialValue: fieldModel.value.toDate(),
      name: fieldModel.uid,
      enabled: fieldModel.isEditable,
      validator:
          fieldModel.isMandatory ? FormBuilderValidators.required() : null,
      initialEntryMode: DatePickerEntryMode.calendar,
      inputType: inputType,
      onFieldSubmitted: (DateTime? pickedDate) {
        if (pickedDate != null) {
          debugPrint(
              '####Debug FormBuilderDateTimePicker.onFieldSubmitted: $pickedDate');
          fieldModel.onTextChange(
              sdk.DateUtils.databaseDateFormat().format(pickedDate));
        }
      },
      onChanged: (DateTime? pickedDate) {
        if (pickedDate != null) {
          fieldModel.onSaveOption(
              sdk.DateUtils.databaseDateFormatNoZone().format(pickedDate));
        } else {
          fieldModel.onSaveOption(null);
        }
      },
      decoration: InputDecoration(
        labelText: fieldModel.label,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        suffixIcon: (fieldModel.value ?? '').isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: fieldModel.onClear,
              )
            : null,
      ),
    );
  }
}